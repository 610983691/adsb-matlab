classdef gui_ads_child_4 < handle
%% *********************************************************************
%
% @file         gui_ads_child_4.m
% @brief        Class definition for button 4 GUI.
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
        
        % Plane number.
        plane_num_txt;
        plane_num_edt;
        
        % Plane received power, unit in dBm.
        rcv_pw_txt;
        rcv_pw_edt;
        
        % Plane info look up.
        plane_info_txt;
        plane_info_edt;
        plane_info_btn;
        
        % Configuration file settings panel.
        config_auto;
        config_txt;
        config_edt;
        config_sct;
        config_con;
        config_man;
        config_path;
        
        % Panel handle of the plane settings panel.
        panel_plane;
        % Panel handle of the receiver settings panel.
        panel_rcv;
        
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
        
        plane_txt_pw;
        plane_edt_pw;
        plane_txt_feq;
        plane_edt_feq;
        
        % Plane message start time.
        plane_txt_tm;
        plane_edt_tm;
        
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
        
        % Edit text.
        txt_echo;
        edt_echo;
        
        % Button handle 1.
        btn_c1;
        % Button handle 2.
        btn_c2;
        
%         % Signal interweave ratio.
%         sir_txt;
%         sir_edt;
%         % Signal 1 power.
%         sp1_txt;
%         sp1_edt;
%         % Signal 2 power.
%         sp2_txt;
%         sp2_edt;
        
        % Frame message type.
        fmt_txt;
        fmt_sct;
        
        % IP for E4438C.
        ip_txt;
        ip_edt;
        ip_btn;
        ip_tst = 0;
        
        % City info.
        city_obj;
        % Plane info cell.
        plane_info;
        % Receiver info structure.
        rcv_info;
        
        % Plane parameter check.
        ppc = 0;
        % Receiver parameter check.
        rpc = 0;
        
        % Callback function flag.
        cb_auto_config = 0;
        cb_man_config = 0;
    end
    
    methods
        % Create figure and init.
        function obj = gui_ads_child_4(gui_m)
            % Paremeter of the main GUI.
            obj.gui_m = gui_m;
            % Obtain the width and height of the screen.
            obj.width  = obj.gui_m.width;
            obj.height = obj.gui_m.height;
            % Set the width and height of the GUI.
            obj.gui_width = 900;
            obj.gui_height = 600;
            % Set the plane param settings panel widht and height.
            obj.panel_width = 533;
            obj.panel_height = 295;
            
            % The first row info.
            % Create figure and init.
            obj.gui_p = figure('Color', [0.83, 0.82, 0.78], ...
                'Numbertitle', 'off', 'Name', 'ADS-B�źŽ�֯���Գ���', ...
                'Position', [floor((obj.width - obj.gui_width) / 2), ...
                floor((obj.height - obj.gui_height) / 2), obj.gui_width, ...
                obj.gui_height], 'Toolbar', 'none', 'Resize', 'off');
            
            % Plane number settings.
            obj.plane_num_txt = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','�ɻ�����','position',[10 ...
                obj.gui_height - 60 80 40]);
            obj.plane_num_edt = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[91 obj.gui_height - 50 ...
              49 40]);
          
            % Plane flight time.
            obj.rcv_pw_txt = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','�źŽ��չ���(dBm)','position',[150 ...
                obj.gui_height - 60 140 40]);
            obj.rcv_pw_edt = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[291 obj.gui_height - 50 ...
              60 40]);
          
            % Plane parameter settings find.
            obj.plane_info_txt = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','�ɻ����(1 - N)','position',[351 ...
                obj.gui_height - 60 140 40]);
            obj.plane_info_edt = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[492 obj.gui_height - 50 ...
              50 40]);
            obj.plane_info_btn = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '��ѯ�÷ɻ�������Ϣ', ...
                'Fontsize', 12, 'position', [552, obj.gui_height - 50, 160, 40]);
            obj.config_man = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '��������', ...
                'Fontsize', 12, 'position', [745, obj.gui_height - 50, 100, 40]);
            
            % Automatic configure.
            obj.config_auto = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '�Զ����÷ɻ�����', ...
                'Fontsize', 12, 'position', [25, obj.gui_height - 105, 150, 40]);
            
            % Create select configuration file.
            obj.config_txt = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','�ɻ����������ļ�','position',[175 ...
                obj.gui_height - 115 140 40]);
            obj.config_edt = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[316 obj.gui_height - 105 ...
              470 40]);
            obj.config_sct = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '...', ...
                'Fontsize', 15, 'position', [790, obj.gui_height - 105, 40, 40]);
            obj.config_con = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '����', ...
                'Fontsize', 12, 'position', [835, obj.gui_height - 105, 50, 40]);
            
            % Create plane param settings panel.
            obj.panel_plane = uipanel('parent', obj.gui_p, 'Units', ...
                'pixels', 'BackgroundColor', [0.83, 0.82, 0.78], 'title', ...
                '�ɻ�������������', 'Fontsize', 15, 'Position', [25, ...
                obj.gui_height - obj.panel_height - 120, obj.panel_width, ...
                obj.panel_height]);
            % Create receiver param settings panel.
            obj.panel_rcv = uipanel('parent', obj.gui_p, 'Units', ...
                'pixels', 'BackgroundColor', [0.83, 0.82, 0.78], 'title', ...
                '���ջ�������������', 'Fontsize', 15, 'Position', ...
                [75 + obj.panel_width, obj.gui_height - obj.panel_height - 120, ...
                floor(obj.panel_width / 2), obj.panel_height]);
            
            % The first row in the panel.
            % Init the ICAO text for plane param.
            obj.plane_txt_icao = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','ICAO���','position',[0 obj.panel_height - 40 - 50 ...
                100 40]);
            obj.plane_edt_icao = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[101 obj.panel_height - 50 - 30 ...
              120 40]);
            % Init the Lattitude text for plane param.
            obj.plane_txt_lat = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','��ʼγ��(N,��)','position',[230 obj.panel_height - 50 - 40 ...
                130 40]);
            obj.plane_edt_lat = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[361 obj.panel_height - 50 - 30 ...
              120 40]);
            % Init the Lattitude text for receiver param.
            obj.rcv_txt_lat = uicontrol('parent', obj.panel_rcv, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','γ��(N,��)','position',[0 obj.panel_height - 50 - 40 ...
                100 40]);
            % Init the Lattitude of the receiver edit handle.
            obj.rcv_edt_lat = uicontrol('parent', obj.panel_rcv, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[105 obj.panel_height - 50 - 30 ...
              120 40]);
          
            % The second row in the panel.
            % Init the flight number text for the plane.
            obj.plane_txt_fgt = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','�����','position',[0 obj.panel_height - 140 ...
                100 40]);
            obj.plane_edt_fgt = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[101 obj.panel_height - 90 - 37 ...
              120 40]);
            % Init the Longtitude text for the plane.
            obj.plane_txt_lon = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','��ʼ����(E,��)','position',[230 obj.panel_height - 140 ...
                130 40]);
            obj.plane_edt_lon = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[361 obj.panel_height - 127 ...
              120 40]);
            % Init the Longtitude text for the receiver.
            obj.rcv_txt_lon = uicontrol('parent', obj.panel_rcv, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','����(E,��)','position',[0 obj.panel_height - 140 ...
                100 40]);
            % Init the Lattitude of the receiver edit handle.
            obj.rcv_edt_lon = uicontrol('parent', obj.panel_rcv, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[105 obj.panel_height - 127 ...
              120 40]);
            
            % The third row in the panel.
            % Init the transmit power of the plane.
            obj.plane_txt_pw = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','���书��(W)','position',[0 obj.panel_height - 190 ...
                100 40]);
            obj.plane_edt_pw = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white','Fontsize',11,'position', ...
                [101 obj.panel_height - 180 120 40]);
            % Init the height text for the plane.
            obj.plane_txt_alt = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','���и߶�(��)','position',[230 obj.panel_height - 190 ...
                130 40]);
            obj.plane_edt_alt = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[361 obj.panel_height - 180 ...
              120 40]);
            % Init the height text for the receiver.
            obj.rcv_txt_alt = uicontrol('parent', obj.panel_rcv, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','�߶�(��)','position',[0 obj.panel_height - 190 ...
                100 40]);
            % Init the height of the receiver edit handle.
            obj.rcv_edt_alt = uicontrol('parent', obj.panel_rcv, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[105 obj.panel_height - 180 ...
              120 40]);
          
            % The forth row in the panel.
            % Init the frequency offset error of the plane.
            obj.plane_txt_feq = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','���Ƶ�����(Hz)','position',[0 obj.panel_height - 240 ...
                100 40]);
            obj.plane_edt_feq = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white','Fontsize',11,'position', ...
                [101 obj.panel_height - 233 120 40]);
            % Init the velocity text for the plane.
            obj.plane_txt_vh = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','ƽ������ٶ�(km/h)','position',[230 obj.panel_height - 240 ...
                130 40]);
            obj.plane_edt_vh = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[361 obj.panel_height - 230 ...
              120 40]);
            % Init the city selection edit handle for the receiver.
            obj.rcv_txt_city = uicontrol('parent', obj.panel_rcv, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','������ƴ��','position',[0 obj.panel_height - 240 ...
                100 40]);
            obj.rcv_edt_city = uicontrol('parent', obj.panel_rcv, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[105 obj.panel_height - 225 ...
              120 40]);
            
            % The fifth row in the panel.
            % Init the signal start time.
            obj.plane_txt_tm = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','���ķ���ʱ��(us)','position',[0 obj.panel_height - 290 ...
                100 40]);
            obj.plane_edt_tm = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white','Fontsize',11,'position', ...
                [101 obj.panel_height - 283 120 40]);
            
            % Init the azimuth of the plane.
            obj.plane_txt_az = uicontrol('parent', obj.panel_plane, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','ƽ�溽���(��)','position',[230 obj.panel_height - 290 ...
                120 40]);
            obj.plane_edt_az = uicontrol('parent', obj.panel_plane, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[361 obj.panel_height - 240 - 40 ...
              120 40]);
            % Obtain city location buton for the receiver.
            obj.button_rcv = uicontrol('parent', obj.panel_rcv, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '�Զ���ȡ�ó��еľ�γ��', ...
                'Fontsize', 11, 'position', [35, obj.panel_height - 285, 180, 40]);
            
            % Create handle for button "Start programme".
            obj.btn_c1 = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '��ʼ', ...
                'Fontsize', 15, 'position', [130, ...
                30, 150, 50]);
            % Create handle for button "Stop programme"��
            obj.btn_c2 = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '�˳�', ...
                'Fontsize', 15, 'position', [330, ...
                30, 150, 50]);
            
            % Create echo info window.
            obj.txt_echo = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','����״̬��Ϣ','position',[25 ...
                obj.panel_height - 200 ...
                100 50]);
            obj.edt_echo = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[130 ...
              obj.panel_height - 185 480 50]);
          
            % Message type.
            obj.fmt_txt = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','��������','position',[630 ...
                obj.panel_height - 185 ...
                100 50]);
            obj.fmt_sct = uicontrol('parent', obj.gui_p, 'style', ...
                'popupmenu', 'BackgroundColor', [0.83 0.82 0.78] ...
              , 'Fontsize', 11, 'string','λ�ñ���(��)|λ�ñ���(ż)|�ٶȱ���|�ɻ���ݱ���', ...
              'position', [731 obj.panel_height - 180 130 50]);
          
            % IP settings.
            obj.ip_txt = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','E4438 IP��ַ','position',[630 ...
                obj.panel_height - 230 100 40]);
            obj.ip_edt = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[731 obj.panel_height - 215 ...
              150 40]);
            obj.ip_btn = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '������ͨ����', ...
                'Fontsize', 11, 'position', [705, obj.panel_height - 270, 120, 40]);
          
            % Signal interweave.
