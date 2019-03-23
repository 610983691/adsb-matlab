classdef Receiver < FlyObject
    %RECEIVER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        
        
    end
    
    methods
        function obj = Receiver(initialPosition,speed,azimuth)
%             speed = (6.754e-11*5.98e24/(6370.856e3+azimuth))^0.5;
            obj = obj@FlyObject(initialPosition,azimuth,speed);
        end
        
        
        
        function obj = receiveMessages(obj,msgs)
            for i=1:length(msgs)
                trace=msgs(i).getTraceSeries();
                time=msgs(i).getTxTimeSeries();
                self = obj.getTraceSeries(time);
                
                % [elev,dist,azi] = elevation( ...
                %    trace(:,1),trace(:,2),trace(:,3), ...
                %    self(:,1),self(:,2),self(:,3)); 
                [elev,dist,azi] = elevation( ...
                    trace(:,1),trace(:,2),trace(:,3), ...
                    repmat(self(1,1), size(trace, 1), 1), ...
                    repmat(self(1,2), size(trace, 1), 1), ...
                    repmat(self(1,3), size(trace, 1), 1));
                
                msgs(i).setRxTimeSeries(time+dist/3e8);
                msgs(i).setGainSeries(92.45+20*log10(1.090)+20*log10(dist/1e3));
                doppler = msgs(i).plane.speed ...
                    .*cos(deg2rad(azi-msgs(i).plane.azimuth)) ...
                    .*cos(deg2rad(elev)) ...
                    .*1.090e9/3e10;
                msgs(i).setRxFrqOffset(msgs(i).getTxFrqOffset()+doppler);
                
%                 ['Complete ' num2str(i/length(msgs)*100) '%']
            end
        end
        
        function traceSeries = getTraceSeries(obj,timeSeries)
            traceSeries = getTraceSeries@FlyObject(obj,timeSeries);
        end 
        
    end
    
end

