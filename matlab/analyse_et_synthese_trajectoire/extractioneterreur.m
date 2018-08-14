
fileID = fopen('essai.txt','r');
C = textscan(fileID,'%f %f %f %f %f %f %f\n');
plot(C{1},C{2}-C{5},'r')%erreur en x
hold on;
plot(C{1},C{3}-C{6},'g')%erreur en y
plot(C{1},C{4}-C{7},'b')%erreur en z
fclose(fileID);