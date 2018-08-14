function[M]=calculMatrice(y,r)
  %fx=[0,sqrt(3)*sin(y)/2,-sqrt(3)*sin(y)/2,0,sqrt(3)*sin(y)/2,-sqrt(3)*sin(y)/2];
  %fy=[sin(y),-sin(y)/2,-sin(y)/2,sin(y),-sin(y)/2,-sin(y)/2];
  %fz=[cos(y),cos(y),cos(y),cos(y),cos(y),cos(y)];
  %rx=[0,r*sqrt(3)*cos(y)/2,r*sqrt(3)*cos(y)/2,0,-r*sqrt(3)*cos(y)/2,-r*sqrt(3)*cos(y)/2];
  %ry=[-r*cos(y),-r*cos(y)/2,r*cos(y)/2,r*cos(y),r*cos(y)/2,-r*cos(y)/2];
  %rz=[r*sin(y),-r*sin(y),r*sin(y),-r*sin(y),r*sin(y),-r*sin(y)];
  %M=[fx;fy;fz;rx;ry;rz];
  M=[0,sqrt(3)*sin(y)/2,-sqrt(3)*sin(y)/2,0,sqrt(3)*sin(y)/2,-sqrt(3)*sin(y)/2;sin(y),-sin(y)/2,-sin(y)/2,sin(y),-sin(y)/2,-sin(y)/2;cos(y),cos(y),cos(y),cos(y),cos(y),cos(y);0,r*sqrt(3)*cos(y)/2,r*sqrt(3)*cos(y)/2,0,-r*sqrt(3)*cos(y)/2,-r*sqrt(3)*cos(y)/2;-r*cos(y),-r*cos(y)/2,r*cos(y)/2,r*cos(y),r*cos(y)/2,-r*cos(y)/2;r*sin(y),-r*sin(y),r*sin(y),-r*sin(y),r*sin(y),-r*sin(y)];
  