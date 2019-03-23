function messege_matrix = ads_b_source_gen(ICAO,fgt_num,position,speed,Type)
num_messege=size(position,1);
messege_matrix=zeros(num_messege,112);
poly=[ones(1,13),0,1,zeros(1,6),1,0,0,1];
% ---- %
% 速度单位转换
speed=[speed(:,1)*3600/1852 speed(:,2)*3600/1852+1 speed(:,3)*3.2808399*60/64]+1;
% speed = 100*zeros(size(speed));
% --- %
position(:,3)=position(:,3)*3.2808399/25+1000/25;

for k=1:num_messege
    switch Type(k)
        case 0
            TYPE=my_dec2bin(20,5);
            SS=my_dec2bin(0,2);
            NIC_S_B=1;
            ALT=my_dec2bin(position(k,3),11);
            ALT=[ALT(1:7) 1 ALT(8:11)];
            T=1;
            CPR_F=0;
            [X,Y]=cpr(position(k,1),position(k,2),CPR_F);
            ME=[TYPE,SS,NIC_S_B,ALT,T,CPR_F,Y,X];
        case 1
            TYPE=my_dec2bin(9,5);
            SS=my_dec2bin(0,2);
            NIC_S_B=1;
            ALT=my_dec2bin(position(k,3),11);
            ALT=[ALT(1:7) 1 ALT(8:11)];
            T=1;
            CPR_F=1;
            [X,Y]=cpr(position(k,1),position(k,2),CPR_F);
            ME=[TYPE,SS,NIC_S_B,ALT,T,CPR_F,Y,X];
        case 2
            TYPE=my_dec2bin(19,5);
            SubT=my_dec2bin(1,3);
            ICF=my_dec2bin(0,1);
            Rev_A=0;
            NAC_v=my_dec2bin(1,3);
            if(speed(k,1)>0)
                EW_D=0;
            else
                EW_D=1;
            end
            EW_V=my_dec2bin(abs(speed(k,1)),10);
            if(speed(k,2)>0)
                NS_D=0;
            else
                NS_D=1;
            end
            NS_V=my_dec2bin(abs(speed(k,2)),10);
            VR_Source=0;
            if(speed(k,3)>0)
                VR_sign=0;
            else
                VR_sign=1;
            end
            VR=my_dec2bin(speed(k,3),9);
            Rev_B=my_dec2bin(0,2);
            Diff_B_S=0;
            Diff_B=my_dec2bin(1,7);
            ME=[TYPE,SubT,ICF,Rev_A,NAC_v,EW_D,EW_V,NS_D,NS_V,VR_Source,VR_sign,VR,Rev_B,Diff_B_S,Diff_B];
            if length(ME)~=56
                error=1;
            end
        case 3
            TYPE=my_dec2bin(1,5);
            E_C=my_dec2bin(1,3);
%             IdentChar=[my_dec2bin(1,6),my_dec2bin(1,6),my_dec2bin(1,6),my_dec2bin(1,6),my_dec2bin(1,6),my_dec2bin(1,6),my_dec2bin(1,6),my_dec2bin(1,6)];
%             ichar = dec2bin(fgt_num(k), 48);
            ichar=dec2bin(fgt_num(k), 48);
            ichar_str(1 : 2 : 95) = ichar;
            ichar_str(2 : 2 : 94) = ' ';
            IdentChar = str2num(ichar_str);
            ME=[TYPE,E_C,IdentChar];
        otherwise
    end
    DF=my_dec2bin(17,5);
    CA=my_dec2bin(2,3);
    AA=my_dec2bin(ICAO(k),24);  

    messege_matrix(k,:)=crc_encode([DF,CA,AA,ME],poly);  

end



end

%% 10进制转2进制子函数
function a=my_dec2bin(b,c)
a=abs(dec2bin(round(b),c))-48;
end
%%
% function speed=velocity(position,d_t)
%     position=position';
%     tmp=diff(position(1,:));
%     lat_change=[tmp(1),tmp];
%     tmp=diff(position(2,:));
%     lon_change=[tmp(1),tmp];
%     NS=lat_change*111.7./(1.852*d_t);
%     NS=ceil(NS*3600);
%     EW=lon_change*111.7.*cos(position(1,:))./(1.852*d_t);
%     EW=ceil(EW*3600);
%     speed=[EW',NS'];
% end

%% 校验和生成子函数
function crc_encode_scr=crc_encode(scr,poly)
[M,N]=size(poly);
scrg=[scr,zeros(1,N-1)];
[q,r]=deconv(scrg,poly);
r=abs(r);
for i=1:length(r)
a=r(i);
if(mod(a,2)==0)
r(i)=0;
else
r(i)=1;
end
end
%crc=r(length(scr)+1:end);
crc_encode_scr=bitor(scrg,r);
end

%% CPR编码子函数
function [X,Y]=cpr(lat,lon,type)
%%-----------------------------------------------------------------------%%
% 
% 
%%-----------------------------------------------------------------------%%
if(~type)
    Y=abs(dec2bin(mod(YZ(lat,0),2^17),17))-48;
    X=abs(dec2bin(mod(XZ(lat,lon,0),2^17),17))-48;
else
    Y=abs(dec2bin(mod(YZ(lat,1),2^17),17))-48;
    X=abs(dec2bin(mod(XZ(lat,lon,1),2^17),17))-48;
end
end



function y=Rlat(x,i)
Nb=17;
Dlat0=6.00;
Dlat1=360/59;
if i==0
    y=Dlat0*(YZ(x,0)/(2^Nb)+floor(x/Dlat0));
end
if i==1
    y=Dlat1*(YZ(x,1)/(2^Nb)+floor(x/Dlat1));
end
end

function y=NL(x)
NZ=15;
y=floor(2*pi/acos(1-(1-cos(pi/(2*NZ)))/(cos((pi/180)*abs(x)))^2));
end


function y=Dlon(x,i)
if (NL(Rlat(x,i))-i)>0
    y=360/(NL(Rlat(x,i))-i);
end
if (NL(Rlat(x,i))-i)==0
    y=360;
end
end

function y=YZ(x,i)
Dlat0=6.00;
Dlat1=360/59;
Nb=17;
if i==0
    y=floor(2^Nb*(mod(x,Dlat0)/Dlat0)+1/2);
end
if i==1
    y=floor(2^Nb*(mod(x,Dlat1)/Dlat1)+1/2);
end
end

function z=XZ(x,y,i)
Nb=17;
z=floor(2^Nb*(mod(y,Dlon(x,i))/Dlon(x,i))+1/2);
end

