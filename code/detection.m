function [detection_times,correct] = detection(ratio,th)
% Author: Helga Ingimundardóttir
% Call:    [detection_times,correct,detect_times] = detection(ratio,th)
% Input:   ratio = ratio is the time series of approximated effectiveness 
%                  wrt to its average
%          th = threshold for ERM
% Output:  detection_times = all the detection time of fouling
%          correct = percentage of correctly classified detection

detection_times.c = ones(1,ratio.number_of_sets)*ratio.final;
detection_times.f = ones(1,ratio.number_of_sets)*ratio.final;

for j=1:ratio.intervals
  for k=1:ratio.number_of_sets
    if min(ratio.c{k,j}) < th.quant(1)
      if detection_times.c(k) == ratio.final
        detection_times.c(k) = ratio.N(j);
      end
    end
    if min(ratio.f{k,j}) < th.quant(1)
      if detection_times.f(k) == ratio.final
        detection_times.f(k) = ratio.N(j);
      end
    end
  end
end

correct.f = (detection_times.f ~= ratio.final);
correct.c = (detection_times.c == ratio.final);
end
