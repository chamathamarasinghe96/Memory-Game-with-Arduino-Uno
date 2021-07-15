function initialPattern(board)

    pinMode(board,9,'OUTPUT');

    for i=10:13
        pinMode(board,i,'OUTPUT');
    end

    for i=10:13
        digitalWrite(board,i,1);
        pause(0.25);
        digitalWrite(board,9,1);
        pause(0.01);
        digitalWrite(board,i,0);
        pause(0.25);
        digitalWrite(board,9,0);
        pause(0.25);
    end

    for i=10:13
        digitalWrite(board,i,1);
        pause(0.25);
        digitalWrite(board,9,1);
        pause(0.01);
        digitalWrite(board,i,0);
        pause(0.25);
        digitalWrite(board,9,0);
        pause(0.25);        
    end    
    
    for i=1:3 
        
        for j=10:13
            digitalWrite(board,j,1);
        end
        
        digitalWrite(board,9,1);
        pause(0.01);
        digitalWrite(board,9,0);
        pause(0.25);
        
        pause(0.5);
        
        for j=10:13
            digitalWrite(board,j,0);
        end
        
        digitalWrite(board,9,1);
        pause(0.01);
        digitalWrite(board,9,0);
        pause(0.25);
        
        pause(0.5);
    end
    
return