classdef Msg1090Factory
    %MSG1090FACTORY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods(Static)
        function msgs = buildMessages(planes,durationTime)
            msgs = Messages.empty(length(planes),0);
            for i=1:length(planes)
                
                n1=ceil(durationTime/0.4);
                n2=ceil(durationTime/4.0);
                timeSeries=[Msg1090Factory.genTimeSeries(0.5,0.1,n1) ...
                            Msg1090Factory.genTimeSeries(0.5,0.1,n1) ...
                            Msg1090Factory.genTimeSeries(  5,  1,n2)];
%                 typeSeries=[ones(1,n1) repmat(2,1,n1) repmat(3,1,n2)];
                typeSeries=[gen0101Series(n1) repmat(2,1,n1) repmat(3,1,n2)];
                
                
                [timeSeries,IX] = sort(timeSeries);
                typeSeries = typeSeries(IX);
                
                len=sum(timeSeries<durationTime);
                timeSeries=timeSeries(1:len);
                typeSeries=typeSeries(1:len);
                
                
                msgs(i)=Messages(planes(i),timeSeries,typeSeries);
                
                trace=msgs(i).getTraceSeries();
                azi=azimuth(trace(1,1),trace(1,2),trace(:,1),trace(:,2));
                azi(1)=planes(i).azimuth;
                azi=azi/180*pi;
                
                msgs(i).setBitStreams(ads_b_source_gen( ...
                    repmat(planes(i).getICAO(),len,1), ...
                    repmat(planes(i).getFgtnum(),len,1), ...
                    trace, ...
                    planes(i).speed*[sin(azi) cos(azi) zeros(size(azi))], ...
                    typeSeries ...
                    ));

%                 ['Complete ' num2str(i/length(planes)*100) '%']
                
            end
        end
        
        function timeSeries = genTimeSeries(interval,jitter,n)
            timeSeries=zeros(1,n);
            timeSeries(1)=interval*rand(1,1);
            if(n==1) 
                return 
            end
            
            itl=(2*rand(1,n-1)-1)*jitter+interval;
            
            for i=1:n-1
                timeSeries(i+1)=timeSeries(i)+itl(i);
            end
        end
    end
    
end

function s0101 = gen0101Series(n)
    s0101 = zeros(1,n);
    s0101(2:2:n)=ones(1,floor(n/2));
end    
