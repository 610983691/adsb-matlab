classdef FlyObject < handle
    %FLYOBJECT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        startLat
        startLon
        startAlt
        
        
        speed
        azimuth
    end
    
    methods
        function obj = FlyObject(initialPosition,azimuth,speed)
            obj.startLat=initialPosition(1);
            obj.startLon=initialPosition(2);
            obj.startAlt=initialPosition(3);
            
            obj.azimuth=azimuth;
            obj.speed=speed;
        end
        
        function position = getInitialPosition(obj)
            position = [obj.startLat obj.startLon obj.startAlt ];
        end
        
        function traceSeries = getTraceSeries(obj,timeSeries)
            timeSeries = reshape(timeSeries,length(timeSeries),1);
            
            degSeries = km2deg(obj.speed.*timeSeries/1e3);
            traceSeries = [reckon(obj.startLat,obj.startLon,degSeries,obj.azimuth) repmat(obj.startAlt,length(timeSeries),1)];
        end
        
    end
    
end

