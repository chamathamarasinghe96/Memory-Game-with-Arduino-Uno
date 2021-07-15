function soundTrack(board,sequence,laps)

pinMode(board,9,'OUTPUT');

for j = 1:length(sequence)
   analogWrite(board,9,sequence(j));
   pause(laps);
   analogWrite(board,9,0);
   pause(laps);   
end
