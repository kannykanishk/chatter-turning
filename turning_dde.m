 clc;
 clear;
 close all;
 tf=0.12;
 sol = ddesd(@ddefunc,@delays,@yhist,[0 tf]);
 t=linspace(0,tf,60000);
 y=deval(sol,t);
 figure;
 subplot(1,1,1);
 plot(t,y);
 title('Surface Topology vs Time')
 xlabel('time (s)')
 ylabel('y (m)')
 grid on;
 
 function d=delays(~,y)
    d=0.015;
 end
 
 function yp = ddefunc(~,y,YL)
 yp=[ y(2)
      (2967853*YL(1)-(7514351)*y(1)-101.5*y(2))];
 end  
 
 function y=yhist(t)
   y=[-1e-6 0];
 end