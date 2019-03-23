function obj = auto_config(obj, fnum)

    radius = 150 * (1e+3);
    minAzimuth = 0;
    maxAzimuth = 360;
    minSpeed = 500;         % Unit in km/h
    maxSpeed = 700;         % Unit in km/h
    minAlt = 2000;
    maxAlt = 10000;
    maxFrqOffset = 1e+4;
    
    
    r = radius * sqrt(rand(fnum, 1));
    seta = 360 * rand(fnum, 1);

    degSeries = km2deg(r/1000);
    traceSeries = reckon(repmat(obj.rcv_info.lat, fnum, 1), ...
        repmat(obj.rcv_info.lon, fnum,1 ), degSeries, seta);
    
    azi = minAzimuth + (maxAzimuth - minAzimuth) * rand(fnum, 1);
    alt = minAlt + (maxAlt - minAlt) * rand(fnum, 1);
    speed = minSpeed + (maxSpeed - minSpeed) * rand(fnum, 1);
    power = repmat(500, fnum, 1);
    frqOffset = repmat(maxFrqOffset, fnum, 1);
    
    for ii = 1 : fnum
        obj.plane_info{ii, 1}.icao = ii;
        obj.plane_info{ii, 1}.fgt_num = repmat(num2str(ii), 1, 8);
        obj.plane_info{ii, 1}.power = power(ii, 1);
        obj.plane_info{ii, 1}.feq_err = frqOffset(ii, 1);
        obj.plane_info{ii, 1}.st_lat = traceSeries(ii, 1);
        obj.plane_info{ii, 1}.st_lon = traceSeries(ii, 2);
        obj.plane_info{ii, 1}.st_alt = alt(ii, 1);
        obj.plane_info{ii, 1}.vh = speed(ii, 1);
        obj.plane_info{ii, 1}.az = azi(ii, 1);
    end
end