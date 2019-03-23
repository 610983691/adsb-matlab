classdef gui_ads_child_1 < handle
%% *********************************************************************
%
% @file         gui_ads_child1.m
% @brief        Class definition for button 1 GUI.
%
% ******************************************************************************
    
    properties
        % GUI handle for this GUI.
        gui_p;
        % GUI handle for the parent GUI.
        gui_m;
        % Width of the screen.
        width;
        % Height of the screen.
        height;
        % Width of the GUI.
        gui_width;
        % Height of the GUI.
        gui_height;
        % Width of the param settings panel.
        panel_width;
        % Height of the param settings panel.
        panel_height;
        
        % Panel handle of the plane settings panel.
        panel_plane;
        % Panel handle of the receiver settings panel.
        panel_receiver;
        
        % Text handle for plane param, Lattitude, Longtitude, and height.
        plane_txt_lat;
        plane_edt_lat;
        plane_txt_lon;
        plane_edt_lon;
        plane_txt_alt;
        plane_edt_alt;
        % Text handle for plane velocity, and azimuth.
        plane_txt_vh;
        plane_edt_vh;
        plane_txt_az;
        plane_edt_az;
        % Text handle for plane ICAO and flight number.
        plane_txt_icao;
        plane_edt_icao;
        plane_txt_fgt;
        plane_edt_fgt;
        % Text handle for flight time.
        plane_txt_tm;
        plane_edt_tm;
        
        plane_txt_pw;
        plane_edt_pw;
        plane_txt_feq;
        plane_edt_feq;
        
        % Text handle for receiver param, Lattitude.
        rcv_txt_lat;
        rcv_edt_lat;
        % Text handle for receiver param, Longtitude.
        rcv_txt_lon;
        rcv_edt_lon;
        % Text handle for receiver param, Height.
        rcv_txt_alt;
        rcv_edt_alt;
        % Text handle for city select.
        rcv_txt_city;
        rcv_edt_city;
        % Button handle for obtain the location of the city.
        button_rcv;
        
        % Plane parameter automatic configuration button.
        btn_auto;
        
        % Edit text.
        txt_echo;
        edt_echo;
        
        % Button handle 1.
        btn_c1;
        % Button handle 2.
        btn_c2;
        
        % IP for E4438C.
        ip_txt;
        ip_edt;
        ip_btn;
        ip_tst = 0;
        
        % City info.
        city_obj;
        
        % Plane parameter check flag.
        ppc = 0;
        % Receiver parameter check flag.
        rpc = 0;
    end
    
    methods
        % Create figure and init the GUI.
        function obj = gui_ads_child_1(gui_m)
            % Paremeter of the main GUI.
            obj.gui_m = gui_m;
            % Obtain the width and height of the screen.
            obj.width  = obj.gui_m.width;
            obj.height = obj.gui_m.height;
            % Set the width and height of the GUI.
%             obj.gui_width  = floor(2 * obj.width / 3);
%             obj.gui_height = floor(3 * obj.height / 4);
            obj.gui_width = 900;
            obj.gui_height = 600;
            % Set the plane param settings panel widht and height.
