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
        
        % Plane number.�ɻ�����
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
    
        
      
        
        % Panel handle of the plane settings panel.�ɻ�1,2,3��panel
        panel_plane_1;
        panel_plane_2;
        panel_plane_3;
        plane_txt_times;%����ʱ��
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
                'Numbertitle', 'off', 'Name', '�����Ǽ�ģʽ', ...
                'Position', [floor((obj.width - obj.gui_width) / 2), ...
                floor((obj.height - obj.gui_height) / 2), obj.gui_width, ...
                obj.gui_height], 'Toolbar', 'none', 'Resize', 'off');
            
            % Plane number settings.
            obj.plane_num_txt = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','�ɻ�����','position',[15 ...
                obj.gui_height - 60 80 40]);
            obj.plane_num_edt = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[96 obj.gui_height - 50 ...
              60 40]);
          
               % Init ����ʱ��
            obj.plane_txt_times = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','����ʱ��(s)','position',[160 ...
                obj.gui_height - 60 100 40]);
            obj.plane_edt_times = uicontrol('parent', obj.gui_p, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[271 obj.gui_height - 50 ...
              100 40]);
         
      
          
            % Automatic configure.�Զ����÷ɻ�����������
            obj.config_auto = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '�Զ����÷ɻ����������з���', ...
                'Fontsize', 12, 'position', [420, obj.gui_height - 50, 240, 40]);
            
          
            
            % Create plane param settings panel.
            obj.panel_plane_1 = uipanel('parent', obj.gui_p, 'Units', ...
                'pixels', 'BackgroundColor', [0.83, 0.82, 0.78], 'title', ...
                '�ɻ�һ������������', 'Fontsize', 15, 'Position', [25, ...
                obj.gui_height - obj.panel_height - 60, obj.panel_width-10, ...
                obj.panel_height]);
            % panleλ������
            edit_area_width=120;%�ı���Ŀ�ȹ̶�Ϊ100
            txt_area_width_label=130;%label����Ϊ130
            
            % The first row in the panel.
         
            % Init the Lattitude text for plane param.
            obj.plane_txt_lat1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','��ʼγ��(N,��)','position',[0 obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lat1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[txt_area_width_label+1 obj.panel_height - 80 ...
              edit_area_width 40]);
             
          
          
            % Init the Longtitude text for the plane.
            obj.plane_txt_lon1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','��ʼ����(E,��)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lon1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
        
 
            % Init the transmit power of the plane.
            obj.plane_txt_pw1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','����(dbm)','position',[4+(2*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_pw1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white','Fontsize',11,'position', ...
                [5+(3*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 edit_area_width 40]);
            % Init the height text for the plane.
            obj.plane_txt_alt1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','���и߶�(��)','position',[6+(3*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_alt1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[7+(4*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
       
        
            % Init the velocity text for the plane.
            obj.plane_txt_vh1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','ƽ������ٶ�(km/h)','position',[0 obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_vh1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[1+(txt_area_width_label) obj.panel_height - 130 ...
              edit_area_width 40]);
         
         
            % Init the azimuth of the plane.
            obj.plane_txt_az1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','ƽ�溽���(��)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_az1 = uicontrol('parent', obj.panel_plane_1, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
              edit_area_width 40]);
          
       
          
          % ��ʼ���õڶ����ɻ��Ĳ���
           % Create plane param settings panel.
           obj.panel_plane_2 = uipanel('parent', obj.gui_p, 'Units', ...
                'pixels', 'BackgroundColor', [0.83, 0.82, 0.78], 'title', ...
                '�ɻ���������������', 'Fontsize', 15, 'Position', [25, ...
                obj.gui_height - 2*obj.panel_height - 60, obj.panel_width-10, ...
                obj.panel_height]);
            % panleλ������
            edit_area_width=120;%�ı���Ŀ�ȹ̶�Ϊ100
            txt_area_width_label=130;%label����Ϊ130
            
            % The first row in the panel.
         
            % Init the Lattitude text for plane param.
            obj.plane_txt_lat2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','��ʼγ��(N,��)','position',[0 obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lat2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[txt_area_width_label+1 obj.panel_height - 80 ...
              edit_area_width 40]);
             
          
          
            % Init the Longtitude text for the plane.
            obj.plane_txt_lon2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','��ʼ����(E,��)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lon2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
        
 
            % Init the transmit power of the plane.
            obj.plane_txt_pw2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','����(dbm)','position',[4+(2*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_pw2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white','Fontsize',11,'position', ...
                [5+(3*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 edit_area_width 40]);
            % Init the height text for the plane.
            obj.plane_txt_alt2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','���и߶�(��)','position',[6+(3*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_alt2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[7+(4*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
       
        
            % Init the velocity text for the plane.
            obj.plane_txt_vh2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','ƽ������ٶ�(km/h)','position',[0 obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_vh2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[1+(txt_area_width_label) obj.panel_height - 130 ...
              edit_area_width 40]);
         
         
            % Init the azimuth of the plane.
            obj.plane_txt_az2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','ƽ�溽���(��)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_az2 = uicontrol('parent',obj.panel_plane_2, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
              edit_area_width 40]);
          
         
          
          % �ڶ����ɻ������������
          
          % ��ʼ���õ������ɻ��Ĳ���
           % Create plane param settings panel.
           obj.panel_plane_3 = uipanel('parent', obj.gui_p, 'Units', ...
                'pixels', 'BackgroundColor', [0.83, 0.82, 0.78], 'title', ...
                '�ɻ���������������', 'Fontsize', 15, 'Position', [25, ...
                obj.gui_height - 3*obj.panel_height - 60, obj.panel_width-10, ...
                obj.panel_height]);
            % panleλ������
            edit_area_width=120;%�ı���Ŀ�ȹ̶�Ϊ100
            txt_area_width_label=130;%label����Ϊ130
            
            % The first row in the panel.
         
            % Init the Lattitude text for plane param.
            obj.plane_txt_lat3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','��ʼγ��(N,��)','position',[0 obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lat3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[txt_area_width_label+1 obj.panel_height - 80 ...
              edit_area_width 40]);
             
          
          
            % Init the Longtitude text for the plane.
            obj.plane_txt_lon3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','��ʼ����(E,��)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_lon3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
        
 
            % Init the transmit power of the plane.
            obj.plane_txt_pw3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','����(dbm)','position',[4+(2*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_pw3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white','Fontsize',11,'position', ...
                [5+(3*txt_area_width_label+2*edit_area_width) obj.panel_height - 80 edit_area_width 40]);
            % Init the height text for the plane.
            obj.plane_txt_alt3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','���и߶�(��)','position',[6+(3*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
                txt_area_width_label 40]);
            obj.plane_edt_alt3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white'...
              ,'Fontsize',11,'position',[7+(4*txt_area_width_label+3*edit_area_width) obj.panel_height - 80 ...
              edit_area_width 40]);
       
        
            % Init the velocity text for the plane.
            obj.plane_txt_vh3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','ƽ������ٶ�(km/h)','position',[0 obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_vh3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[1+(txt_area_width_label) obj.panel_height - 130 ...
              edit_area_width 40]);
         
         
            % Init the azimuth of the plane.
            obj.plane_txt_az3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 11, ...
                'string','ƽ�溽���(��)','position',[2+(txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
                txt_area_width_label 40]);
            obj.plane_edt_az3 = uicontrol('parent',obj.panel_plane_3, 'style', ...
                'edit', 'BackgroundColor','white' ...
              ,'Fontsize',11,'position',[3+(2*txt_area_width_label+edit_area_width) obj.panel_height - 130 ...
              edit_area_width 40]);
          
          
          % �������ɻ������������
          
          
            % Create handle for button "Start programme".
            obj.btn_c1 = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '��ʼ', ...
                'Fontsize', 15, 'position', [floor((obj.gui_width - 400) / 2), ...
                30, 150, 50]);
            % Create handle for button "Stop programme"��
            obj.btn_c2 = uicontrol('parent', obj.gui_p, ...
                'style', 'pushbutton', 'BackgroundColor', ...
                [0.83, 0.82, 0.78], 'string', '�˳�', ...
                'Fontsize', 15, 'position', [floor((obj.gui_width - 450) / 2) + 250, ...
                30, 150, 50]);
               % Create echo info window.
            obj.txt_echo = uicontrol('parent', obj.gui_p, 'style', ...
                'text', 'BackgroundColor', [0.83 0.82 0.78], 'Fontsize', 12, ...
                'string','����״̬��Ϣ','position',[240 ...
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
                set(obj.edt_echo, 'string', '��δ���÷ɻ��������������÷ɻ�������');
                return;
            end
            
            if isempty(get(obj.plane_edt_times, 'string'))
                set(obj.edt_echo, 'string', '��δ���÷���ʱ�䣬�������÷���ʱ�䣡');
                return;
            end
            
            fnum = str2double(get(obj.plane_num_edt, 'string'));
            if isnan(fnum)
                set(obj.edt_echo, 'string', '���õķɻ������а����Ƿ��ַ���ӦΪ�����������������ã�');
                return;
            elseif ~isempty(find(get(obj.plane_num_edt, 'string') == '.', 1))
                set(obj.edt_echo, 'string', '���õķɻ�����ΪС����ӦΪ�����������������ã�');
                return;
            elseif fnum <= 0 || fnum > 100
                set(obj.edt_echo, 'string', '���õķɻ�����������Χ��ӦΪ(0, 100]�����������ã�');
                return;
            end
            
            ftime = str2double(get(obj.plane_edt_times, 'string'));
            if isnan(ftime)
                set(obj.edt_echo, 'string', '���õķ���ʱ���а����Ƿ��ַ���ӦΪ��ֵ�����������ã�');
                return;
            elseif ftime <= 0 || ftime > 60
                set(obj.edt_echo, 'string', '���õķ���ʱ�䳬����Χ��ӦΪ(0, 60]�����������ã�');
                return;
            end
            % ��������Ҫ�������������������ķɻ���Ϣ����
            
            
            % ������������ͯ�ķ������ݲ��������з���
      
          
        end
        
      
       
     
        
        % Callback function for button start.
        function button_start_callback(obj, source, eventdata)
            if isempty(get(obj.plane_num_edt, 'string'))
                set(obj.edt_echo, 'string', '��δ���÷ɻ��������������÷ɻ�������');
                return;
            end
            
            if isempty(get(obj.plane_edt_times, 'string'))
                set(obj.edt_echo, 'string', '��δ���÷���ʱ�䣬�������÷���ʱ�䣡');
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
            
            ftime = str2double(get(obj.plane_edt_times, 'string'));
            if isnan(ftime)
                set(obj.edt_echo, 'string', '���õķ���ʱ���а����Ƿ��ַ���ӦΪ��ֵ�����������ã�');
                return;
            elseif ftime <= 0 || ftime > 60
                set(obj.edt_echo, 'string', '���õķ���ʱ�䳬����Χ��ӦΪ(0, 60]�����������ã�');
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
            
            set(obj.edt_echo, 'string', '�������С���ܷɻ�ADS-B�ź�ģ�����...');
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
            end
        end
    end
end