%             obj.sir_txt = uicontrol('parent', obj.gui_p, 'style', ...
%                 'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
%                 'string','�źŽ�֯�ٷֱ�(%)','position',[220 ...
%                 obj.panel_height - 290 ...
%                 150 50]);
%             obj.sir_edt = uicontrol('parent', obj.gui_p, 'style', ...
%                 'edit', 'BackgroundColor','white' ...
%               ,'Fontsize',11,'position',[371 ...
%               obj.panel_height - 270 60 40]);
%           
%             % Signal power 1.
%             obj.sp1_txt = uicontrol('parent', obj.gui_p, 'style', ...
%                 'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
%                 'string','�ɻ�1�źŽ��չ���(dBm)','position',[451 ...
%                 obj.panel_height - 285 ...
%                 100 50]);
%             obj.sp1_edt = uicontrol('parent', obj.gui_p, 'style', ...
%                 'edit', 'BackgroundColor','white' ...
%               ,'Fontsize',11,'position',[555 ...
%               obj.panel_height - 273 60 40]);
%           
%             % Signal power 2.
%             obj.sp2_txt = uicontrol('parent', obj.gui_p, 'style', ...
%                 'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
%                 'string','�ɻ�2�źŽ��չ���(dBm)','position',[634 ...
%                 obj.panel_height - 285 ...
%                 100 50]);
%             obj.sp2_edt = uicontrol('parent', obj.gui_p, 'style', ...
%                 'edit', 'BackgroundColor','white' ...
%               ,'Fontsize',11,'position',[739 ...
%               obj.panel_height - 273 60 40]);
            
