close all
clear all

% tauh=1;
% NuT=2;
% ah=NuT/tauh;
% gam1=2;
% beta=ah+gam1;
%  
% % Time response
% tfin=8;
% Ts=0.01;
% d1=gam1/beta;
% d2=1-d1;
%  
% t=0:Ts:tfin;
%  
% h1=ah*(1-exp(-beta*t))/beta;
% h2=ah*exp(-tauh*ah)*(d1+d2*exp(-beta*t));
% h3=besseli(0,2*sqrt(tauh*ah*gam1*t));
% h3=h3.*exp(-gam1*t);
% h4=conv(h2,h3);
% h4=h4*Ts;
% h4=h4(:,1:floor(length(h4)/2)+1);
% h4=[zeros(1,tauh/Ts) h4(1,1:end-length(zeros(1,tauh/Ts)))];
% h5=h1-h4;
%  
% s5=conv(h5,ones(1,length(h5)));
% s5=s5*Ts;
% s5=s5(:,1:floor(length(s5)/2)+1);
%  
% NUT_I=[t' NuT/20*ones(size(t'))];
% Thi=[t' zeros(size(t'))];
% TAU_I=[t' tauh/20*ones(size(t'))];
% gamma_I=[t' gam1*ones(size(t'))];
% delta_I=[t' ones(size(t'))];
% 
% sim('./electrical_heater')

load fig_simulink_vs_analytic_transient
figure('color',[1 1 1],'position',[50 50 500 600])

subplot(2,1,1), hold on
plot(t,s5,'color','black');
plot(t,T_out_simulink,'k','color','red')
title('Normalized step response for $T_h$','interpreter','latex')
legend('Analytical solution','Solution for 20 cells','Location','SouthEast')

subplot(2,1,2)
plot(t,s5'-T_out_simulink)
title('Differential','interpreter','latex')
