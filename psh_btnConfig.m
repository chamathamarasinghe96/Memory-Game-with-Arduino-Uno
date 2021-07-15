function isPressed = psh_btnConfig(board)

    isPressed = 0;
    
    while 1
        
        btnRead = analogRead(board,5);
        
        if btnRead < 1015
            isPressed = 1;
            break;
        end
    end

return