%             set(obj.plane_num_edt, 'string', 2);
          
            % Mapping to the callback function.
            callback_mapping(obj);
        end
        
        % Callback function for look up button.
        function button_lookup_callback(obj, source, eventdata)
            if isempty(get(obj.plane_num_edt, 'string'))
                set(obj.edt_echo, 'string', '��δ���÷ɻ��������������÷ɻ�������');
                return;
            end
            
            if isempty(get(obj.plane_info_edt, 'string'))
                set(obj.edt_echo, 'string', '��δ����ɻ���ţ�������ɻ���ź��ٲ�ѯ������Ϣ��');
                return;
            end
            
            plane_index = str2double(get(obj.plane_info_edt, 'string'));
            fnum = str2double(get(obj.plane_num_edt, 'string'));
            if isnan(fnum)
                set(obj.edt_echo, 'string', '���õķɻ������а����Ƿ��ַ���ӦΪ�����������������ã�');
                return;
            elseif ~isempty(find(get(obj.plane_num_edt, 'string') == '.', 1))
                set(obj.edt_echo, 'string', '���õķɻ�����ΪС����ӦΪ�����������������ã�');
                return;
            elseif fnum <= 0 || fnum > 8
                set(obj.edt_echo, 'string', '���õķɻ�����������Χ��ӦΪ(0, 8]�����������ã�');
                return;
            end
            
            if isnan(plane_index)
                set(obj.edt_echo, 'string', '����ķɻ�����а����Ƿ��ַ���ӦΪ�����������������룡');
                return;
            elseif ~isempty(find(get(obj.plane_info_edt, 'string') == '.', 1))
                set(obj.edt_echo, 'string', '���õķɻ�����ΪС����ӦΪ�����������������ã�');
                return;
            elseif plane_index <= 0 || plane_index > fnum
                set(obj.edt_echo, 'string', ['����ķɻ���ų�����Χ,ӦΪ(0, ', num2str(fnum), ']�����������룡']);
                return;
            end
            
            set(obj.edt_echo, 'string', ['���ڲ�ѯ�ɻ�', num2str(plane_index), ...
                '��������Ϣ�����Ե�...']);
            pause(0.4);
            
            set(obj.plane_edt_icao, 'string', obj.plane_info{plane_index, 1}.icao);
            set(obj.plane_edt_fgt, 'string', obj.plane_info{plane_index, 1}.fgt_num);
            set(obj.plane_edt_pw, 'string', obj.plane_info{plane_index, 1}.power);
            set(obj.plane_edt_feq, 'string', obj.plane_info{plane_index, 1}.feq_err);
            set(obj.plane_edt_tm, 'string', obj.plane_info{plane_index, 1}.st_tm);
            set(obj.plane_edt_lat, 'string', obj.plane_info{plane_index, 1}.st_lat);
            set(obj.plane_edt_lon, 'string', obj.plane_info{plane_index, 1}.st_lon);
            set(obj.plane_edt_alt, 'string', obj.plane_info{plane_index, 1}.st_alt);
            set(obj.plane_edt_vh, 'string', obj.plane_info{plane_index, 1}.vh);
            set(obj.plane_edt_az, 'string', obj.plane_info{plane_index, 1}.az);
            set(obj.rcv_pw_edt, 'string', obj.plane_info{plane_index, 1}.rpw);
            
            set(obj.edt_echo, 'string', ['�ɻ�', num2str(plane_index), '��������Ϣ��ѯ��ϣ������ɻ���������������']);
        end
        
        % Callback function for saving configuration button.
        function button_save_config_callback(obj, source, eventdata)
            if isempty(get(obj.plane_num_edt, 'string'))
                set(obj.edt_echo, 'string', '��δ���÷ɻ��������������÷ɻ�������');
                return;
            end
            
            if isempty(get(obj.plane_info_edt, 'string'))
                set(obj.edt_echo, 'string', '��δ����ɻ���ţ�������ɻ���ź��ٲ�ѯ������Ϣ��');
                return;
            end
            
            plane_index = str2double(get(obj.plane_info_edt, 'string'));
            fnum = str2double(get(obj.plane_num_edt, 'string'));
            if isnan(fnum)
                set(obj.edt_echo, 'string', '���õķɻ������а����Ƿ��ַ���ӦΪ�����������������ã�');
                return;
            elseif ~isempty(find(get(obj.plane_num_edt, 'string') == '.', 1))
                set(obj.edt_echo, 'string', '���õķɻ�����ΪС����ӦΪ�����������������ã�');
                return;
            elseif fnum <= 0 || fnum > 8
                set(obj.edt_echo, 'string', '���õķɻ�����������Χ��ӦΪ(0, 8]�����������ã�');
                return;
            end
            
            if isnan(plane_index)
                set(obj.edt_echo, 'string', '����ķɻ�����а����Ƿ��ַ���ӦΪ�����������������룡');
                return;
            elseif ~isempty(find(get(obj.plane_info_edt, 'string') == '.', 1))
                set(obj.edt_echo, 'string', '���õķɻ�����ΪС����ӦΪ�����������������ã�');
                return;
            elseif plane_index <= 0 || plane_index > fnum
                set(obj.edt_echo, 'string', ['����ķɻ���ų�����Χ,ӦΪ(0, ', num2str(fnum), ']�����������룡']);
                return;
            end
            
            set(obj.edt_echo, 'string', ['���ڱ���ɻ�', num2str(plane_index), ...
                '��������Ϣ�����Ե�...']);
            pause(0.4);
            
            obj.plane_info{plane_index, 1}.icao = str2double(get(obj.plane_edt_icao, 'string'));
            obj.plane_info{plane_index, 1}.fgt_num = get(obj.plane_edt_fgt, 'string');
            obj.plane_info{plane_index, 1}.power = str2double(get(obj.plane_edt_pw, 'string'));
            obj.plane_info{plane_index, 1}.feq_err = str2double(get(obj.plane_edt_feq, 'string'));
            obj.plane_info{plane_index, 1}.st_tm = str2double(get(obj.plane_edt_tm, 'string'));
            obj.plane_info{plane_index, 1}.st_lat = str2double(get(obj.plane_edt_lat, 'string'));
            obj.plane_info{plane_index, 1}.st_lon = str2double(get(obj.plane_edt_lon, 'string'));
            obj.plane_info{plane_index, 1}.st_alt = str2double(get(obj.plane_edt_alt, 'string'));
            obj.plane_info{plane_index, 1}.vh = str2double(get(obj.plane_edt_vh, 'string'));
            obj.plane_info{plane_index, 1}.az = str2double(get(obj.plane_edt_az, 'string'));
            obj.plane_info{plane_index, 1}.rpw = str2double(get(obj.rcv_pw_edt, 'string'));
            
            set(obj.edt_echo, 'string', ['�ɻ�', num2str(plane_index), ...
                '��������Ϣ������ϣ������ɻ���������������']);
        end
        
        % Callback function for automatic configuration button.
        function button_auto_config_callback(obj, source, eventdata)
            if isempty(get(obj.plane_num_edt, 'string'))
                set(obj.edt_echo, 'string', '��δ���÷ɻ��������������÷ɻ�������');
                return;
            end
            
            fnum = str2double(get(obj.plane_num_edt, 'string'));
            if isnan(fnum)
                set(obj.edt_echo, 'string', '���õķɻ������а����Ƿ��ַ���ӦΪ�����������������ã�');
                return;
            elseif ~isempty(find(get(obj.plane_num_edt, 'string') == '.', 1))
                set(obj.edt_echo, 'string', '���õķɻ�����ΪС����ӦΪ�����������������ã�');
                return;
            elseif fnum <= 0 || fnum > 8
                set(obj.edt_echo, 'string', '���õķɻ�����������Χ��ӦΪ(0, 8]�����������ã�');
                return;
            end
            
            check_rcv_param(obj);
            if obj.rpc == 1
                obj.rpc = 0;
                return;
            end
            
            obj.rpc = 0;
            
            set(obj.edt_echo, 'string', '�����Զ����÷ɻ����������Ե�...');
            pause(0.4);
            
            init_plane_info_inter(obj, fnum);
            obj.rcv_info.lat = str2double(get(obj.rcv_edt_lat, 'string'));
            obj.rcv_info.lon = str2double(get(obj.rcv_edt_lon, 'string'));
            obj.rcv_info.alt = str2double(get(obj.rcv_edt_alt, 'string'));
            
            obj = auto_config_inter(obj, fnum);
            set(obj.edt_echo, 'string', '�Զ����÷ɻ�������ɣ�������ͨ������ɻ���Ų�ѯ��Ӧ��������Ϣ��');
            
            obj.cb_auto_config = 1;
        end
        
        % Callback function for select configuration file button.
        function button_config_file_callback(obj, source, eventdata)
            set(obj.edt_echo, 'string', '����ѡȡ�ɻ����������ļ�...');
            
            % Select the position of the configuration file.
