% time step
dt=0.1;
%number of time steps;
m=9999;
m_1=floor(m/10);
rand('state',sum(100*clock))
%number of modules (in each direction)
n=20;
% time
t=0:dt:m*dt;
% final time
t_f=m*dt;
% Mass flow.
t_c_points=50;
m_c_points_basis=[1 1.2 0.8 0.6];
m_c_points=[];
for i=1:t_c_points;
    m_c_points=[m_c_points m_c_points_basis];
end
index_c=randperm(length(m_c_points));
m_c_points=m_c_points(index_c);
%time step for m_c
t_step_m_c=t_f/(length(m_c_points)-1);
t_c=0:t_step_m_c:t_f;
m_cold=interp1(t_c,m_c_points,t,'spline');
m_cold(2:m_1)=t(2:m_1)/t(m_1)*m_cold(m_1);
% m_cold=1;

t_h_points=t_c_points;
m_h_points_basis=[1 1.2 0.8 0.6];
m_h_points=[];
for i=1:t_h_points;
m_h_points=[m_h_points m_h_points_basis];
end
index_h=randperm(length(m_h_points));
m_h_points=m_h_points(index_h);
%time step for m_h
t_step_m_h=t_f/(length(m_h_points)-1);
t_h=0:t_step_m_h:t_f;
m_h=interp1(t_h,m_h_points,t,'spline');
m_h(2:m_1)=t(2:m_1)/t(m_1)*m_h(m_1);
% m_h = 1.0;

% Fluid properties.
rho_c = 1000;
rho_h = 1000;
c_c = 4200;
c_h = 4200;
% kinematic viscosities
nu_h=0.5e-6;
nu_c=0.5e-6;
% conductivities
k_h=0.6;
k_c=0.6;
% Pr numbers
Pr_h=c_h*nu_h*rho_h/k_h;
Pr_c=c_c*nu_c*rho_c/k_c;

% Dimensions
W = 0.5;
H = 0.5;
d_c = 0.002;
d_h = 0.002;
% number of channels
n_c=10;
% width of the channels
w_c_h=W/n_c;
w_c_c=H/n_c;
Dh_h=4*(w_c_h*d_h)/(2*(w_c_h+d_h));
Dh_c=4*(w_c_c*d_c)/(2*(w_c_c+d_c));
A_h=(n_c*(2*d_h+W/n_c))*H;
A_c=(n_c*(2*d_c+H/n_c))*W;

% Inlet temperature.
t_Tci_points=t_c_points;
Tci_points_basis=[20 24 22 18 16];
Tci_points=[];
for i=1:t_Tci_points;
   Tci_points=[Tci_points Tci_points_basis];
end
index_Tci=randperm(length(Tci_points));
Tci_points=Tci_points(index_Tci);
t_step_Tci=t_f/(length(Tci_points)-1);
t_Tci=0:t_step_Tci:t_f;
Tci=interp1(t_Tci,Tci_points,t,'spline');
Tci(1:m_1)=t(1:m_1)/t(m_1)*Tci(m_1);

t_Thi_points=t_c_points;
Thi_points_basis=[60 58 56 64 62];
Thi_points=[];
for i=1:t_Thi_points;
   Thi_points=[Thi_points Thi_points_basis];
end
index_Thi=randperm(length(Thi_points));
Thi_points=Thi_points(index_Thi);
t_step_Thi=t_f/(length(Thi_points)-1);
t_Thi=0:t_step_Thi:t_f;
Thi=interp1(t_Thi,Thi_points,t,'spline');
Thi(1:m_1)=t(1:m_1)/t(m_1)*Thi(m_1);

% Heat transfer coefficient.
% velocities
V_h=m_h/(rho_h*W*d_h);
V_c=m_cold/(rho_c*H*d_c);
% Reynolds numbers
Re_h=V_h*Dh_h/nu_h;
Re_c=V_c*Dh_c/nu_c;
Nu_h=0.023*Re_h.^0.8.*Pr_h^(1/3);
h_h=Nu_h*k_h/Dh_h;
Nu_c=0.023*Re_c.^0.8.*Pr_c^(1/3);
h_c=Nu_c*k_c/Dh_c;
U = (1./(1./(A_c*h_c)+1./(A_h*h_h)))/(W*H);
%U_fouling
clf
Rf=0.0008*(exp(((0:length(U)-1)/(length(U)-1)).^3)-1)/(exp(1)-1);

    % --------------- img_fouling.eps ---------------
norm = 1/max(Rf)*3e-4;
Rf=Rf*norm;
plot(linspace(0,1,length(Rf)),Rf)
title('Evolution of the fouling factor, $R_f$','interpreter','latex')
ylabel( '$R_f\; (\frac{m^2 K}{W})$','Interpreter','latex'), 
xlabel('Dimensionless time, $t$','interpreter','latex'), 
%axis([0,1,0e-4,3.001e-4])
hold on
x = 5800;
plot(x/10000,Rf(x)/max(Rf),'*r', [0 x/10000],[Rf(x)/max(Rf) Rf(x)/max(Rf)],'--r',[x/10000 x/10000],[0 Rf(x)],'--r')
text(x/20000,Rf(x)/max(Rf)+1e-5,['$R_f$(' num2str(x/10000) ') $\simeq$ ' num2str(Rf(x),2)],'interpreter','latex')
hold off
% --------------- img_fouling.eps ---------------