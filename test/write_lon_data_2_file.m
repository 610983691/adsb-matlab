function write_lon_data_2_file(londata)

fid=fopen('lonData.txt','w');
rows = size(londata,1);
columns = size(londata,2);
%����row��
for row = 1:rows
    one_row_data= londata(row,:);%��ȡ��i�е�����
    for col = 1:columns
        data=one_row_data(1,col);%��ȡһ��γ������
        fprintf(fid,'%3.12f',data);
        if col~=columns
            fprintf(fid,'%s',',');%ÿ�������Զ��ŷָ�,���һ�����ݲ��ָ�
        end
    end
    fprintf(fid,'%s',';');%ÿ������������;�ֺŷָ�
end
fclose(fid);
end