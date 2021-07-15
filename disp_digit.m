 % pinMode(a,11,'OUTPUT'); %   Common cathod(-) method
% digitalWrite(a,11,0);

function disp_digit(board,digit)

for i=2:8
   pinMode(board,i,'OUTPUT'); 
end

pins = [ 0 0 0 0 0 0 0; %OFF
        1 1 0 1 1 1 1; %0
        0 1 0 1 0 0 0; %1
        1 1 1 0 1 1 0; %2
        1 1 1 1 1 0 0; %3
        0 1 1 1 0 0 1; %4
        1 0 1 1 1 0 1; %5
        1 0 1 1 1 1 1; %6
        1 1 0 1 0 0 0; %7
        1 1 1 1 1 1 1; %8
        1 1 1 1 1 0 1]; %9
    
if strcmp(digit,'OFF')
    
    for j=2:8
        digitalWrite(board,j,pins(1,j-1));    
    end
    
else
    for i=1:10
    
        if strcmp(digit,num2str(i-1))
            for j=2:8
                digitalWrite(board,j,pins(i+1,j-1));
            end
        end 
    end
end
    
return