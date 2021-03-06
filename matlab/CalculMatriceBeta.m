beta=20*pi/180;
teta=60*pi/180;
r=0.05;
Fx=[sin(-beta)*cos(0) sin(beta)*cos(teta) sin(-beta)*cos(2*teta) sin(beta)*cos(3*teta) sin(-beta)*cos(4*teta) sin(beta)*cos(5*teta)];
Fy=[sin(-beta)*sin(0) sin(beta)*sin(teta) sin(-beta)*sin(2*teta) sin(beta)*sin(3*teta) sin(-beta)*sin(4*teta) sin(beta)*sin(5*teta)];
Fz=[cos(-beta) cos(beta) cos(-beta) cos(beta) cos(beta) cos(beta)];
Mx=[r*sin(0)*cos(-beta) r*sin(teta)*cos(beta) r*sin(2*teta)*cos(-beta) r*sin(3*teta)*cos(beta) r*sin(4*teta)*cos(-beta) r*sin(5*teta)*cos(beta)];
My=[-r*cos(0)*cos(-beta) -r*cos(teta)*cos(beta) -r*cos(2*teta)*cos(-beta) -r*cos(3*teta)*cos(beta) -r*cos(4*teta)*cos(-beta) -r*cos(5*teta)*cos(beta)];
Mz=[cos(-beta) cos(beta) cos(-beta) cos(beta) cos(beta) cos(beta)];
Mefforts=[Fx;Fy;Fz;Mx;My;Mz]
rang=rank(Mefforts)