%             obj.panel_width  = floor(2 * (obj.gui_width - 100) / 3);
%             obj.panel_height = floor(2 * (obj.gui_height - 100) / 3);
            obj.panel_width = 533;
            obj.panel_height = 380;
            
            % Create figure and init.
            obj.gui_p = figure('Color', [0.83, 0.82, 0.78], ...
                'Numbertitle', 'off', 'Name', '单飞行器场景仿真及ADS-B信号模拟程序', ...
                'Position', [floor((obj.width - obj.gui_width) / 2), ...
                floor((obj.height - obj.gui_height) / 2), obj.gui_width, ...
                obj.gui_height], 'Toolbar', 'none', 'Resize', 'off');
            
            % Create plane param settings panel.
            obj.panel_plane = uipanel('parent', obj.gui_p, 'Units', ...
                'pixels', 'BackgroundColor', [0.83, 0.82, 0.78], 'title', ...
                '飞机参数设置区域', 'Fontsize', 15, 'Position', [25, ...
                obj.gui_height - obj.panel_height, obj.panel_width, ...
                obj.panel_height]);
            % Create receiver param settings panel.
            obj.panel_receiver = uipanel('parent', obj.gui_p, 'Units', ...
                'pixels', 'BackgroundColor', [0.83, 0.82, 0.78], 'title', ...
                '接收机参数设置区域', 'Fontsize', 15, 'Position', ...
                [75 + obj.panel_width, obj.gui_height - obj.panel_height, ...
                floor(obj.panel_width / 2), obj.panel_height]);
            
            % The first row in the panel.
            % Init the ICAO text for plane param.
            obj.plane_txt_icao = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','ICAO编号','position',[0 obj.panel_height - 40 - 50 ...
                100 40]);
            obj.plane_edt_icao = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[101 obj.panel_height - 50 - 30 ...
              120 40]);
            % Init the Lattitude text for plane param.
            obj.plane_txt_lat = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','起始纬度(N,度)','position',[230 obj.panel_height - 50 - 40 ...
                130 40]);
            obj.plane_edt_lat = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[361 obj.panel_height - 50 - 30 ...
              120 40]);
            % Init the Lattitude text for receiver param.
            obj.rcv_txt_lat = uicontrol('parent', obj.panel_receiver, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','纬度(N,度)','position',[0 obj.panel_height - 50 - 40 ...
                100 40]);
            % Init the Lattitude of the receiver edit handle.
            obj.rcv_edt_lat = uicontrol('parent', obj.panel_receiver, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[105 obj.panel_height - 50 - 30 ...
              120 40]);
          
            % The second row in the panel.
            % Init the flight number text for the plane.
            obj.plane_txt_fgt = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','航班号','position',[0 obj.panel_height - 160 ...
                100 40]);
            obj.plane_edt_fgt = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[101 obj.panel_height - 110 - 37 ...
              120 40]);
            % Init the Longtitude text for the plane.
            obj.plane_txt_lon = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','起始经度(E,度)','position',[230 obj.panel_height - 160 ...
                130 40]);
            obj.plane_edt_lon = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[361 obj.panel_height - 147 ...
              120 40]);
            % Init the Longtitude text for the receiver.
            obj.rcv_txt_lon = uicontrol('parent', obj.panel_receiver, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','经度(E,度)','position',[0 obj.panel_height - 160 ...
                100 40]);
            % Init the Lattitude of the receiver edit handle.
            obj.rcv_edt_lon = uicontrol('parent', obj.panel_receiver, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[105 obj.panel_height - 147 ...
              120 40]);
            
            % The third row in the panel.
            % Init the transmit power of the plane.
            obj.plane_txt_pw = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','发射功率(W)','position',[0 obj.panel_height - 230 ...
                100 40]);
            obj.plane_edt_pw = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white','Fontsize',11,'position', ...
                [101 obj.panel_height - 180 - 40 120 40]);
            % Init the height text for the plane.
            obj.plane_txt_alt = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','飞行高度(米)','position',[230 obj.panel_height - 230 ...
                130 40]);
            obj.plane_edt_alt = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[361 obj.panel_height - 220 ...
              120 40]);
            % Init the height text for the receiver.
            obj.rcv_txt_alt = uicontrol('parent', obj.panel_receiver, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','高度(米)','position',[0 obj.panel_height - 230 ...
                100 40]);
            % Init the height of the receiver edit handle.
            obj.rcv_edt_alt = uicontrol('parent', obj.panel_receiver, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[105 obj.panel_height - 220 ...
              120 40]);
          
            % The forth row in the panel.
            % Init the frequency offset error of the plane.
            obj.plane_txt_feq = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','最大频率误差(Hz)','position',[0 obj.panel_height - 300 ...
                100 40]);
            obj.plane_edt_feq = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white','Fontsize',11,'position', ...
                [101 obj.panel_height - 250 - 43 120 40]);
            % Init the velocity text for the plane.
            obj.plane_txt_vh = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','平面飞行速度(km/h)','position',[230 obj.panel_height - 300 ...
                130 40]);
            obj.plane_edt_vh = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[361 obj.panel_height - 250 - 45 ...
              120 40]);
            % Init the city selection edit handle for the receiver.
            obj.rcv_txt_city = uicontrol('parent', obj.panel_receiver, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','城市名拼音','position',[0 obj.panel_height - 300 ...
                100 40]);
            obj.rcv_edt_city = uicontrol('parent', obj.panel_receiver, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[105 obj.panel_height - 250 - 35 ...
              120 40]);
            
            % The fifth row in the panel.
            % Init the flight time text for the plane.
            obj.plane_txt_tm = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','飞行时间(秒)','position',[0 obj.panel_height - 370 ...
                100 40]);
            obj.plane_edt_tm = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[101 obj.panel_height - 320 - 38 ...
              120 40]);
            % Init the azimuth of the plane.
            obj.plane_txt_az = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','平面航向角(度)','position',[230 obj.panel_height - 370 ...
                120 40]);
            obj.plane_edt_az = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[361 obj.panel_height - 320 - 40 ...
              120 40]);
            % Obtain city location buton for the receiver.
            obj.button_rcv = uicontrol('parent', obj.panel_receiver, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '自动获取该城市的经纬度', ...
                'Fontsize', 11, 'position', [35, obj.panel_height - 350, 180, 40]);
            
            % Create handle for button "Start programme".
            obj.btn_c1 = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '开始', ...
                'Fontsize', 15, 'position', [floor((obj.gui_width - 400) / 2), ...
                obj.panel_height - 355, 150, 50]);
            % Create handle for button "Stop programme"。
            obj.btn_c2 = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '退出', ...
                'Fontsize', 15, 'position', [floor((obj.gui_width - 450) / 2) + 250, ...
                obj.panel_height - 355, 150, 50]);
            
            % Create echo info window.
            obj.txt_echo = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','程序状态信息','position',[25 ...
                obj.panel_height - 305 ...
                100 50]);
            obj.edt_echo = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',12,'position',[130 ...
              obj.panel_height - 290 500 50]);
          
            % Plane parameter automatic configuration button.
            obj.btn_auto = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '自动配置飞机参数', ...
                'Fontsize', 12, 'position', [190, obj.panel_height - 220, 140, 50]);
          
            % E4438 signal generator IP address settings.
            obj.ip_txt = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','E4438 IP地址','position',[640 ...
                obj.panel_height - 235 ...
                100 50]);
            obj.ip_edt = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',12,'position',[741 ...
              obj.panel_height - 220 140 50]);
            obj.ip_btn = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '网络连通测试', ...
                'Fontsize', 12, 'position', [700, obj.panel_height - 290, 130, 50]);
            
            % Mapping to the callback function.
            callback_mapping(obj);
        end
        
        % Callback function for button receiver.
        function button_receiver_callback(obj, source, eventdata)
            % Check the first char.
            ct_name = get(obj.rcv_edt_city, 'string');
            grp = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', ...
                'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', ...
                'V', 'W', 'X', 'Y', 'Z'];
            if isempty(find(grp == ct_name(1), 1))
                set(obj.edt_echo, 'string', '输入的城市名拼音首字母没有大写，请重新输入！');
                return;
            end
            
            obj.city_obj = city(obj);
            if isempty(obj.city_obj.city_name)
                set(obj.edt_echo, 'string', '请先输入城市名拼音，如Shanghai，再获取经纬度信息！');
                return;
            end
            
            set(obj.edt_echo, 'string', '正在获取该城市的经纬度信息，请稍等...');
            pause(0.4);
            set(obj.rcv_edt_lat, 'string', obj.city_obj.city_lat);
            set(obj.rcv_edt_lon, 'string', obj.city_obj.city_lon);
            
            set(obj.edt_echo, 'string', '已获取到该城市经纬度信息，见“接收机参数设置区”!');
        end
        
        % Callback function for automatic configuration button.
        function button_auto_config_callback(obj, source, eventdata)
            if isnan(str2double(get(obj.rcv_edt_lat, 'string'))) || ...
                    isnan(str2double(get(obj.rcv_edt_lon, 'string'))) || ...
                    isnan(str2double(get(obj.rcv_edt_alt, 'string')))
                set(obj.edt_echo, 'string', '请先设置接收机参数，再进行操作!');
                return;
            end
            
            fnum = 1;
            
            set(obj.edt_echo, 'string', '正在自动配置飞机参数，请稍等...');
            pause(0.4);
            
            rcv_lat = str2double(get(obj.rcv_edt_lat, 'string'));
            rcv_lon = str2double(get(obj.rcv_edt_lon, 'string'));
