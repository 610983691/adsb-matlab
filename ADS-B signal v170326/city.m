classdef city < handle
%% *********************************************************************
%
% @file         city.m
% @brief        City class definition, including city name, lat and lon.
%
% ******************************************************************************

    properties
        city_name;
        city_lat;
        city_lon;
    end
    
    methods
        % Obtain the input city's lat and lon info.
        function obj = city(gui_obj)
            % Get the city name info.
            obj.city_name = get(gui_obj.rcv_edt_city, 'string');
            
            if ~isempty(obj.city_name)
                % Obtain the Lat and Lon info of the city.
                S = shaperead('worldcities.shp', 'UseGeoCoords', true);
                index = strcmp(obj.city_name, {S(:).Name});
                obj.city_lat = S(index).Lat;
                obj.city_lon = S(index).Lon;
            else
                obj.city_name = [];
                obj.city_lat = [];
                obj.city_lon = [];
            end
        end
    end
end