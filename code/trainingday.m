global train ts

maker = 'Oggi_long';
train = getdatasets(1:50,maker);
test = getdatasets(51:100,maker);
ts.begin=1; % Skip the first 1000 samples
ts.final=9999; % Already skipped the first 1000 samples

addpath 'GAtoolbox/'
%addpath 'wavelet_transform/'
GAtbxm('input_nsga_maxSpec')
