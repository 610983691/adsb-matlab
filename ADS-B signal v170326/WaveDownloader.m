classdef WaveDownloader < handle
    %WAVEDOWNLOADER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        durationTime
        fs=30e6
        
        refPower
        
        rxTime 
        bitStream 
        rxPower
        rxFrqOffset
        
        ip4438
        
        io
    end
    
    methods
        function obj = WaveDownloader(durationTime)
            obj.durationTime=durationTime;
            addpath '.\WaveformDownloadAssistant_v2'
        end
        
        function obj = downloadMessages(obj,msgs)
            [obj.rxTime obj.bitStream obj.rxPower obj.rxFrqOffset] = sortByRxtime(msgs);
            obj.refPower=ceil(max(obj.rxPower));
            
        end
        
        function obj = playWave(obj, iwr, dp)
            
%             obj.initialInstrument('192.168.1.16');
            obj.initialInstrument(obj.ip4438);
            
            time=0;
            
            % No interweave exist.
            if iwr == 0
                h = waitbar(0, '已完成 ', 'Name', '下载进度');
                for i=1:length(obj.rxTime)
                    wave=gen1090Baseband( ...
                        obj.bitStream{i}, ...
                        2*pi*rand(1,1), ...
                        obj.rxFrqOffset(i), ...
                        obj.fs);
                    point=round((obj.rxTime(i)-time)*obj.fs);
                    obj.downloadWave(['adsb' num2str(i)],[zeros(1,mod(point,100)) 10^((obj.rxPower(i)-obj.refPower)/20).*wave]);
                    str = ['已完成', num2str(int64((i/length(obj.rxTime))*100)), '%，请稍等...'];
                    waitbar(i/length(obj.rxTime), h, str);
                    time=obj.rxTime(i)+112e-6;
                end
                
                delete(h);
                
                seq = obj.genSequence();
                
                obj.runInstrument(seq);
            
                obj.closeInstrument();
            % Interweave exist.
            else
                fnum = length(obj.rxPower);
                
                wave = gen1090Baseband_interweave(obj, obj.bitStream,2*pi*rand(fnum,1), ...
                    obj.rxFrqOffset, obj.rxTime, obj.rxPower, obj.refPower,obj.fs, obj.durationTime, fnum, 1);
                
                maximum = max( [real(wave) imag(wave)]);
                wave = 0.7 * wave / maximum;
                
                Markers = zeros(2,length(wave));
                Markers(1,:) = sign(real(wave));
                Markers(2,:) = sign(imag(wave));
                Markers = (Markers + 1)/2;
                
                [status, status_description] = agt_waveformload(obj.io, wave, 'adsb', obj.fs, 'play', 'no_normscale', Markers);

                % Turn RF output on
                % Uncomment the agt_sendcommand if RF output should be turned on.
                [ status, status_description ] = agt_sendcommand( obj.io, 'OUTPut:STATe ON' );
                agt_closeAllSessions;
            end
        end
        
        function wave = gen1090Baseband_interweave(obj,bits,phase,frqOffset,rTime, rPower, refPw, fs,cdTime,iwr,dp)
            len = 1e-6 * fs;
            wave = zeros(1, 2000 * len);
            
            hv = [ones(1, len / 2), zeros(1, len / 2)];
            lv = [zeros(1, len / 2), ones(1, len / 2)];
            
