function initialSoundPattern(board)

    %x = [25 250 50 200 75 175 100 150 125 125];
    
    pinMode(board,9,'OUTPUT');
    
    for i=1:2
        for j=1:14
            digitalWrite(board,9,1);
            pause(0.01);
            digitalWrite(board,9,0);
            pause(0.25);
        end
    end
    
return