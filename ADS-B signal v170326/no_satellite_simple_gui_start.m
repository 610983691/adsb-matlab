classdef no_satellite_simple_gui_start < handle
%% *********************************************************************
%
% @file         no_satellite_simple_gui_start.m
% @brief        Class definition for button 2 GUI.
%
% ******************************************************************************
    properties
        % Handle for this GUI.
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
        
        % Plane number.飞机数量
        plane_num_txt;
        plane_num_edt;
          % Configuration file settings panel.
        config_auto;
        config_txt;
        config_edt;
        config_sct;
        config_con;
        config_man;
        config_path;
    
        
      
        
        % Panel handle of the plane settings panel.飞机1,2,3的panel
        panel_plane_1;
        panel_plane_2;
        panel_plane_3;
        plane_txt_times;%飞行时间
        plane_edt_times;
       
        
        % Text handle for plane param, Lattitude, Longtitude, and height.
        plane_txt_lat1,plane_txt_lat2,plane_txt_lat3;
        plane_edt_lat1, plane_edt_lat2, plane_edt_lat3;
        plane_txt_lon1,plane_txt_lon2,plane_txt_lon3;
        plane_edt_lon1, plane_edt_lon2, plane_edt_lon3;
        plane_txt_alt1,plane_txt_alt2,plane_txt_alt3;
        plane_edt_alt1,plane_edt_alt2,plane_edt_alt3;
        % Text handle for plane velocity, and azimuth.
        plane_txt_vh1,plane_txt_vh2,plane_txt_vh3;
        plane_edt_vh1,plane_edt_vh2,plane_edt_vh3;
        plane_txt_az1,plane_txt_az2,plane_txt_az3;
        plane_edt_az1,plane_edt_az2,plane_edt_az3;
        
        
        plane_txt_pw1,plane_txt_pw2,plane_txt_pw3;
        plane_edt_pw1,plane_edt_pw2,plane_edt_pw3;

        
        
        % Edit text.
        txt_echo;
        edt_echo;
        
        % Button handle 1.
        btn_c1;
        % Button handle 2.
        btn_c2;
        
       
        
     
        % Plane info cell.
        plane_info;
      
        
        % Callback function flag.
        cb_auto_config = 0;
        cb_man_config = 0;
        
        % Plane parameter check flag.
        ppc = 0;
        % Receiver parameter check flag.
        rpc = 0;
    end
    
    methods
        % Create figure and init.
        function obj = no_satellite_simple_gui_start()
            screen_size = get(0, 'ScreenSize');
            screen_size(screen_size < 100) = [];
            obj.width  = screen_size(1);
            obj.height = screen_size(2);
            
            % Set the width and height of the GUI.
            obj.gui_width = obj.width-60;
            obj.gui_height = obj.height - 100;
            % Set the plane param settings panel widht and height.
            obj.panel_width = obj.gui_width;
            obj.panel_height = 160;
            
            % The first row info.
            % Create figure and init.
            obj.gui_p = figure('Color', [0.83, 0.82, 0.78], ...
                'Numbertitle', 'off', 'Name', '无卫星简单模式', ...
                'Position', [floor((obj.width - obj.gui_width) / 2), ...
                floor((obj.height - obj.gui_height) / 2), obj.gui_width, ...
                obj.gui_height], 'Toolbar', 'none', 'Resize', 'off');
            
            % Plane number settings.
            obj.plane_num_txt = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','飞机数量','position',[15 ...
                obj.gui_height - 60 80 40]);
            obj.plane_num_edt = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[96 obj.gui_height - 50 ...
              60 40]);
          
               % Init 仿真时长
            obj.plane_txt_times = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','仿真时长(s)','position',[160 ...
                obj.gui_height - 60 100 40]);
            obj.plane_edt_times = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[271 obj.gui_height - 50 ...
              100 40]);
         
      
          
            % Automatic configure.自动配置飞机参数并仿真
            obj.config_auto = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '自动配置飞机参数并运行仿真', ...
                'Fontsize', 12, 'position', [420, obj.gui_height - 50, 240, 40]);
            
          
            
            % Create plane param settings panel.
            obj.panel_plane_1 = uipanel('parent', obj.gui_p, 'Units', ...
                'pixels', 'BackgroundColor', [0.83, 0.82, 0.78], 'title', ...
                '飞机一参数设置区域', 'Fontsize', 15, 'Position', [25, ...
                obj.gui_height - obj.panel_height - 60, obj.panel_width-10, ...
                obj.panel_height]);
            % panle位置设置
            edit_area_width=120;%文本框的宽度固定为100
            txt_area_width_label=130;%label设置为130
            
            % The first row in the panel.
         
            % Init the Lattitude text for plane param.
            obj.plane_txt_lat1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','起始纬度(N,度)','position',[0 obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lat1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[txt_area_width_label+1 obj.panel_height - 80 ...
              edit_area_width 40]);
             
          
          
            % Init the Longtitude text for the plane.
            obj.plane_txt_lon1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','起始经度(E,度)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lon1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
        
 
            % Init the transmit power of the plane.
            obj.plane_txt_pw1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','功率(dbm)','position',[4+(2*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_pw1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white','Fontsize',11,'position', ...
                [5+(3*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 edit_area_width 40]);
            % Init the height text for the plane.
            obj.plane_txt_alt1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','飞行高度(米)','position',[6+(3*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_alt1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[7+(4*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
       
        
            % Init the velocity text for the plane.
            obj.plane_txt_vh1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','平面飞行速度(km/h)','position',[0 obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_vh1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[1+(txt_area_width_label) obj.panel_height - 130 ...
              edit_area_width 40]);
         
         
            % Init the azimuth of the plane.
            obj.plane_txt_az1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','平面航向角(度)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_az1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
              edit_area_width 40]);
          
       
          
          % 开始设置第二个飞机的参数
           % Create plane param settings panel.
           obj.panel_plane_2 = uipanel('parent', obj.gui_p, 'Units', ...
                'pixels', 'BackgroundColor', [0.83, 0.82, 0.78], 'title', ...
                '飞机二参数设置区域', 'Fontsize', 15, 'Position', [25, ...
                obj.gui_height - 2*obj.panel_height - 60, obj.panel_width-10, ...
                obj.panel_height]);
            % panle位置设置
            edit_area_width=120;%文本框的宽度固定为100
            txt_area_width_label=130;%label设置为130
            
            % The first row in the panel.
         
            % Init the Lattitude text for plane param.
            obj.plane_txt_lat2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','起始纬度(N,度)','position',[0 obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lat2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[txt_area_width_label+1 obj.panel_height - 80 ...
              edit_area_width 40]);
             
          
          
            % Init the Longtitude text for the plane.
            obj.plane_txt_lon2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','起始经度(E,度)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lon2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
        
 
            % Init the transmit power of the plane.
            obj.plane_txt_pw2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','功率(dbm)','position',[4+(2*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_pw2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white','Fontsize',11,'position', ...
                [5+(3*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 edit_area_width 40]);
            % Init the height text for the plane.
            obj.plane_txt_alt2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','飞行高度(米)','position',[6+(3*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_alt2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[7+(4*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
       
        
            % Init the velocity text for the plane.
            obj.plane_txt_vh2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','平面飞行速度(km/h)','position',[0 obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_vh2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[1+(txt_area_width_label) obj.panel_height - 130 ...
              edit_area_width 40]);
         
         
            % Init the azimuth of the plane.
            obj.plane_txt_az2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','平面航向角(度)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_az2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
              edit_area_width 40]);
          
         
          
          % 第二个飞机参数设置完毕
          
          % 开始设置第三个飞机的参数
           % Create plane param settings panel.
           obj.panel_plane_3 = uipanel('parent', obj.gui_p, 'Units', ...
                'pixels', 'BackgroundColor', [0.83, 0.82, 0.78], 'title', ...
                '飞机三参数设置区域', 'Fontsize', 15, 'Position', [25, ...
                obj.gui_height - 3*obj.panel_height - 60, obj.panel_width-10, ...
                obj.panel_height]);
            % panle位置设置
            edit_area_width=120;%文本框的宽度固定为100
            txt_area_width_label=130;%label设置为130
            
            % The first row in the panel.
         
            % Init the Lattitude text for plane param.
            obj.plane_txt_lat3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','起始纬度(N,度)','position',[0 obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lat3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[txt_area_width_label+1 obj.panel_height - 80 ...
              edit_area_width 40]);
             
          
          
            % Init the Longtitude text for the plane.
            obj.plane_txt_lon3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','起始经度(E,度)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lon3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
        
 
            % Init the transmit power of the plane.
            obj.plane_txt_pw3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','功率(dbm)','position',[4+(2*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_pw3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white','Fontsize',11,'position', ...
                [5+(3*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 edit_area_width 40]);
            % Init the height text for the plane.
            obj.plane_txt_alt3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','飞行高度(米)','position',[6+(3*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_alt3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[7+(4*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
       
        
            % Init the velocity text for the plane.
            obj.plane_txt_vh3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','平面飞行速度(km/h)','position',[0 obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_vh3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[1+(txt_area_width_label) obj.panel_height - 130 ...
              edit_area_width 40]);
         
         
            % Init the azimuth of the plane.
            obj.plane_txt_az3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','平面航向角(度)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_az3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
              edit_area_width 40]);
          
          
          % 第三个飞机参数设置完毕
          
          
            % Create handle for button "Start programme".
            obj.btn_c1 = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '开始', ...
                'Fontsize', 15, 'position', [floor((obj.gui_width - 400) / 2), ...
                30, 150, 50]);
            % Create handle for button "Stop programme"。
            obj.btn_c2 = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '退出', ...
                'Fontsize', 15, 'position', [floor((obj.gui_width - 450) / 2) + 250, ...
                30, 150, 50]);
               % Create echo info window.
            obj.txt_echo = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','程序状态信息','position',[240 ...
                obj.panel_height - 90 120 40]);
            obj.edt_echo = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[360 ...
              obj.panel_height - 75 500 40]);
     
            
            % Mapping to the callback function.
            callback_mapping(obj);
        end
        
     
      
        
        % Callback function for automatic configuration button.
        function button_auto_config_callback(obj, source, eventdata)
            if isempty(get(obj.plane_num_edt, 'string'))
                set(obj.edt_echo, 'string', '尚未设置飞机数量，请先设置飞机数量！');
                return;
            end
            
            if isempty(get(obj.plane_edt_times, 'string'))
                set(obj.edt_echo, 'string', '尚未设置飞行时间，请先设置飞行时间！');
                return;
            end
            
            fnum = str2double(get(obj.plane_num_edt, 'string'));
            if isnan(fnum)
                set(obj.edt_echo, 'string', '设置的飞机数量中包含非法字符，应为正整数，请重新设置！');
                return;
            elseif ~isempty(find(get(obj.plane_num_edt, 'string') == '.', 1))
                set(obj.edt_echo, 'string', '设置的飞机数量为小数，应为正整数，请重新设置！');
                return;
            elseif fnum <= 0 || fnum > 100
                set(obj.edt_echo, 'string', '设置的飞机数量超出范围，应为(0, 100]，请重新设置！');
                return;
            end
            
            ftime = str2double(get(obj.plane_edt_times, 'string'));
            if isnan(ftime)
                set(obj.edt_echo, 'string', '设置的飞行时间中包含非法字符，应为数值，请重新设置！');
                return;
            elseif ftime <= 0 || ftime > 60
                set(obj.edt_echo, 'string', '设置的飞行时间超出范围，应为(0, 60]，请重新设置！');
                return;
            end
            % 接下来需要调用随机方法生成随机的飞机信息矩阵
            
            
            % 接下来调用紫童的方法传递参数，进行仿真
      
          
        end
        
      
       
     
        
        % Callback function for button start.
        function button_start_callback(obj, source, eventdata)
            if isempty(get(obj.plane_num_edt, 'string'))
                set(obj.edt_echo, 'string', '尚未设置飞机数量，请先设置飞机数量！');
                return;
            end
            
            if isempty(get(obj.plane_edt_times, 'string'))
                set(obj.edt_echo, 'string', '尚未设置飞行时间，请先设置飞行时间！');
                return;
            end
            
            fnum = str2double(get(obj.plane_num_edt, 'string'));
            if isnan(fnum)
                set(obj.edt_echo, 'string', '设置的飞机数量中包含非法字符，应为正整数，请重新设置！');
                return;
            elseif ~isempty(find(get(obj.plane_num_edt, 'string') == '.', 1))
                set(obj.edt_echo, 'string', '设置的飞机数量为小数，应为正整数，请重新设置！');
                return;
            elseif fnum <= 0 || fnum > 8
                set(obj.edt_echo, 'string', '设置的飞机数量超出范围，应为(0, 8]，请重新设置！');
                return;
            end
            
            ftime = str2double(get(obj.plane_edt_times, 'string'));
            if isnan(ftime)
                set(obj.edt_echo, 'string', '设置的飞行时间中包含非法字符，应为数值，请重新设置！');
                return;
            elseif ftime <= 0 || ftime > 60
                set(obj.edt_echo, 'string', '设置的飞行时间超出范围，应为(0, 60]，请重新设置！');
                return;
            end
            
            if obj.cb_auto_config == 0 && obj.cb_man_config == 0
                set(obj.edt_echo, 'string', '尚未配置飞机参数，请先配置飞机参数！');
                return;
            end
            
            if obj.cb_man_config == 1
                check_plane_param(obj);
                if obj.ppc == 1
                    obj.ppc = 0;
                    return;
                end
            end
            
            obj.ppc = 0;
            obj.cb_man_config = 0;
            obj.cb_auto_config = 0;
            
            % Check the receiver parameter.
            check_rcv_param(obj);
            if obj.rpc == 1
                obj.rpc = 0;
                return;
            end
            
            obj.rpc = 0;
            
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
            
            set(obj.edt_echo, 'string', '正在运行“多架飞机ADS-B信号模拟程序”...');
            pause(0.3);
            
            % Init the receiver struct.
            rcvPosition = [str2double(get(obj.rcv_edt_lat, 'string')), ...
                str2double(get(obj.rcv_edt_lon, 'string')), ...
                str2double(get(obj.rcv_edt_alt, 'string'))];
            receiver = Receiver(rcvPosition, 0, 0);
            
            % Obtain the simulation time.
            durationTime = str2double(get(obj.plane_edt_times, 'string'));
            
            % Get plane info.
            planeInitialPosition = zeros(fnum, 3);
            planePower = zeros(fnum, 1);
            plane_id = zeros(fnum, 1);
            fight_num = [];
            feq_err = zeros(1, fnum);
            planeSpeed = zeros(1, fnum);
            azi = zeros(1, fnum);
            
            for ii = 1 : fnum
                planeInitialPosition(ii, :) = [obj.plane_info{ii, 1}.st_lat, ...
                    obj.plane_info{ii, 1}.st_lon, ...
                    obj.plane_info{ii, 1}.st_alt];
                planePower(ii, 1) = 30 + 10 * log10(obj.plane_info{ii, 1}.power);
                plane_id(ii, 1) = obj.plane_info{ii, 1}.icao;
                fgn = obj.plane_info{ii, 1}.fgt_num;
                fgn = [fgn, repmat(' ', 1, 8 - length(fgn))];
                fight_num = [fight_num; fgn];
                feq_err(1, ii) = obj.plane_info{ii, 1}.feq_err;
                planeSpeed(1, ii) = obj.plane_info{ii, 1}.vh / 3.6;
                azi(1, ii) = obj.plane_info{ii, 1}.az;
            end
            
            arc = distance(receiver.startLat, receiver.startLon, ...
                planeInitialPosition(:, 1), planeInitialPosition(:, 2));
            dis = (arc * pi) / 180 * 6371 * 1000;  % Unit in m.
            % Distance between receiver and the plane.
            planeRadius = sqrt(dis .^ 2 + (planeInitialPosition(:, 3) - ...
                receiver.startAlt) .^ 2);
            index_error = find(planeRadius > 300 * (1e+3));
            if ~isempty(index_error)
                set(['飞机', num2str(index_error), '距离接收机的距离大于300km，请重新设置！']);
            end
            
            planeGenParameter = struct( ...
                'center', planeInitialPosition, ...
                'altitude', [planeInitialPosition(:, 3)'; planeInitialPosition(:, 3)'], ...
                'speed' ,[planeSpeed; planeSpeed], ...
                'azimuth' , [azi; azi], ...
                'power' ,planePower, ...
                'id', plane_id, ...
                'fgt_num', fight_num, ...
                'frqoffset' ,[-feq_err; feq_err] ...
                );
            planeFactory = PlaneFactory(planeGenParameter);
            planes = planeFactory.buildPlanes(fnum);
            
            adsbMsgs=Msg1090Factory.buildMessages(planes,durationTime);
            receiver.receiveMessages(adsbMsgs);
            
            waveDownloader=WaveDownloader(durationTime);
            waveDownloader.downloadMessages(adsbMsgs );

            waveDownloader.ip4438 = ip_addr;
            waveDownloader.playWave(0, 0);
            
            set(obj.edt_echo, 'string', '“多架飞机ADS-B信号模拟程序”运行完毕！');
        end
        
        % Callback function for exit button.
        function button_exit_callback(obj, source, eventdata)
            set(obj.edt_echo, 'string', '退出程序...');
            pause(0.3);
            
            close(obj.gui_p);
            clear;
            clc;
        end
        
      
        
        function callback_mapping(obj)
          
            set(obj.config_man, 'callback', @obj.button_save_config_callback);
            set(obj.config_auto, 'callback', @obj.button_auto_config_callback);
            set(obj.config_sct, 'callback', @obj.button_config_file_callback);
            set(obj.config_con, 'callback', @obj.button_config_callback);

            set(obj.btn_c1, 'callback', @obj.button_start_callback);
            set(obj.btn_c2, 'callback', @obj.button_exit_callback);
           
        end
        
        
        
        function check_plane_param(obj)
            fnum = length(obj.plane_info);
            
            for ii = 1 : fnum
                % Plane parameter check.
                if isnan(obj.plane_info{ii, 1}.icao)
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的ICAO编号尚未设置或者包含非法字符，请重新设置！']);
                    obj.ppc = 1;
                    return;
                elseif ~isempty(find(num2str(obj.plane_info{ii, 1}.icao) == '.', 1))
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的ICAO编号为小数，应为非负整数，请重新设置！']);
                    obj.ppc = 1;
                    return;
                elseif obj.plane_info{ii, 1}.icao < 0 || obj.plane_info{ii, 1}.icao > 2 ^ 24 - 1
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的ICAO编号超出范围，应为[0, 16777215]，请重新设置！']);
                    obj.ppc = 1;
                    return;
                end
                
                % Flight number check.      
                if isempty(obj.plane_info{ii, 1}.fgt_num)
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的航班号尚未设置，请重新设置！']);
                    obj.ppc = 1;
                    return;
                elseif length(obj.plane_info{ii, 1}.fgt_num) > 8
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的航班号长度大于8，应等于8，请重新设置！']);
                    obj.ppc = 1;
                    return;
                elseif length(obj.plane_info{ii, 1}.fgt_num) < 8
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的航班号长度小于8，已自动在后面不上空格！']);
                    pause(0.5);
                end
                
                grp = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', ...
                    'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', ...
                    'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ' '];
                for jj = 1 : length(obj.plane_info{ii, 1}.fgt_num)
                    if isempty(find(grp == obj.plane_info{ii, 1}.fgt_num(jj), 1))
                        set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                            '的航班号中包含非法字符，应为{A~Z, 0~9, 空格}，请重新设置！']);
                        obj.ppc = 1;
                        return;
                    end
                end
                
                % Power check.
                if isnan(obj.plane_info{ii, 1}.power)
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的发射功率尚未设置或者包含非法字符，请重新设置！']);
                    obj.ppc = 1;
                    return;
                elseif obj.plane_info{ii, 1}.power <= 0 || obj.plane_info{ii, 1}.power > 500
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的发射功率超出范围，应为(0, 500]，请重新设置！']);
                    obj.ppc = 1;
                    return;
                end
                
                % Frequency offset check.
                feq = obj.plane_info{ii, 1}.feq_err;
                if isnan(feq)
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的最大频率误差未设置或者包含非法字符，应为纯数字，请重新设置！']);
                    obj.ppc = 1;
                    return;
                elseif feq < 0 || feq > 1089 * (1e+6)
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的最大频率误差超出范围，应为[0, 1090MHz]，请重新设置！']);
                    obj.ppc = 1;
                    return;
                end
            
                % Plane start Latitude.
                lat = obj.plane_info{ii, 1}.st_lat;
                if isnan(lat)
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的起始纬度未设置或者包含非法字符，应为数值，请重新设置！']);
                    obj.ppc = 1;
                    return;
                elseif lat < 0 || lat > 90
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的起始纬度超出范围，应为[0, 90]，请重新设置！']);
                    obj.ppc = 1;
                    return;
                end
            
                % Plane start Longtitude.
                lon = obj.plane_info{ii, 1}.st_lon;
                if isnan(lon)
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的起始经度未设置或者包含非法字符，应为数值，请重新设置！']);
                    obj.ppc = 1;
                    return;
                elseif lon < 0 || lon > 180
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的起始经度超出范围，应为[0, 180]，请重新设置！']);
                	obj.ppc = 1;
                    return;
                end
            
                % Plane flying height.
                alt = obj.plane_info{ii, 1}.st_alt;
                if isnan(alt)
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的飞行高度未设置或者包含非法字符，应为数值，请重新设置！']);
                    obj.ppc = 1;
                    return;
                elseif alt <= 0 || alt > 300 * (1e+3)
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的飞行高度超出范围，应为(0, 300000]，请重新设置']);
                    obj.ppc = 1;
                    return;
                end
            
                % Plane vh check.
                vh = obj.plane_info{ii, 1}.vh;
                if isnan(vh)
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的平面飞行速度未设置或者包含非法字符，应为正数，请重新设置！']);
                    obj.ppc = 1;
                    return;
                elseif vh <= 0 || vh > 1000
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的平面飞行速度超出范围，应为(0, 1000]，请重新设置！']);
                    obj.ppc = 1;
                    return;
                end
            
                % Plane azimuth check.
                az = obj.plane_info{ii, 1}.az;
                if isnan(az)
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的平面航向角未设置或者包含非法字符，应为正数，请重新设置！']);
                    obj.ppc = 1;
                    return;
                elseif az < 0 || az >= 360
                    set(obj.edt_echo, 'string', ['飞机', num2str(ii), ...
                        '的平面航向角超出范围，应为[0, 360)，请重新设置！']);
                    obj.ppc = 1;
                    return;
                end
            end
        end
    end
end