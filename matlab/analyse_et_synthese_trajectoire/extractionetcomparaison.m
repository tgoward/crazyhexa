%t:temps
%x:coordonnée du drone en x
%y:coordonnée du drone en y
%z:coordonnée du drone en z
%Wx:coordonnée du waypoint en x
%Wy:coordonnée du waypoint en y
%Wz:coordonnée du waypoint en z
%r:angle de rotation du drone autour de x (roulis)
%p:angle de rotation du drone autour de y (tangage)
%yaw:angle de rotation du drone autour de z (lacet)

%--------------------------------extractions de ros
close all
clear all

fileID = fopen('trajectoire_finale/trajectoire_effectuee.txt','r');
%---------------------t x  y  z  Wx Wy Wz r  p  yaw
C = textscan(fileID,'%f %f %f %f %f %f %f %f %f %f\n');
plot3(C{2},C{3},C{4},'k',"LineWidth",2)
hold on
plot3(C{2}(1:250:end),C{3}(1:250:end),C{4}(1:250:end),'k+',"LineWidth",2)
xlabel('x');
ylabel('y');
zlabel('z');
fclose(fileID);


%--------------------------------trajectoire théorique
hold on
fileID = fopen('trajectoire_finale/trajectoire_demandee.txt','r');
%---------------------x   y   z  yaw  sleep
C = textscan(fileID,'[%f, %f, %f, %f, %f],');
plot3(C{1},C{2},C{3},'b:o',"LineWidth",2);
fclose(fileID);
