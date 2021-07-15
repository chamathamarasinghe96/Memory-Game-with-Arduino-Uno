function writeRegisters(a,SER_Pin,RCLK_Pin,SRCLK_Pin,numOfRegisterPins,registers)
    digitalWrite(a,RCLK_Pin,0);
    for i=numOfRegisterPins:-1:1
        digitalWrite(a,SRCLK_Pin,0);
        val=registers(i);
        digitalWrite(a,SER_Pin,val);
        digitalWrite(a,SRCLK_Pin,1);
    end
    digitalWrite(a,RCLK_Pin,1);
end
