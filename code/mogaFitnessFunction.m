% Sample multiobjective optimization problem. This is Kurosawe test
% function.
%
% Author: Kumara Sastry
% Date:   06/03/2007
%
function objConst = mogaFitnessFunction(decVars)
global train ts

%% MOVING AVERAGE
%offset = decVars(1);
%window = decVars(2);
%fprintf('offset %d, window %d, ans ',offset,window);
%ratio = ratios(offset,@movavg,window,train,ts);

%% WAVELET TRANSFORM
offset = decVars(1);
dim = 2*decVars(2);
sc = decVars(3);
bcondt = decVars(4);
fprintf('offset %d, dim %d, sc %d, bcond %.4f, ans ',offset,dim,sc,bcondt);
wt = struct('type','Daubechies','dimension',dim,'scale',sc,'bcondt',bcondt);
wt.filters = daub(wt.dimension);
wt.aprox_parm = {wt.filters.an.low,wt.filters.sy.low,wt.scale,wt.bcondt};
ratio = ratios(offset,@aprox,wt.aprox_parm,train,ts);

%% SAME for MA and WT
th=compute_threshold(ratio);
[stopping_times,correct,detect_times] = detection(ratio,th);

clear ratio
objConst(1) = mean(correct.f);
objConst(2) = mean(correct.c);
objConst(3) = mean(stopping_times.f);
end