%             iflag = 1;
%             while iflag == 1 
            [filename, pathname] = uigetfile({'*.*txt';'*.*'},'ѡ��ɻ����������ļ�');
            if isequal(filename, 0)
                set(obj.edt_echo, 'string', '����δѡ���κ������ļ�����ѡ��');
                return;
%                 iflag = 1;
            else
                obj.config_path = [pathname, filename];
%                     iflag = 0;
            end     % if isequal(filename,0)
%             end     % while iflag == 1
            
%             work_path = pwd;
%             rel_path = ['..', obj.config_path(length(work_path) + 1 : end)];
            set(obj.edt_echo, 'string', '�����ļ�ѡ������ɣ����ڡ��ɻ����������ļ����в鿴�����ļ�·����');
            set(obj.config_edt, 'string', obj.config_path);
        end
        
        % Callback function for configuration button.
        function button_config_callback(obj, source, eventdata)
            if isempty(get(obj.plane_num_edt, 'string'))
                set(obj.edt_echo, 'string', '��δ���÷ɻ��������������÷ɻ�������');
                return;
            end
            
            fnum = str2double(get(obj.plane_num_edt, 'string'));
            if isnan(fnum)
                set(obj.edt_echo, 'string', '���õķɻ������а����Ƿ��ַ���ӦΪ�����������������ã�');
                return;
            elseif ~isempty(find(get(obj.plane_num_edt, 'string') == '.', 1))
                set(obj.edt_echo, 'string', '���õķɻ�����ΪС����ӦΪ�����������������ã�');
                return;
            elseif fnum <= 0 || fnum > 8
                set(obj.edt_echo, 'string', '���õķɻ�����������Χ��ӦΪ(0, 8]�����������ã�');
                return;
            end
            
            set(obj.edt_echo, 'string', '���ڶ�ȡ�����ļ������÷ɻ����������Ե�...');
            pause(0.4);
            
            init_plane_info_inter(obj, fnum);
            [obj, fnum_real] = read_config_file_inter(obj, fnum);
            if fnum_real <= fnum
                set(obj.edt_echo, 'string', ['�ܹ����', num2str(fnum_real), ...
                    '�ܷɻ����������ã���ͨ������ɻ���Ų�ѯ��Ӧ��������Ϣ��']);
                set(obj.plane_num_edt, 'string', num2str(fnum_real));
            else
                set(obj.edt_echo, 'string', ['�ܹ����', num2str(fnum), ...
                    '�ܷɻ����������ã���ͨ������ɻ���Ų�ѯ��Ӧ��������Ϣ��']);
                set(obj.plane_num_edt, 'string', num2str(fnum));
            end
            
            obj.cb_man_config = 1;
        end
        
        % Callback function for button receiver.
        function button_receiver_callback(obj, source, eventdata)
            % Check the first char.
            ct_name = get(obj.rcv_edt_city, 'string');
            if isempty(ct_name)
                set(obj.edt_echo, 'string', '�������������ƴ������Shanghai���ٻ�ȡ��γ����Ϣ��');
                return;
            end
            
            grp = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', ...
                'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', ...
                'V', 'W', 'X', 'Y', 'Z'];
            if isempty(find(grp == ct_name(1), 1))
                set(obj.edt_echo, 'string', '����ĳ�����ƴ������ĸû�д�д�����������룡');
                return;
            end
            
            set(obj.edt_echo, 'string', '���ڻ�ȡ�ó��еľ�γ����Ϣ�����Ե�...');
            pause(0.4);
            
            obj.city_obj = city(obj);
            
            set(obj.rcv_edt_lat, 'string', obj.city_obj.city_lat);
            set(obj.rcv_edt_lon, 'string', obj.city_obj.city_lon);
            set(obj.edt_echo, 'string', '�ѻ�ȡ���ó��о�γ����Ϣ���������ջ�������������!');
        end
        
        % Callback function for button start.
        function button_start_callback(obj, source, eventdata)
            if isempty(get(obj.plane_num_edt, 'string'))
                set(obj.edt_echo, 'string', '��δ���÷ɻ��������������÷ɻ�������');
                return;
            end
            
            fnum = str2double(get(obj.plane_num_edt, 'string'));
            if isnan(fnum)
                set(obj.edt_echo, 'string', '���õķɻ������а����Ƿ��ַ���ӦΪ�����������������ã�');
                return;
            elseif ~isempty(find(get(obj.plane_num_edt, 'string') == '.', 1))
                set(obj.edt_echo, 'string', '���õķɻ�����ΪС����ӦΪ�����������������ã�');
                return;
            elseif fnum <= 0 || fnum > 8
                set(obj.edt_echo, 'string', '���õķɻ�����������Χ��ӦΪ(0, 8]�����������ã�');
                return;
            end
            
            if obj.cb_auto_config == 0 && obj.cb_man_config == 0
                set(obj.edt_echo, 'string', '��δ���÷ɻ��������������÷ɻ�������');
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
                set(obj.edt_echo, 'string', '��������E4438C��IP��ַ��');
                return;
            end
            
            if obj.ip_tst == 0
                set(obj.edt_echo, 'string', '��δ����������ͨ���ԣ����Ƚ���������ͨ���ԣ�');
                return;
            elseif obj.ip_tst == -1
                obj.ip_tst = 0;
                set(obj.edt_echo, 'string', '�����������������Լ�E4438��LAN���ã�');
                return;
            end
            
            % Message type.
            mtype = get(obj.fmt_sct, 'value');
            mtype = mtype - 1;
            
            set(obj.edt_echo, 'string', '�������С�ADS-B�źŽ�֯���Գ���...');
            pause(0.3);
            
            % Init the receiver struct.
            rcvPosition = [str2double(get(obj.rcv_edt_lat, 'string')), ...
                str2double(get(obj.rcv_edt_lon, 'string')), ...
                str2double(get(obj.rcv_edt_alt, 'string'))];
            receiver = Receiver(rcvPosition, 0, 0);
            
            % Obtain the simulation time.
            durationTime = 10;
            
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
                set(['�ɻ�', num2str(index_error), '������ջ��ľ������300km�����������ã�']);
            end
            
            planeGenParameter = struct( ...
                'center', planeInitialPosition, ...
                'altitude', [planeInitialPosition(:, 3)'; planeInitialPosition(:, 3)'], ...
                'speed' ,[planeSpeed; planeSpeed], ...
                'azimuth' , [azi; azi], ...
                'power' ,planePower, ...
                'id', plane_id, ...
                'fgt_num', fight_num, ...
                'frqoffset' ,[-feq_err(1); feq_err(1)] ...
                );
            planeFactory = PlaneFactory(planeGenParameter);
            planes = planeFactory.buildPlanes(fnum);
            
            adsbMsgs=Msg1090Factory.buildMessages(planes,durationTime);
            
            for kk = 1 : fnum
