close all
clear all

Ntu=0:0.1:6;
for k=1:4
    C=0.25*k;
    n=Ntu.^(-0.22);
    temp=exp(-Ntu*C.*n)-1;
    Eff(k,:)=1-exp(temp./(C*n));
end

Ntu1=[0.3566 1.1249 1.6873 2.2498 3.3747 4.4995];
Esim1=[0.2600 0.5014 0.5834 0.6349 0.6989 0.7380];
 
Ntu2=[5.3121 3.9840 2.6560 1.9920 1.3280 0.6640 0.3320];
Esim2=[0.8379 0.7965 0.7274 0.6704 0.5794 0.4089 0.2548];
 
Ntu3=[0.4104 0.8208 1.6415 2.4623 3.2830 4.9245];
Esim3=[0.3101 0.4915 0.6834 0.7797 0.8367 0.9001];
 
Ntu4=[4.4645 3.3483 2.2322 1.1661 0.5581];
Esim4=[0.9478 0.9080 0.8253 0.6236 0.4061];


figure('color',[1 1 1],'position',[50 50 500 400])
hold on
for k=1:4
plot(Ntu,Eff(k,:),'b');
end
size_y=0.025;
for i=1:length(Ntu1) % C=0.25
    line([Ntu1(i)-0.1,Ntu1(i)+0.1],[Esim1(i) Esim1(i)],'color','r')
    line([Ntu1(i),Ntu1(i)],[Esim1(i)-size_y Esim1(i)+size_y],'color','r')
end

for i=1:length(Ntu2) % C=0.5
    line([Ntu2(i)-0.1,Ntu2(i)+0.1],[Esim2(i) Esim2(i)],'color','r')
    line([Ntu2(i),Ntu2(i)],[Esim2(i)-size_y Esim2(i)+size_y],'color','r')
end

for i=1:length(Ntu3) % C=0.75
    line([Ntu3(i)-0.1,Ntu3(i)+0.1],[Esim3(i) Esim3(i)],'color','r')
    line([Ntu3(i),Ntu3(i)],[Esim3(i)-size_y Esim3(i)+size_y],'color','r')
end

for i=1:length(Ntu4) % C=1
    line([Ntu4(i)-0.1,Ntu4(i)+0.1],[Esim4(i) Esim4(i)],'color','r') 
    line([Ntu4(i),Ntu4(i)],[Esim4(i)-size_y Esim4(i)+size_y],'color','r')
end


%title('Effectiveness versus $ntu$','interpreter','latex')
xlabel('$ntu$','interpreter','latex')
ylabel('Effectiveness','interpreter','latex')
line([2 2.5],[0.5 0.5],'color','b')
text(2.7,0.5, 'Analytical solutions','interpreter','latex')
line([2 2.2],[0.4 0.4],'color','r')
line([2.1 2.1], [0.4-size_y 0.4+size_y],'color','r')
text(2.3, 0.4,'Solution for $20\times20\times3$ blocks','interpreter','latex')
text(3,0.65,'$C=0.25$','interpreter','latex')
text(3.5,0.76,'$C=0.5$','interpreter','latex')
text(4,0.85,'$C=0.75$','interpreter','latex')
text(2.7,0.92,'$C=1$','interpreter','latex')