function tonePlay(board,laps)

    pinMode(board,9,'OUTPUT');
    
    for i=1:2
        
        digitalWrite(board,9,1);
        pause(laps);
        digitalWrite(board,9,0);
        pause(laps);
        
    end

return