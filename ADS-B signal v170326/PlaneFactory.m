classdef PlaneFactory < handle
    %PLANEFACTORY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        position
%         radius
        icao
        fgt_num
        
        maxAlt
        minAlt
        
        maxSpeed
        minSpeed
        
        maxAzimuth
        minAzimuth
        
        tx_power
        
        maxFrqOffset
        minFrqOffset
    end
    
    
    
    methods 
        function obj = PlaneFactory(parameter)
            obj.icao = parameter.id;
            obj.fgt_num = parameter.fgt_num;
            
            obj.position=parameter.center;
%             obj.radius=parameter.radius;
            
            obj.maxAlt=max(parameter.altitude);
            obj.minAlt=min(parameter.altitude);
            
            obj.maxSpeed=max(parameter.speed);
            obj.minSpeed=min(parameter.speed);
            
            obj.maxAzimuth=max(parameter.azimuth);
            obj.minAzimuth=min(parameter.azimuth);
            
            obj.tx_power=parameter.power;
            
            obj.maxFrqOffset=max(parameter.frqoffset);
            obj.minFrqOffset=min(parameter.frqoffset);
        end
        
        function obj = setCenterPosition(obj,position)
            obj.position=position;
        end
        
%         function obj = setRadius(obj,radius)
%             obj.radius=radius;
%         end
        
        
        function planes = buildPlanes(obj, num)
            planes = Plane.empty(0,num);
            
%             r=obj.radius*sqrt(rand(num,1));
%             seta=360*rand(num,1);
            
%             degSeries = km2deg(r/1000);
%             traceSeries = reckon(repmat(obj.position(1),num,1),repmat(obj.position(2),num,1),degSeries,seta);
            
            azi = obj.minAzimuth+(obj.maxAzimuth-obj.minAzimuth)*rand(num,1);
            
%             alt = obj.minAlt+(obj.maxAlt-obj.minAlt)*rand(num,1);
            speed = obj.minSpeed+(obj.maxSpeed-obj.minSpeed)*rand(num,1);
            
%             power = obj.tx_power(randi(length(obj.tx_power),num,1));
            power = obj.tx_power;
            
            frqOffset = obj.minFrqOffset+(obj.maxFrqOffset-obj.minFrqOffset)*rand(num,1);
            
            
            
            for i=1:num
                par = struct( ...
                    'id',obj.icao(i), ...
                    'fgt_num', obj.fgt_num(i, :), ...
                    'initialPosition',obj.position(i, :), ...
                    'azimuth',azi(i), ...
                    'speed',speed(i), ...
                    'txPower',power(i), ...
                    'frqOffset',frqOffset(i) ...
                );
                
                planes(i) = Plane(par);
            end
            
        end
        
    end
    
end

