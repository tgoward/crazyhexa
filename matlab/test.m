r=100;
R1=[0;0;600;0;0;0];
R2=[60;0;600;0;0;0];
R3=[0;60;600;0;0;0];
R4=[0;0;600;60;0;0];
R5=[0;0;600;0;60;0];
R6=[0;0;600;0;0;60];
hold on;
for y=[0:0.1:30]
  [mA]=calculMatrice(y*pi/180,r,R1);
  [mB]=calculMatrice(y*pi/180,r,R2);
  [mC]=calculMatrice(y*pi/180,r,R3);
  [mD]=calculMatrice(y*pi/180,r,R4);
  [mE]=calculMatrice(y*pi/180,r,R5);
  [mF]=calculMatrice(y*pi/180,r,R6);
  p1=plot(y,mA(1),"s",y,mA(2),"+",y,mA(3),"+",y,mA(4),"+",y,mA(5),"+",y,mA(6),"+");
  p2=plot(y,mB(1),"r",y,mB(2),"r",y,mB(3),"r",y,mB(4),"r",y,mB(5),"r",y,mB(6),"r");
  p3=plot(y,mC(1),"g",y,mC(2),"g",y,mC(3),"g",y,mC(4),"g",y,mC(5),"g",y,mC(6),"g");
  p4=plot(y,mD(1),"m",y,mD(2),"m",y,mD(3),"m",y,mD(4),"m",y,mD(5),"m",y,mD(6),"m");
  p5=plot(y,mE(1),"x",y,mE(2),"x",y,mE(3),"x",y,mE(4),"x",y,mE(5),"x",y,mE(6),"x");
  p6=plot(y,mF(1),"k",y,mF(2),"k",y,mF(3),"k",y,mF(4),"k",y,mF(5),"k",y,mF(6),"k");
  xlabel("angle");
  ylabel("forces appliqués par les moteurs");
  title("Force appliquée par les moteurs en fonction de l'angle d'inclinaizon des rotors autour de x");
  end
hold off;