%                 adsbMsgs(kk).txTimeSeries = obj.plane_info{kk, 1}.st_tm * (1e-6);
                adsbMsgs(kk).txTimeSeries = obj.plane_info{kk, 1}.st_tm;
                adsbMsgs(kk).type = mtype;
                adsbMsgs(kk).traceSeries = [obj.plane_info{kk, 1}.st_lat, ...
                    obj.plane_info{kk, 1}.st_lon, obj.plane_info{kk, 1}.st_alt];
                adsbMsgs(kk).bitStream = ads_b_source_gen( ...
                    repmat(planes(kk).getICAO(),1,1), ...
                    repmat(planes(kk).getFgtnum(),1,1), ...
                    [obj.plane_info{kk, 1}.st_lat, ...
                    obj.plane_info{kk, 1}.st_lon, obj.plane_info{kk, 1}.st_alt], ...
                    planes(kk).speed*[sin(double(planes(kk).azimuth)) ...
                    cos(double(planes(kk).azimuth)) zeros(size(planes(kk).azimuth))], ...
                    mtype ...
                    );
            
%             adsbMsgs(2).txTimeSeries = 0;
%             adsbMsgs(2).type = mtype;
%             adsbMsgs(2).traceSeries = adsbMsgs(2).traceSeries(1, :);
%             adsbMsgs(2).bitStream = adsbMsgs(2).bitStream(1, :);
            end
            
            receiver.receiveMessages(adsbMsgs);
            for kk = 1 : fnum
                adsbMsgs(kk).rxTimeSeries = adsbMsgs(kk).txTimeSeries;
                adsbMsgs(kk).rxPower = obj.plane_info{kk, 1}.rpw;
            end
            
            waveDownloader=WaveDownloader(10);
