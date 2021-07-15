function screenShow(a,d,l)

number_of_IC=2;

ns=num2str(d);
l=num2str(l);


    digit=[ 1 1 1 1 1 1 1 1;%OFF
            0 0 0 0 0 0 1 1;%0
            1 0 0 1 1 1 1 1;%1
            0 0 1 0 0 1 0 1;%2
            0 0 0 0 1 1 0 1;%3
            1 0 0 1 1 0 0 1;%4
            0 1 0 0 1 0 0 1;%5
            0 1 0 0 0 0 0 1;%6
            0 0 0 1 1 1 1 1;%7
            0 0 0 0 0 0 0 1;%8
            0 0 0 0 1 0 0 1;%9
            1 1 1 1 1 1 0 1;%-
            1 0 0 0 0 0 1 1;%U
            1 0 0 1 0 0 0 1;%H
            0 1 1 0 0 0 0 1];%E

        row1=1;
        row3=1;
        
        
if length(ns)==1
    
           
    if strcmp(ns,'OFF')
        row1=1;
    elseif strcmp(ns,'-')
        row1=12;
    elseif strcmp(ns,'U')
        row1=13;
    elseif strcmp(ns,'H')
        row1=14;
    elseif strcmp(ns,'E')
        row1=15;
    elseif ns>='0'&&ns<='9'
        row1=ns-'0'+2;
    end
   
end
if length(l)==1
    if strcmp(l,'OFF')
        row3=1;
    elseif strcmp(l,'-')
        row3=12;
    elseif strcmp(l,'U')
        row3=13;
    elseif strcmp(l,'H')
        row3=14;
    elseif strcmp(l,'E')
        row3=15;
    elseif l>='0'&&l<='9'
        row3=l-'0'+2;
    end
    
end

    

        


SER_Pin=2;
RCLK_Pin=3;
SRCLK_Pin=4;

pinMode(a,SER_Pin,'OUTPUT');
pinMode(a,RCLK_Pin,'OUTPUT');
pinMode(a,SRCLK_Pin,'OUTPUT');



digitalWrite(a,SER_Pin,1);
digitalWrite(a,RCLK_Pin,1);
digitalWrite(a,SRCLK_Pin,1);

numOfRegisterPins = number_of_IC*8;

%registers=ones(1,numOfRegisterPins);
%writeRegisters(a,SER_Pin,RCLK_Pin,SRCLK_Pin,numOfRegisterPins,registers);

if number_of_IC==1
registers=[digit(row1,:)];
writeRegisters(a,SER_Pin,RCLK_Pin,SRCLK_Pin,numOfRegisterPins,registers);

elseif number_of_IC==2
 registers=[digit(row1,:) digit(row3,:)];
writeRegisters(a,SER_Pin,RCLK_Pin,SRCLK_Pin,numOfRegisterPins,registers);   

end

end

    
