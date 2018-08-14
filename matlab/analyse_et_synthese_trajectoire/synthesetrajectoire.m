a = 0.5;
c = 1;
t = 5*pi:0.1:10*pi;
x = a*sin(t);
y = a*cos(t);
z = t/(5*pi*c);
figure(1)
scatter3(x, y, z); 
xlabel('x'); ylabel('y'); title('Circula helix');
%On envoi la trajectoire dans le fichier hex.txt
fileID = fopen('demo1.txt','w');
l=length(t);
for i=1:1:l
    fprintf(fileID,'[%f , %f, %f, %f, %f],\n',x(i),y(i),z(i),0,0.1);
end
fclose(fileID);