function [obj, fnum_real] = read_config_file(obj, fnum)

    fpath = obj.config_path;
    fid = fopen(fpath, 'r');
    
    fnum_real = 0;
    while ~feof(fid)
        flag = zeros(9, 1);
        tline = fgetl(fid);
        
        if strfind(tline, '$ Parameter settings for plane')
            tline = fgetl(fid);
            if ~isempty(tline(13 : end))
                flag(1) = 1;
            end
            plane.icao = str2double(tline(13 : end));
            
            tline = fgetl(fid);
            if ~isempty(tline(15 : end))
                flag(2) = 1;
            end
            plane.fgt_num = tline(15 : end);
            
            tline = fgetl(fid);
            if ~isempty(tline(19 : end))
                flag(3) = 1;
            end
            plane.power = str2double(tline(19 : end));
            
            tline = fgetl(fid);
            if ~isempty(tline(29 : end))
                flag(4) = 1;
            end
            plane.feq_err = str2double(tline(29 : end));
            
            tline = fgetl(fid);
            if ~isempty(tline(31 : end))
                flag(5) = 1;
            end
            plane.st_lat = str2double(tline(31 : end));
            
            tline = fgetl(fid);
            if ~isempty(tline(32 : end))
                flag(6) = 1;
            end
            plane.st_lon = str2double(tline(32 : end));
            
            tline = fgetl(fid);
            if ~isempty(tline(20 : end))
                flag(7) = 1;
            end
            plane.st_alt = str2double(tline(20 : end));
            
            tline = fgetl(fid);
            if ~isempty(tline(27 : end))
                flag(8) = 1;
            end
            plane.vh = str2double(tline(27 : end));
            
            tline = fgetl(fid);
            if ~isempty(tline(28 : end))
                flag(9) = 1;
            end
            plane.az = str2double(tline(28 : end));
            
%             if ~isnan(plane.icao) && ~isempty(plane.fgt_num) && ...
%                     ~isnan(plane.power) && ~isnan(plane.feq_err) && ...
%                     ~isnan(plane.st_lat) && ~isnan(plane.st_lon) && ...
%                     ~isnan(plane.st_alt) && ~isnan(plane.vh) && ...
%                     ~isnan(plane.az)
            if ~isempty(find(flag == 1, 1))
                fnum_real = fnum_real + 1;
                if fnum_real > fnum
                    return;
                end
                obj.plane_info{fnum_real, 1} = plane;
            end
        end
    end
end