%             rcv_alt = str2double(get(obj.rcv_edt_alt, 'string'));
            
            radius = 100 * (1e+3);
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
            traceSeries = reckon(repmat(rcv_lat, fnum, 1), ...
                repmat(rcv_lon, fnum,1 ), degSeries, seta);
    
            icao = int16(rand(fnum, 1) * 10000); 
            fgt  = ['CHN', num2str(int16(rand(fnum, 1) * 1000))];
            azi = int16(minAzimuth + (maxAzimuth - minAzimuth) * rand(fnum, 1));
            alt = int16(minAlt + (maxAlt - minAlt) * rand(fnum, 1));
            speed = int16(minSpeed + (maxSpeed - minSpeed) * rand(fnum, 1));
            power = repmat(500, fnum, 1);
            frqOffset = repmat(maxFrqOffset, fnum, 1);
            tm = mod(int16(rand(fnum, 1) * 1000), 60) + 1;
            
            set(obj.plane_edt_icao, 'string', icao);
            set(obj.plane_edt_fgt, 'string', fgt);
            set(obj.plane_edt_pw, 'string', power);
            set(obj.plane_edt_feq, 'string', frqOffset);
            set(obj.plane_edt_tm, 'string', tm);
            set(obj.plane_edt_lat, 'string', traceSeries(1,1));
            set(obj.plane_edt_lon, 'string', traceSeries(1,2));
            set(obj.plane_edt_alt, 'string', alt);
            set(obj.plane_edt_vh, 'string', speed);
            set(obj.plane_edt_az, 'string', azi);
            
            set(obj.edt_echo, 'string', '自动配置飞机参数完成，见“飞机参数设置区域”！');
        end
        
        % Callback function for button start.
        function button_start_callback(obj, source, eventdata)
            % Check the plane parameter.
            check_plane_param(obj);
            if obj.ppc == 1
                obj.ppc = 0;
                return;
            end
            
            obj.ppc = 0;
            
            % Check the receiver parameter.
            check_rcv_param(obj);
            if obj.rpc == 1
                obj.rpc = 0;
                return;
            end
            
            obj.rpc = 0;
            
            % Network check.
            ip_addr = get(obj.ip_edt, 'string');
            if isempty(ip_addr)
                set(obj.edt_echo, 'string', '请先设置E4438C的IP地址！');
                return;
            end
            
            if obj.ip_tst == 0
                set(obj.edt_echo, 'string', '尚未进行网络连通测试，请先进行网络连通测试！');
                return;
            elseif obj.ip_tst == -1
                obj.ip_tst = 0;
                set(obj.edt_echo, 'string', '请检查您的网络连接以及E4438的LAN配置！');
                return;
            end
            
            set(obj.edt_echo, 'string', '正在运行“单架飞机ADS-B信号模拟程序”...');
            pause(0.3);
                
            % Init the receiver struct.
            speed = str2double(get(obj.plane_edt_vh, 'string')) / 3.6;
            rcvPosition = [str2double(get(obj.rcv_edt_lat, 'string')), ...
                str2double(get(obj.rcv_edt_lon, 'string')), ...
                str2double(get(obj.rcv_edt_alt, 'string'))];
            azimuth = str2double(get(obj.plane_edt_az, 'string'));
            receiver = Receiver(rcvPosition, 0, 0);
            
            % Obtain the simulation time.
            durationTime = str2double(get(obj.plane_edt_tm, 'string')); 

            % Get plane info.
            planeInitialPosition = [ ...
                str2double(get(obj.plane_edt_lat, 'string')), ...
                str2double(get(obj.plane_edt_lon, 'string')), ...
                str2double(get(obj.plane_edt_alt, 'string'))];
            
            arc = distance(receiver.startLat, receiver.startLon, ...
                planeInitialPosition(1), planeInitialPosition(2));
            dis = (arc * pi) / 180 * 6371 * 1000;  % Unit in m.
            % Distance between receiver and the plane.
            planeRadius = sqrt(dis ^ 2 + (planeInitialPosition(3) - ...
                receiver.startAlt) ^ 2);
            if planeRadius > 300 * (1e+3)
                set(obj.edt_echo, 'string', '飞机与接收机之间的距离大于300km，请重新设置！');
                return;
            end     % if planeRadius
            
            planePower = 30 + 10 * log10(str2double(get(obj.plane_edt_pw, 'string')));
            plane_id = str2double(get(obj.plane_edt_icao, 'string'));
            
            fgt = get(obj.plane_edt_fgt, 'string');
            fgt_len = length(fgt);
            fight_num = [fgt, repmat(' ', 1, 8 - fgt_len)];
            
            feq_err = str2double(get(obj.plane_edt_feq, 'string'));
            
            planeGenParameter = struct( ...
                'center', planeInitialPosition, ...
                'altitude', [planeInitialPosition(3); planeInitialPosition(3)], ...
                'speed' ,[speed, speed], ...
                'azimuth' , [azimuth, azimuth], ...
                'power' ,planePower, ...
                'id', plane_id, ...
                'fgt_num', fight_num, ...
                'frqoffset' ,[-feq_err feq_err] ...
                );
            planeFactory = PlaneFactory(planeGenParameter);
            planes = planeFactory.buildPlanes(1);
            
            adsbMsgs=Msg1090Factory.buildMessages(planes,durationTime);
            receiver.receiveMessages(adsbMsgs);
            
            waveDownloader=WaveDownloader(durationTime);
            waveDownloader.downloadMessages(adsbMsgs );

            waveDownloader.ip4438 = ip_addr;
            waveDownloader.playWave(0, 0);
            
            set(obj.edt_echo, 'string', '“单架飞机ADS-B信号模拟程序”运行完毕！');
        end
        
        function button_exit_callback(obj, source, eventdata)
            set(obj.edt_echo, 'string', '退出程序...');
            pause(0.3);
            
            close(obj.gui_p);
            clear;
            clc;
        end
        
        function button_ip_callback(obj, source, eventdata)
            if isempty(get(obj.ip_edt, 'string'))
                set(obj.edt_echo, 'string', '请先设置E4438的IP地址，再进行网络测试！');
                obj.ip_tst = 0;
                return;
            end
            
            ip_addr = get(obj.ip_edt, 'string');
            ip_split = strsplit(ip_addr, '.');
            if length(ip_split) ~= 4
                set(obj.edt_echo, 'string', 'IP地址格式错误，请重新输入IP地址！');
                return;
            end
            
            if ~isempty(find(str2double(ip_split) < 0, 1)) || ~isempty(find(str2double(ip_split) > 255, 1))
                set(obj.edt_echo, 'string', 'IP地址以“.”号分隔的数字范围为[0,255]，请重新输入！');
                return;
            end
            
            if sum(isnan(str2double(ip_split))) ~= 0
                set(obj.edt_echo, 'string', 'IP地址中包含非法字符，请重新输入IP地址！');
                return;
            end
            
            set(obj.edt_echo, 'string', '正在测试PC与E4438之间的网络连通性，请稍等...');
            pause(0.4);
            
            ip_con = dos(['ping -w 100 -n 1 ', ip_addr]);
            
            if ip_con == 0
                set(obj.edt_echo, 'string', '网络正常，可进行下载！');
                obj.ip_tst = 1;
            else
                set(obj.edt_echo, 'string', '请检查您的网络连接以及E4438的LAN配置！');
                obj.ip_tst = -1;
                return;
            end
        end
        
        function callback_mapping(obj)
            set(obj.button_rcv, 'callback', @obj.button_receiver_callback);
            set(obj.btn_c1, 'callback', @obj.button_start_callback);
            set(obj.btn_c2, 'callback', @obj.button_exit_callback);
            set(obj.ip_btn, 'callback', @obj.button_ip_callback);
            set(obj.btn_auto, 'callback', @obj.button_auto_config_callback);
        end
        
        function check_plane_param(obj)
            obj.ppc = 0;
            
            % Check whether the parameter is inputed or not.
            if isempty(get(obj.plane_edt_icao, 'string')) || ...
                    isempty(get(obj.plane_edt_lat, 'string')) || ...
                    isempty(get(obj.plane_edt_fgt, 'string')) || ...
                    isempty(get(obj.plane_edt_lon, 'string')) || ...
                    isempty(get(obj.plane_edt_pw, 'string')) || ...
                    isempty(get(obj.plane_edt_alt, 'string')) || ...
                    isempty(get(obj.plane_edt_feq, 'string')) || ...
                    isempty(get(obj.plane_edt_vh, 'string')) || ...
                    isempty(get(obj.plane_edt_tm, 'string')) || ...
                    isempty(get(obj.plane_edt_az, 'string'))
                set(obj.edt_echo, 'string', '飞机参数尚未设置完毕，请先设置好飞机参数！');
                obj.ppc = 1;
                return;
            end
            
            % ICAO number check.
            icao = str2double(get(obj.plane_edt_icao, 'string'));
            if isnan(icao)
                set(obj.edt_echo, 'string', '设置的ICAO编号中包含非法字符，应为非负整数，请重新设置！');
                obj.ppc = 1;
                return;
            elseif ~isempty(find(get(obj.plane_edt_icao, 'string') == '.', 1))
                set(obj.edt_echo, 'string', '设置的ICAO为小数，应为非负整数，请重新设置！');
                obj.ppc = 1;
                return;
            elseif icao < 0 || icao > 2 ^ 24 - 1
                set(obj.edt_echo, 'string', '设置的ICAO编号超出范围，应为[0, 16777215]，请重新设置！');
                obj.ppc = 1;
                return;
            end
            
            % Flight number check.
            fgt = get(obj.plane_edt_fgt, 'string');
            
            grp = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', ...
                'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', ...
                'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ' '];
            for ii = 1 : length(fgt)
                if isempty(find(grp == fgt(ii), 1))
                    set(obj.edt_echo, 'string', '设置的航班号中包含非法字符，应为{A~Z, 0~9, 空格}，请重新设置！');
                    obj.ppc = 1;
                    return;
                end
            end
                
            if length(fgt) > 8
                set(obj.edt_echo, 'string', '设置的航班号大于8个字符，应为8个字符，请重新设置！');
                obj.ppc = 1;
                return;
            elseif length(fgt) < 8
                set(obj.edt_echo, 'string', '设置的航班号小于8个字符，已自动在后面补上空格！');
                pause(0.5);
            end
            
            % Power check.
            pw = str2double(get(obj.plane_edt_pw, 'string'));
            if isnan(pw)
                set(obj.edt_echo, 'string', '设置的发射功率中包含非法字符，应为正数，请重新设置！');
                obj.ppc = 1;
                return;
            elseif pw <= 0 || pw > 500
                set(obj.edt_echo, 'string', '设置的发送功率超出范围，应为(0, 500]，可为小数，请重新设置！');
                obj.ppc = 1;
                return;
            end
            
            % Frequency offset check.
            feq = str2double(get(obj.plane_edt_feq, 'string'));
            if isnan(feq)
                set(obj.edt_echo, 'string', '设置的最大频率误差中包含非法字符，应为纯数字，请重新设置！');
                obj.ppc = 1;
                return;
            elseif feq < 0 || feq > 1089 * (1e+6)
                set(obj.edt_echo, 'string', '设置的最大频率误差超出范围，应为[0, 1090MHz]，请重新设置！');
                obj.ppc = 1;
                return;
            end
            
            % Flight time check.
            tm = str2double(get(obj.plane_edt_tm, 'string'));
            if isnan(tm)
                set(obj.edt_echo, 'string', '设置的飞行时间中包含非法字符，应为纯数字，请重新设置！');
                obj.ppc = 1;
                return;
            elseif tm <= 0 || tm > 60
                set(obj.edt_echo, 'string', '设置的飞行时间超出范围，应为(0, 60]，可为小数，请重新设置！');
                obj.ppc = 1;
                return;
            end
            
            % Plane start Latitude.
            lat = str2double(get(obj.plane_edt_lat, 'string'));
            if isnan(lat)
                set(obj.edt_echo, 'string', '设置的起始纬度中包含非法字符，应为数值，请重新设置！');
                obj.ppc = 1;
                return;
            elseif lat < 0 || lat > 90
                set(obj.edt_echo, 'string', '设置的起始纬度超出范围，应为[0, 90]，请重新设置！');
                obj.ppc = 1;
                return;
            end
            
            % Plane start Longtitude.
            lon = str2double(get(obj.plane_edt_lon, 'string'));
            if isnan(lon)
                set(obj.edt_echo, 'string', '设置的起始经度中包含非法字符，应为数值，请重新设置！');
                obj.ppc = 1;
                return;
            elseif lon < 0 || lon > 180
                set(obj.edt_echo, 'string', '设置的起始经度超出范围，应为[0, 180]，请重新设置！');
                obj.ppc = 1;
                return;
            end
            
            % Plane flying height.
            alt = str2double(get(obj.plane_edt_alt, 'string'));
            if isnan(alt)
                set(obj.edt_echo, 'string', '设置的飞行高度中包含非法字符，应为数值，请重新设置！');
                obj.ppc = 1;
                return;
            elseif alt <= 0 || alt > 300 * (1e+3)
                set(obj.edt_echo, 'string', '设置的飞行高度超出范围，应为(0, 300000]，请重新设置');
                obj.ppc = 1;
                return;
            end
            
            % Plane vh check.
            vh = str2double(get(obj.plane_edt_vh, 'string'));
            if isnan(vh)
                set(obj.edt_echo, 'string', '设置的平面飞行速度中包含非法字符，应为正数，请重新设置！');
                obj.ppc = 1;
                return;
            elseif vh <= 0 || vh > 1000
                set(obj.edt_echo, 'string', '设置的平面飞行速度超出范围，应为(0, 1000]，请重新设置！');
                obj.ppc = 1;
                return;
            end
            
            % Plane azimuth check.
            az = str2double(get(obj.plane_edt_az, 'string'));
            if isnan(az)
                set(obj.edt_echo, 'string', '设置的平面航向角中包含非法字符，应为正数，请重新设置！');
                obj.ppc = 1;
                return;
            elseif az < 0 || az >= 360
                set(obj.edt_echo, 'string', '设置的平面航向角超出范围，应为[0, 360)，请重新设置！');
                obj.ppc = 1;
                return;
            end
        end
    
        function check_rcv_param(obj)
            obj.rpc = 0;
            
            % Whether the parameter is configured!
            if isempty(get(obj.rcv_edt_lat, 'string')) || ...
                    isempty(get(obj.rcv_edt_lon, 'string')) || ...
                    isempty(get(obj.rcv_edt_alt, 'string'))
                set(obj.edt_echo, 'string', '接收机参数尚未设置完毕，请先设置接收机参数！');
                obj.rpc = 1;
                return;
            end
            
            % Check receiver latitude.
            lat = str2double(get(obj.rcv_edt_lat, 'string'));
            if isnan(lat)
                set(obj.edt_echo, 'string', '设置的纬度中包含非法字符，应为数值，请重新设置！');
                obj.rpc = 1;
                return;
            elseif lat < 0 || lat > 90
                set(obj.edt_echo, 'string', '设置的纬度超出范围，应为[0, 90]，请重新设置！');
                obj.rpc = 1;
                return;
            end
            
            % Receiver Longtitude.
            lon = str2double(get(obj.rcv_edt_lon, 'string'));
            if isnan(lon)
                set(obj.edt_echo, 'string', '设置的经度中包含非法字符，应为数值，请重新设置！');
                obj.rpc = 1;
                return;
            elseif lon < 0 || lon > 180
                set(obj.edt_echo, 'string', '设置的经度超出范围，应为[0, 180]，请重新设置！');
                obj.rpc = 1;
                return;
            end
            
            % Receiver height.
            alt = str2double(get(obj.rcv_edt_alt, 'string'));
            if isnan(alt)
                set(obj.edt_echo, 'string', '设置的高度中包含非法字符，应为数值，请重新设置！');
                obj.rpc = 1;
                return;
            elseif alt <= 0 || alt > 9000
                set(obj.edt_echo, 'string', '设置的高度超出范围，应为(0, 9000]，请重新设置');
                obj.rpc = 1;
                return;
            end
        end
        
    end
end