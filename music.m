x = 0:0.1:pi/2;
y = 200*sin(x);

pinMode(a,9,'OUTPUT');

for j = 1:length(y)
   analogWrite(a,9,y(j));
   pause(0.05);
   analogWrite(a,9,0);
   pause(0.05);   
end
