classdef Map
    %MAP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods(Static)
        function showMap()
            geoshow('landareas.shp', 'EdgeColor', [0.8 0.8 0.8], 'FaceColor', [0.9 0.9 0.9]);
        end
        
        function showPlane(planes,duration)
            for i=1:length(planes)
                trace = planes(i).getTraceSeries((0:0.5:1).*duration);
                 geoshow(trace(:,1),trace(:,2),'Color', [1 0 0],'LineWidth',4);
            end
        end
        
        function showTrace(trace)
            
        end
        
        
        
    end
    
end

