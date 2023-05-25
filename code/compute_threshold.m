function threshold=compute_threshold(ratio)
total_min = [];
for k=1:ratio.number_of_sets
    for j=1:ratio.intervals
        total_min = [total_min;min(ratio.c{k,j})];        
    end
end
threshold.mean = mean(total_min);
threshold.quant = quantile(total_min,[0.025,0.975]);
%fprintf('Threshold: %6.4f, CI: [%6.4f,%6.4f]\n',threshold.mean,threshold.quant(1),threshold.quant(2));
end