classdef Plane < FlyObject
    %PLANE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id
        fgt_num;
        txPower %dBm
        frqOffset
    end
    
    methods
        function obj = Plane(par)
            obj = obj@FlyObject(par.initialPosition,par.azimuth,par.speed);
            obj.id = par.id;
            obj.fgt_num = par.fgt_num;
            obj.txPower = par.txPower;
            obj.frqOffset = par.frqOffset;
        end
        
        function fgt = getFgtnum(obj)
            fgt_number = obj.fgt_num;
            fgt_bin = zeros(1, 48);
            
            for ii = 1 : length(fgt_number)
                switch (fgt_number(ii))
                    case 'A'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(1),6))-48;
                    case 'B'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(2),6))-48;
                    case 'C'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(3),6))-48;
                    case 'D'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(4),6))-48;
                    case 'E'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(5),6))-48;
                    case 'F'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(6),6))-48;
                    case 'G'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(7),6))-48;
                    case 'H'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(8),6))-48;
                    case 'I'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(9),6))-48;
                    case 'J'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(10),6))-48;
                    case 'K'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(11),6))-48;
                    case 'L'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(12),6))-48;
                    case 'M'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(13),6))-48;
                    case 'N'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(14),6))-48;
                    case 'O'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(15),6))-48;
                    case 'P'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(16),6))-48;
                    case 'Q'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(17),6))-48;
                    case 'R'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(18),6))-48;
                    case 'S'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(19),6))-48;
                    case 'T'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(20),6))-48;
                    case 'U'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(21),6))-48;
                    case 'V'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(22),6))-48;
                    case 'W'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(23),6))-48;
                    case 'X'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(24),6))-48;
                    case 'Y'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(25),6))-48;
                    case 'Z'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(26),6))-48;
                    case ' '
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(32),6))-48;
                    case '0'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(48),6))-48;
                    case '1'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(49),6))-48;
                    case '2'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(50),6))-48;
                    case '3'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(51),6))-48;
                    case '4'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(52),6))-48;
                    case '5'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(53),6))-48;
                    case '6'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(54),6))-48;
                    case '7'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(55),6))-48;
                    case '8'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(56),6))-48;
                    case '9'
                        fgt_bin((ii-1)*6+1 : ii*6) = abs(dec2bin(round(57),6))-48;
                end
            end
            fgt_str = num2str(fgt_bin);
            fgt_str(fgt_str == ' ') = [];
            fgt = bin2dec(fgt_str(1 : 48));
        end
        
        function id = getICAO(obj)
            id=obj.id;
        end
        
    end
    
end

