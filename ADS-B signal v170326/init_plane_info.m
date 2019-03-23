function plane_info = init_plane_info(plane_num)

    plane.icao = [];
    plane.fgt_num = [];
    plane.power = [];
    plane.feq_err = [];
    plane.st_lat = [];
    plane.st_lon = [];
    plane.st_alt = [];
    plane.vh = [];
    plane.az = [];
    
    plane_info = cell(plane_num, 1);
    for ii = 1 : plane_num
        plane_info{ii, 1} = plane;
    end

end