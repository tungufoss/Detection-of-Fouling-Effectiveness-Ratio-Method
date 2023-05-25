clear all
close all

% load data/data_useful_fouling_42

data=getdatasets(42:42,'Oggi_long');
lengd = length(data.set001.clean.Thi);

temps=1:lengd;
%instantaneous effectiveness
Eff_h_clean=(data.set001.clean.Thi(temps)-data.set001.clean.Tho(temps))./(data.set001.clean.Thi(temps)-data.set001.clean.Tci(temps));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INPUTS
figure('position', [50 50 600 400],'color',[1 1 1])
subplot(2,2,2)
plot(temps/lengd,data.set001.clean.m_c(temps),'b')
title('Mass flow rate (cold fluid)','interpreter','latex')
ylabel('$\frac{kg}{s}$','interpreter','latex')
axis([temps(1)/lengd temps(end)/lengd 0.4 1.4])
%xlabel('Sample $\#$','interpreter','latex')
subplot(2,2,1)
plot(temps/lengd,data.set001.clean.m_h(temps),'r')
title('Mass flow rate (hot fluid)','interpreter','latex')
ylabel('$\frac{kg}{s}$','interpreter','latex')
axis([temps(1)/lengd temps(end)/lengd 0.4 1.4])
%xlabel('Sample $\#$','interpreter','latex')
subplot(2,2,4)
plot(temps/lengd,data.set001.clean.Tci(temps),'b')
title('Inlet temperature (cold fluid)','interpreter','latex')
ylabel('$^\circ C$','interpreter','latex')
xlabel('Dimensionless time, $t$','interpreter','latex')
axis([temps(1)/lengd temps(end)/lengd 14 26])
subplot(2,2,3)
plot(temps/lengd,data.set001.clean.Thi(temps),'r')
title('Inlet temperature (hot fluid)','interpreter','latex')
ylabel('$^\circ C$','interpreter','latex')
xlabel('Dimensionless time, $t$','interpreter','latex')
axis([temps(1)/lengd temps(end)/lengd 54 66])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTPUT

figure('position', [600 50 600 300],'color',[1 1 1])
subplot(1,2,2)
hold on
plot(temps/lengd,data.set001.clean.Tco(temps),'b','linewidth', 2)
title('Outlet temperature (cold fluid)','interpreter','latex')
ylabel('$^\circ C$','interpreter','latex')
xlabel('Dimensionless time, $t$','interpreter','latex')
axis([temps(1)/lengd temps(end)/lengd 20 33])
subplot(1,2,1)
hold on
plot(temps/lengd,data.set001.clean.Tho(temps),'r','linewidth', 2)
title('Outlet temperature (hot fluid)','interpreter','latex')
ylabel('$^\circ C$','interpreter','latex')
xlabel('Dimensionless time, $t$','interpreter','latex')
axis([temps(1)/lengd temps(end)/lengd 44 66])
%instantaneous effectiveness
Eff_h_fouling=(data.set001.fouling.Thi(temps)-data.set001.fouling.Tho(temps))./(data.set001.fouling.Thi(temps)-data.set001.fouling.Tci(temps));
subplot(1,2,2)
plot(temps/lengd,data.set001.fouling.Tco(temps),'b')
legend('Without fouling','With fouling','Location','SouthEast')
subplot(1,2,1)
plot(temps/lengd,data.set001.fouling.Thi(temps),'r')
legend('Without fouling','With fouling','Location','SouthEast')
axes('position',[0 0 1 1])

% line([0.3 0.7],[0.045 0.045],'color',[0 0 0])
% text(0.7,0.05,'\rightarrowsample #','verticalalignment','middle')
axis([0 1 0 1])
axis off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%figure('position',[100 600 300 ,150],'color',[1 1 1])
%plot(Rf)
%text(length(Rf),0,'Sample # ','horizontalalignment','right','verticalalignment', 'bottom')
%text(100,3.9e-4,'Fouling factor (m².K/W)','horizontalalignment','left','verticalalignment', 'top')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Figure 4 - Effectiveness
figure('position',[50 300 600 ,400],'color',[1 1 1])
hold on
plot(temps/lengd,Eff_h_clean,'color',[0.5 0.5 0.5],'linewidth',2)
plot(temps/lengd,Eff_h_fouling,'k')
xlabel('Dimensionless time, $t$','interpreter','latex')
legend('Without fouling','With fouling')
axis([temps(1)/lengd temps(end)/lengd min([Eff_h_fouling;Eff_h_clean]) max([Eff_h_fouling;Eff_h_clean])])
%title('Instantaneous effectiveness','interpreter','latex')