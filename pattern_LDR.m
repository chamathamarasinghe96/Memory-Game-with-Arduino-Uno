function sequence_LDR = pattern_LDR(board,seq_length)

    %Initializing a row vector with all elements zero
    sequence_LDR = zeros(1,seq_length);
    
    reference = analogRead(board,0)-200; %As the reference value for all LDRs
    count = 0;
    
    for i=1:seq_length
        while count ~= seq_length
        
            %Getting the LDR readings
            read1 = analogRead(board,0);
            read2 = analogRead(board,1);
            read3 = analogRead(board,2);
            read4 = analogRead(board,3);
            %disp(read1);
      
            if read1 < 200  %Reference value is determined by the light condition of the situation
                sequence_LDR(1,i) = 1;
                readSound(board);
                count = count+1;
                break;
            elseif read2 < 200  %Reference value is determined by the light condition of the situation
                sequence_LDR(1,i) = 2;
                readSound(board);
                count = count+1;
                break;
            elseif read3 < 200  %Reference value is determined by the light condition of the situation
                sequence_LDR(1,i) = 3;
                readSound(board);
                count = count+1;
                break;
            elseif read4 < 200  %Reference value is determined by the light condition of the situation
                sequence_LDR(1,i) = 4;
                readSound(board);
                count = count+1;
                break;
            end
            
        end
        pause(1);
    end
    
return