%             waveDownloader.downloadMessages(adsbMsgs);

            waveDownloader.rxTime = [];
            waveDownloader.bitStream = [];
            waveDownloader.rxPower = [];
            waveDownloader.rxFrqOffset = [];
            for kk = 1 : fnum
                waveDownloader.rxTime = [waveDownloader.rxTime; adsbMsgs(kk).rxTimeSeries];
                waveDownloader.bitStream = [waveDownloader.bitStream; adsbMsgs(kk).bitStream];
                waveDownloader.rxPower = [waveDownloader.rxPower; adsbMsgs(kk).rxPower];
                waveDownloader.rxFrqOffset = [waveDownloader.rxFrqOffset; adsbMsgs(kk).rxFrqOffset];
            end
            waveDownloader.refPower = max(waveDownloader.rxPower);
                
            waveDownloader.ip4438 = ip_addr;
            waveDownloader.playWave(1, 1);
            
            set(obj.edt_echo, 'string', '����ܷɻ�ADS-B�ź�ģ�����������ϣ�');
        end
        
        % Callback function for exit button.
        function button_exit_callback(obj, source, eventdata)
            set(obj.edt_echo, 'string', '�˳�����...');
            pause(0.3);
            
            close(obj.gui_p);
            clear;
            clc;
        end
        
        function button_ip_callback(obj, source, eventdata)
            if isempty(get(obj.ip_edt, 'string'))
                set(obj.edt_echo, 'string', '��������E4438��IP��ַ���ٽ���������ԣ�');
                obj.ip_tst = 0;
                return;
            end
            
            ip_addr = get(obj.ip_edt, 'string');
            ip_split = strsplit(ip_addr, '.');
            if length(ip_split) ~= 4
                set(obj.edt_echo, 'string', 'IP��ַ��ʽ��������������IP��ַ��');
                return;
            end
            
            if ~isempty(find(str2double(ip_split) < 0, 1)) || ~isempty(find(str2double(ip_split) > 255, 1))
                set(obj.edt_echo, 'string', 'IP��ַ�ԡ�.���ŷָ������ַ�ΧΪ[0,255]�����������룡');
                return;
            end
            
            if sum(isnan(str2double(ip_split))) ~= 0
                set(obj.edt_echo, 'string', 'IP��ַ�а����Ƿ��ַ�������������IP��ַ��');
                return;
            end
            
            set(obj.edt_echo, 'string', '���ڲ���PC��E4438֮���������ͨ�ԣ����Ե�...');
            pause(0.4);
            
            ip_addr = get(obj.ip_edt, 'string');
            ip_con = dos(['ping -w 100 -n 1 ', ip_addr]);
            
            if ip_con == 0
                set(obj.edt_echo, 'string', '�����������ɽ������أ�');
                obj.ip_tst = 1;
            else
                set(obj.edt_echo, 'string', '�����������������Լ�E4438��LAN���ã�');
                obj.ip_tst = -1;
                return;
            end
        end
        
        function callback_mapping(obj)
            set(obj.plane_info_btn, 'callback', @obj.button_lookup_callback);
            set(obj.config_man, 'callback', @obj.button_save_config_callback);
            set(obj.config_auto, 'callback', @obj.button_auto_config_callback);
            set(obj.config_sct, 'callback', @obj.button_config_file_callback);
            set(obj.config_con, 'callback', @obj.button_config_callback);
            set(obj.button_rcv, 'callback', @obj.button_receiver_callback);
            set(obj.btn_c1, 'callback', @obj.button_start_callback);
            set(obj.btn_c2, 'callback', @obj.button_exit_callback);
            set(obj.ip_btn, 'callback', @obj.button_ip_callback);
        end
        
        function init_plane_info_inter(obj, fnum)
            plane.icao = [];
            plane.fgt_num = [];
            plane.power = [];
            plane.feq_err = [];
            plane.st_tm = [];
            plane.st_lat = [];
            plane.st_lon = [];
            plane.st_alt = [];
            plane.vh = [];
            plane.az = [];
            plane.rpw = [];
    
            obj.plane_info = cell(fnum, 1);
            for ii = 1 : fnum
                obj.plane_info{ii, 1} = plane;
            end
        end
        
        function check_rcv_param(obj)
            obj.rpc = 0;
            
            % Whether the parameter is configured!
            if isempty(get(obj.rcv_edt_lat, 'string')) || ...
                    isempty(get(obj.rcv_edt_lon, 'string')) || ...
                    isempty(get(obj.rcv_edt_alt, 'string'))
                set(obj.edt_echo, 'string', '���ջ�������δ������ϣ��������ý��ջ�������');
                obj.rpc = 1;
                return;
            end
            
            % Check receiver latitude.
            lat = str2double(get(obj.rcv_edt_lat, 'string'));
            if isnan(lat)
                set(obj.edt_echo, 'string', '���õ�γ���а����Ƿ��ַ���ӦΪ��ֵ�����������ã�');
                obj.rpc = 1;
                return;
            elseif lat < 0 || lat > 90
                set(obj.edt_echo, 'string', '���õ�γ�ȳ�����Χ��ӦΪ[0, 90]�����������ã�');
                obj.rpc = 1;
                return;
            end
            
            % Receiver Longtitude.
            lon = str2double(get(obj.rcv_edt_lon, 'string'));
            if isnan(lon)
                set(obj.edt_echo, 'string', '���õľ����а����Ƿ��ַ���ӦΪ��ֵ�����������ã�');
                obj.rpc = 1;
                return;
            elseif lon < 0 || lon > 180
                set(obj.edt_echo, 'string', '���õľ��ȳ�����Χ��ӦΪ[0, 180]�����������ã�');
                obj.rpc = 1;
                return;
            end
            
            % Receiver height.
            alt = str2double(get(obj.rcv_edt_alt, 'string'));
            if isnan(alt)
                set(obj.edt_echo, 'string', '���õĸ߶��а����Ƿ��ַ���ӦΪ��ֵ�����������ã�');
                obj.rpc = 1;
                return;
            elseif alt <= 0 || alt > 9000
                set(obj.edt_echo, 'string', '���õĸ߶ȳ�����Χ��ӦΪ(0, 9000]������������');
                obj.rpc = 1;
                return;
            end
        end
        
        function check_plane_param(obj)
            fnum = length(obj.plane_info);
            
            for ii = 1 : fnum
                % Plane parameter check.
                if isnan(obj.plane_info{ii, 1}.icao)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '��ICAO�����δ���û��߰����Ƿ��ַ������������ã�']);
                    obj.ppc = 1;
                    return;
                elseif ~isempty(find(num2str(obj.plane_info{ii, 1}.icao) == '.', 1))
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '��ICAO���ΪС����ӦΪ�Ǹ����������������ã�']);
                    obj.ppc = 1;
                    return;
                elseif obj.plane_info{ii, 1}.icao < 0 || obj.plane_info{ii, 1}.icao > 2 ^ 24 - 1
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '��ICAO��ų�����Χ��ӦΪ[0, 16777215]�����������ã�']);
                    obj.ppc = 1;
                    return;
                end
                
                % Flight number check.      
                if isempty(obj.plane_info{ii, 1}.fgt_num)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�ĺ������δ���ã����������ã�']);
                    obj.ppc = 1;
                    return;
                elseif length(obj.plane_info{ii, 1}.fgt_num) > 8
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�ĺ���ų��ȴ���8��Ӧ����8�����������ã�']);
                    obj.ppc = 1;
                    return;
                elseif length(obj.plane_info{ii, 1}.fgt_num) < 8
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�ĺ���ų���С��8�����Զ��ں��治�Ͽո�']);
                    pause(0.5);
                end
                
                grp = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', ...
                    'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', ...
                    'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ' '];
                for jj = 1 : length(obj.plane_info{ii, 1}.fgt_num)
                    if isempty(find(grp == obj.plane_info{ii, 1}.fgt_num(jj), 1))
                        set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                            '�ĺ�����а����Ƿ��ַ���ӦΪ{A~Z, 0~9, �ո�}�����������ã�']);
                        obj.ppc = 1;
                        return;
                    end
                end
                
                % Power check.
                if isnan(obj.plane_info{ii, 1}.power)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�ķ��书����δ���û��߰����Ƿ��ַ������������ã�']);
                    obj.ppc = 1;
                    return;
                elseif obj.plane_info{ii, 1}.power <= 0 || obj.plane_info{ii, 1}.power > 500
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�ķ��书�ʳ�����Χ��ӦΪ(0, 500]�����������ã�']);
                    obj.ppc = 1;
                    return;
                end
                
                % Frequency offset check.
                feq = obj.plane_info{ii, 1}.feq_err;
                if isnan(feq)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�����Ƶ�����δ���û��߰����Ƿ��ַ���ӦΪ�����֣����������ã�']);
                    obj.ppc = 1;
                    return;
                elseif feq < 0 || feq > 1089 * (1e+6)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�����Ƶ��������Χ��ӦΪ[0, 1090MHz]�����������ã�']);
                    obj.ppc = 1;
                    return;
                end
            
                % Plane start Latitude.
                lat = obj.plane_info{ii, 1}.st_lat;
                if isnan(lat)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '����ʼγ��δ���û��߰����Ƿ��ַ���ӦΪ��ֵ�����������ã�']);
                    obj.ppc = 1;
                    return;
                elseif lat < 0 || lat > 90
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '����ʼγ�ȳ�����Χ��ӦΪ[0, 90]�����������ã�']);
                    obj.ppc = 1;
                    return;
                end
            
                % Plane start Longtitude.
                lon = obj.plane_info{ii, 1}.st_lon;
                if isnan(lon)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '����ʼ����δ���û��߰����Ƿ��ַ���ӦΪ��ֵ�����������ã�']);
                    obj.ppc = 1;
                    return;
                elseif lon < 0 || lon > 180
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '����ʼ���ȳ�����Χ��ӦΪ[0, 180]�����������ã�']);
                	obj.ppc = 1;
                    return;
                end
            
                % Plane flying height.
                alt = obj.plane_info{ii, 1}.st_alt;
                if isnan(alt)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�ķ��и߶�δ���û��߰����Ƿ��ַ���ӦΪ��ֵ�����������ã�']);
                    obj.ppc = 1;
                    return;
                elseif alt <= 0 || alt > 300 * (1e+3)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�ķ��и߶ȳ�����Χ��ӦΪ(0, 300000]������������']);
                    obj.ppc = 1;
                    return;
                end
            
                % Plane vh check.
                vh = obj.plane_info{ii, 1}.vh;
                if isnan(vh)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '��ƽ������ٶ�δ���û��߰����Ƿ��ַ���ӦΪ���������������ã�']);
                    obj.ppc = 1;
                    return;
                elseif vh <= 0 || vh > 1000
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '��ƽ������ٶȳ�����Χ��ӦΪ(0, 1000]�����������ã�']);
                    obj.ppc = 1;
                    return;
                end
            
                % Plane azimuth check.
                az = obj.plane_info{ii, 1}.az;
                if isnan(az)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '��ƽ�溽���δ���û��߰����Ƿ��ַ���ӦΪ���������������ã�']);
                    obj.ppc = 1;
                    return;
                elseif az < 0 || az >= 360
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '��ƽ�溽��ǳ�����Χ��ӦΪ[0, 360)�����������ã�']);
                    obj.ppc = 1;
                    return;
                end
                
                % Plane start message time.
                stm = obj.plane_info{ii, 1}.st_tm;
                if isnan(stm)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�ı��ķ���ʱ����δ���û��߰����Ƿ��ַ������������ã�']);
                    obj.ppc = 1;
                    return;
                elseif ~isempty(find(num2str(stm) == '.', 1))
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�ı��ķ���ʱ��ΪС����ӦΪ�Ǹ����������������ã�']);
                    obj.ppc = 1;
                    return;
                elseif stm < 0 || stm > 1880
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '�ı��ķ���ʱ�̳�����Χ��ӦΪ[0, 1880]�����������ã�']);
                    obj.ppc = 1;
                    return;
                end
                
                % Received signal power.
                spw = obj.plane_info{ii, 1}.rpw;
                if isnan(spw)
                    set(obj.edt_echo, 'string', ['�ɻ�', num2str(ii), ...
                        '���źŽ��չ�����δ���û��߰����Ƿ��ַ������������ã�']);
                    obj.ppc = 1;
                    return;
                end
            end
        end
    end
end