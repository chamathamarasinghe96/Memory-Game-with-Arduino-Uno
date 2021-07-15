function sequence = show_pattern(board,round,pause_seq)
    
    %generate a row vector with the elements of random numbers of 1-4
    sequence = randi(4,1,round);
    
    for i=10:13
        pinMode(board,i,'OUTPUT'); 
    end
    
    %displaying the sequence in LEDs
    for j=1:length(sequence)
        if sequence(j)>0 && sequence(j)<5
           
           digitalWrite(board,sequence(j)+9,1);
           readSound(board);
           pause(pause_seq);
           digitalWrite(board,sequence(j)+9,0);
           pause(pause_seq);
            
        end
    end

return