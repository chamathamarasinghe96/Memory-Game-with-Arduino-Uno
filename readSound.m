function readSound(board)

    pinMode(board,9,'OUTPUT');

    analogWrite(board,9,210);
    pause(0.1);
    analogWrite(board,9,0);

return