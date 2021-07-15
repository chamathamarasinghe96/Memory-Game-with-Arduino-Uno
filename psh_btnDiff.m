function isPressed1 = psh_btnDiff(board)

    isPressed1 = 0;
    
    while 1
        
        btnRead1 = analogRead(board,4);
        
        if btnRead1 < 1015
            pause(1);
            isPressed1 = 1;
            break;
        end
               
    end

return