clc, clear all, close all


load greinaWT.txt
global offset dim scale bcondt clean foul times 

N=length(greinaWT)/7;
j=1;
for i=1:N
    data(i,1:7)=greinaWT(j:j+6);
    j=j+7;
end
data(:,1)=data(:,1)/9999;
data(:,7)=data(:,7)/9999;

offset = data(:,1);
dim = 2*data(:,2);
scale = data(:,3);
bcondt = data(:,4);
foul = data(:,5);
clean = data(:,6);
times = data(:,7);

clear data i j greinaWT N

%{
load MAinit.txt;
global offset window clean foul times 

N = length(MAinit)/5;
j=1;
for i=1:N
    data(i,1:5) = MAinit(j:j+4);
    j=j+5;
end

offset = data(:,1)/9999;
window = data(:,2);
foul = data(:,3);
clean = data(:,4);
times = data(:,5)/9999;

clear MAinit j i
%}
front = paretofront([-foul -clean times]);

% Vil amk fá 0.8 í cfoul og cclean
limited = logical(foul>0.8 & clean>0.8);
ltdpareto = logical(limited & front);
varZoom = find(ltdpareto==true);

%{
% Vel 5 extreme gildi fyrir hvert markfall
M=5;
extClean = find(front & clean==max(clean)); extClean=extClean(randperm(length(extClean)));
if length(extClean)>M, extClean(M+1:end)=[]; end
extFoul = find(front & foul==max(foul)); extFoul=extFoul(randperm(length(extFoul)));
if length(extFoul)>M, extFoul(M+1:end)=[]; end
extTimes = find(front & times==min(times)); extTimes=extTimes(randperm(length(extTimes)));
if length(extTimes)>M, extTimes(M+1:end)=[]; end
clear dum1 dum2 m M
varExtr = setdiff(unique([extClean; extFoul; extTimes']),varZoom);

tekk_zoom = 1;
tekk_extr = length(varZoom)+1;
tekk_more = length(varZoom)+length(varExtr)+1;
clear extTimes extClean extFoul
%}


%{
handle=figure('position',[10 10 800 2000]); hold on
A=2;B=2;

X=clean(limited); Y=foul(limited);
subplot(A,B,1), hold on
Z=offset(limited);
plotta_moga_surf(X,Y,Z);
plotta_moga_pkt(clean,foul,offset,varZoom,tekk_zoom,false)
plotta_moga_pkt(clean,foul,offset,varExtr,tekk_extr,false)
zlabel('ERM offset, o'); 

subplot(A,B,2), hold on
plotta_moga_surf(X,Y,dim(limited));
plotta_moga_pkt(clean,foul,dim,varZoom,tekk_zoom,false)
plotta_moga_pkt(clean,foul,dim,varExtr,tekk_extr,false)
zlabel('WT dimension, d');

subplot(A,B,3), hold on
plotta_moga_surf(X,Y,scale(limited));
plotta_moga_pkt(clean,foul,scale,varZoom,tekk_zoom,false)
plotta_moga_pkt(clean,foul,scale,varExtr,tekk_extr,false)
zlabel('WT scale, s');

subplot(A,B,4), hold on
plotta_moga_surf(X,Y,bcondt(limited));
plotta_moga_pkt(clean,foul,bcondt,varZoom,tekk_zoom,false)
plotta_moga_pkt(clean,foul,bcondt,varExtr,tekk_extr,false)
zlabel('WT boundary condition, c');
%}

close all
more_dat(1:length(varZoom),5:7) = [foul(varZoom) , clean(varZoom)  , times(varZoom)];
more_dat(length(varZoom)+1:length(varExtr)+length(varZoom),5:7) = [foul(varExtr) , clean(varExtr)  , times(varExtr)];


% Heildar mynd með pareto
handle=figure('position',[100 100 600 450]); hold on
title('MOGA for Wavelet Transform')
plot3(foul(front),clean(front),times(front), 'r*');
plotta_moga_surf(foul,clean,times);
legend('Pareto front','Final population')

% Heildar mynd með völdum pkt
handle=figure('position',[150 150 600 450]); hold on
title('MOGA for Wavelet Transform')
plotta_moga_surf(foul,clean,times);
plotta_moga_pkt(more_dat(:,5),more_dat(:,6),more_dat(:,7));
texify(more_dat);

% Einskorðuð mynd með völdum pkt
handle=figure('position',[200 200 600 450]); hold on
title('Restricted MOGA for Wavelet Transform')
plotta_moga_surf(foul(limited),clean(limited),times(limited));
plotta_moga_pkt(more_dat(:,5),more_dat(:,6),more_dat(:,7));

clear i j handle A B X Y Z