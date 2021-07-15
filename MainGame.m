
round = 1;
points = 0;
btn_diff = 0;
initialPattern(a);
screenShow(a,0,0);
winningSound = [5 10 20 30 200 180 170 160 150 100 110 120 130 140 50 40 30 20 10 5];
looseSound = [225 200 175 150 125 100 75 50 25 0];
mac_sequence = 0;
user_sequence = 0;
btnDiffRead = 0;
btnConfigRead = 0;
diff_level = 0; %Difficult

%while 1

%     btn_diff = btn_diff + psh_btnDiff(a);
%     fprintf('btn_diff : %d\n',btn_diff);
%     disp_digit(a,num2str(btn_diff));
%    
%     btnRead = analogRead(a,5);
%         
%         if btnRead < 1015
%             pause(1);
%             btnConfig = 1;
%             break;
%         end
    
% while diff_level<4
    while 1
        btnDiffRead = analogRead(a,4);
        btnConfigRead = analogRead(a,5);
        fprintf('%d  %d\n',btnDiffRead,btnConfigRead);
    
        if btnDiffRead < 700
            pause(1);
            fprintf('%d  %d\n',btnDiffRead,btnConfigRead);
            diff_level = diff_level+1;
            if diff_level < 1 || diff_level > 3
               diff_level = 1; 
               screenShow(a,0,diff_level);
               tonePlay(a,0.02);
            end
            screenShow(a,0,diff_level);
            
        end
        
        if btnConfigRead < 700
            tonePlay(a,0.02);
            break;
        end        
    end
   
    
%end


%     while 1
%         
%         btnRead1 = analogRead(board,4);
%         
%         if btnRead1 < 1015
%             pause(1);
%             isPressed = 1;
%             btn_diff = btn_diff + isPressed;
%             disp_digit(a,num2str(btn_diff));
%             
%             btnRead = analogRead(board,5);
%         
%             if btnRead < 1015
%                 isPressed = 1;
%                 break;
%             end
%         end
%     end
%     if value2==1
%         fprintf('value in if : %d\n',value2);
%         break;
%     end
    
%end

if diff_level == 1 
   pause_seq = 2;   %Easy Level
   screenShow(a,'E',diff_level);
elseif diff_level == 2 
   pause_seq = 1;   %Moderate Level
   screenShow(a,'U',diff_level);
else
   pause_seq = 0.5; %Difficult level
   screenShow(a,'H',3);
end

pause(4);
    

%fprintf('pause_seq : %d\n',value);


while round<5
    
    for k=1:2
        screenShow(a,round,0);
        pause(1);
        screenShow(a,'OFF',0);
        pause(1);
    end
    level = 1;
    while level<4
        
        screenShow(a,round,level);
        pause(1);
        
        mac_sequence = show_pattern(a,round+3,pause_seq);
        disp(mac_sequence);        
        
        tonePlay(a,0.1);
        user_sequence = pattern_LDR(a,round+3);
        
        
        if mac_sequence == user_sequence
           soundTrack(a,winningSound,0.05);
           level = level + 1;
        else
           soundTrack(a,looseSound,0.25);
           break;
        end    
        
        pause(2);
        
%         if mac_sequence ~= user_sequence
%             break;
%         end
    end
    
    if isequal(mac_sequence , user_sequence)
            
        round = round + 1;

        points = points + 1;
    else
        break;
    end

    
end
 
disp(points);
screenShow(a,0,points);
