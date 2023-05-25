type = 'MA';
global train test ts

if strcmpi(type,'WT')
    load moga_wt.mat
    addpath 'wavelet_transform/'
    o(1) = 0.02; d(1) = 2; s(1) = 10; b(1) = 0.85;
    M=length(varExtr)+length(varZoom)+1;
    o(2:M,1) = offset([varZoom;varExtr]); o_=round(o.*ts.final);
    d(2:M,1) = dim([varZoom;varExtr]);
    s(2:M,1) = scale([varZoom;varExtr]);
    b(2:M,1) = bcondt([varZoom;varExtr]);
else
    load moga_ma.mat
    o=offset(varZoom); o_=round(o.*9999);
    w=window(varZoom);
end

for i=2:2
    if strcmpi(type,'WT')
        wt = struct('type','Daubechies','dimension',d(i),'scale',s(i),'bcondt',b(i));
        wt.filters = daub(d(i));
        wt.aprox_parm = {wt.filters.an.low,wt.filters.sy.low,wt.scale,wt.bcondt};
        ratio.train = ratios(o_(i),@aprox,wt.aprox_parm,train,ts);
        ratio.test = ratios(o_(i),@aprox,wt.aprox_parm,test,ts);
    else
        ratio.train = ratios(o_(i),@movavg,w(i),train,ts);
        ratio.test = ratios(o_(i),@movavg,w(i),test,ts);        
    end
    th=compute_threshold(ratio.train);
    [stopping_times,correct,detect_times] = detection(ratio.train,th);
    objConst.train(1) = mean(correct.f);
    objConst.train(2) = mean(correct.c);
    objConst.train(3) = mean(stopping_times.f)/ts.final;
    clear correct stopping_times
    [stopping_times,correct,detect_times] = detection(ratio.test,th);
    objConst.test(1) = mean(correct.f);
    objConst.test(2) = mean(correct.c);
    objConst.test(3) = mean(stopping_times.f)/ts.final;
    if strcmpi(type,'WT')
        more_dat(i,:) = [o(i),d(i),s(i),b(i),objConst.train,objConst.test,th.mean]
    else
        more_dat(i,:) = [o(i),w(i),objConst.train,objConst.test,th.mean]
    end
    clear correct objConst ratio wt th
end



load moga_wt.mat
addpath 'wavelet_transform/'
o = 0.02; d= 2; s = 10; b= 0.85;
