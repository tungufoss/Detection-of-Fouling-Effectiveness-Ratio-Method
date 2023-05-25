clc, clear all, close all
maker = 'Sylvain';
ts.begin=1; % Skip the first 1000 samples
ts.final=9000; % Already skipped the first 1000 samples
train = getdatasets(1:50,maker);
test = getdatasets(51:100,maker);

%% Training for treshold
%Kfold_id = crossvalind('Kfold', 70, 5);
%for i=1:5 
%    tset{i} = ['set' num2str(i,'%03.0f')];
%    train.(tset{i}) = getdatasets(find(Kfold_id~=i)',maker);
%    valid.(tset{i}) = getdatasets(find(Kfold_id==i)',maker);
%end
%% Testing for detection
%test = getdatasets(71:100,maker);


%% *** WAVELET TRANSFORM ***************************************************
addpath 'wavelet_transform'\
wt.bcondt = 0.85
it=0;
for dim = 2:2:40 
    for sc = 2:2:20
        wt = struct('type','Daubechies','dimension',dim,'scale',sc);
        wt.filters = daub(wt.dimension);
        wt.aprox_parm = {wt.filters.an.low,wt.filters.sy.low,wt.scale,wt.bcondt};
        % Training wt
        wt.th = eff_ratio_method(@aprox,wt.aprox_parm,train,[],false,ts);
        [wt.th,wt.detect] = eff_ratio_method(@aprox,wt.aprox_parm,train,wt.th,false,ts);
        it=it+1
        besta(it,:) = [dim sc wt.th.mu_0 length(find(wt.detect.c<9000)) length(find(wt.detect.f<9000))];
    end
end
% Testing wt
%[wt.th,wt.detect] = eff_ratio=method(@aprox,wt.aprox_parm,test,wt.th,true)

%% *** MOVING AVERAGE ******************************************************
% it=0;
% BESTUN = [];
% for window = 20:20:100
%   backup_ratio = ratios(@movavg,window,partdata,ts);
%   detection
%   % 1-Iteration 2-Window 3-TrueFouling 4-TrueClean 5-Threshold 6-Lower
%   it=it+1
%   BESTUN(it,:) = [it window mean(correct.f) mean(correct.c) th.threshold th.quantiles(1)];
%   clear ratio th correct
% end
% 
% [tmp,idx]=sort(BESTUN(:,2));
% tmp=BESTUN(idx,:);
% window = tmp(:,2);
% TrueFouling = tmp(:,3);
% TrueClean = tmp(:,4);
% close all, figure(1), hold on
% plot(window/M,TrueFouling,'k','LineWidth',2)
% plot(window/M,TrueClean,'color',[0.5 0.5 0.5],'LineWidth',2)
% legend('True Fouling','True Clean'); 
% title('Moving average','interpreter','latex');
% ylabel('Proportion of correct classifying','interpreter','latex');
% xlabel('Length of sliding window, in dimensionless time','interpreter','latex');
% axis([0.01 max(window)/M 0.7 1])