%             ads_idle = zeros(1, cdTime * fs / (1e+6));
            ads_head = [hv, hv, zeros(1, 1.5 * len), hv, hv, zeros(1, 2.5 * len)];
    
            for ii = 1 : iwr
            	wavek = zeros(1, 120 * len);
                wavek(1 : 8 * len) = ads_head;
            
                for jj = 1:112
                    if bits(ii, jj) == 1
                        wavek( ...
                            ((jj-1)*len+1+8*len) ...
                            :(jj*len+8*len) ...
                            ) = hv;
                    elseif bits(1, jj) == 0
                        wavek( ...
                            ((jj-1)*len+1+8*len) ...
                            :(jj*len+8*len) ...
                            ) = lv;
                    end
                end
                dv = 10^((rPower(ii) - refPw) / 20);
                wavek = wavek.*exp(phase(ii)*1j).*exp(2*pi*frqOffset(ii)/fs*1j*(0:length(wavek)-1));
                wavek = wavek * dv;
                
                st_index = rTime(ii) * len + 1;
                wave(st_index : st_index + 120 * len - 1) = wave(st_index : st_index + 120 * len - 1) + wavek;
            end
        end
        
        function seq = genSequence(obj)
            obj.downloadWave('offiq100' ,zeros(1,100));
            obj.downloadWave('offiq1000' ,zeros(1,1000));
            seq='';
            time=0;
            for i=1:length(obj.rxTime)
                point=round((obj.rxTime(i)-time)*obj.fs);
                if point<0 
                    point = 1;
                end
                n1 = mod(floor(point/100),10);
                n2 = floor(point/1000);
                if n1~=0
                     seq = [seq ' ,"wfm1:offiq100", ' num2str(n1) ',0,0'];
                end
                if n2~=0
                     seq = [seq ' ,"wfm1:offiq1000", ' num2str(n2) ',0,0'];
                end
                seq = [seq ' ,"wfm1:adsb' num2str(i) '", 1,0,0'];
                
                time=obj.rxTime(i)+112e-6;
            end
            
        end
        
        function obj = initialInstrument(obj,ip)
            obj.io = agt_newconnection('tcpip',ip);
            [status, status_description,query_result] = agt_query(obj.io,'*idn?');
            if (status < 0) 
                [status, status_description,query_result]
                return; 
            end
            [status, status_description] = agt_sendcommand(obj.io, 'SOURce:FREQuency 1090000000');
            [status, status_description] = agt_sendcommand(obj.io, ['POWer ',num2str(obj.refPower)] );%num2str(obj.refPower)
            [status, status_description] = agt_sendcommand(obj.io, ':source:rad:arb:state off');
        end
        
        function obj = runInstrument(obj,seq)
            
            [status, status_description] = agt_sendcommand(obj.io,[':source:rad:arb:seq "adsbseq"' seq]);
            [status, status_description] = agt_sendcommand(obj.io, ':source:rad:arb:wav "seq:adsbseq"');
            [status, status_description] = agt_sendcommand(obj.io, ':source:rad:arb:state on');
            [status, status_description] = agt_sendcommand(obj.io, 'OUTPut:STATe ON' );
        end
        
        function obj = closeInstrument(obj)
            agt_closeAllSessions;  
        end
        
        
        
        function obj = downloadWave(obj,name,wave)
            [status, status_description] = agt_waveformload(obj.io, wave, name, obj.fs, 'no_play', 'no_normscale',zeros(2,length(wave)));
            if (status < 0) 
                [status, status_description]
                return; 
            end
        end
    end
    
end

function [rxTime bitStream rxPower rxFrqOffset] = sortByRxtime(msgs)
    len = arrayfun(@(x) length(x.rxTimeSeries),msgs);
    all = sum(len);
    
    rxTime=zeros(1,all);
    rxPower=zeros(1,all);
    bitStream = cell(1,all);
    rxFrqOffset = zeros(1,all);
    
    n=length(msgs);
    len = arrayfun(@(x) length(x.rxTimeSeries),msgs);
    index=ones(1,n);
    i=1:n;
    for j=1:all
        try
            minT = arrayfun( ...
                @(x) ifelse(index(x)>len(x), ...
                            Inf, ...
                            min(msgs(x).rxTimeSeries(index(x):len(x))) ...
                            ), ...
                i);
        catch 
            error=1;
        end
        [minT id] = min(minT);

        rxTime(j)=minT;
        rxPower(j)=msgs(id).rxPower(index(id));
        rxFrqOffset(j)=msgs(id).rxFrqOffset(index(id));
        bitStream{j}= msgs(id).getBitStream(index(id));
        
        if index(id)<=len(id) 
            index(id) = index(id) +1;
        end
    end
            
    
end

function wave = gen1090Baseband(bits,phase,frqOffset,fs)
        len=1e-6*fs;
        wave0_5us1=ones(1,len/2);
        wave0_5us0=zeros(1,len/2);
    
        wave = zeros(1,112*len);
        for i=1:112
            if bits(i)==1
                wave( ...
                    ((i-1)*len+1) ...
                    :((i-1)*len+len/2) ...
                    )=wave0_5us1;
            else
                wave( ...
                    ((i-1)*len+1+len/2) ...
                    :((i-1)*len+len) ...
                    )=wave0_5us1;
            end
        end
    
    
        wave=[wave0_5us1 wave0_5us0 wave0_5us1 wave0_5us0 ...
            zeros(1,1.5*len) ...
            wave0_5us1 wave0_5us0 wave0_5us1 wave0_5us0 ...
            zeros(1,2.5*len) ...
            wave ...
            ];
    
        wave = wave.*exp(phase*1j).*exp(2*pi*frqOffset/fs*1j*(0:length(wave)-1));
end
function x = ifelse(a,b,c)
    if a
        x=b;
    else
        x=c;
    end
end