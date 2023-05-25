% Author:  Helga Ingimundardóttir
% Call:    yhat = aprox(y,parm)
% Input:   y: time series that is to be approximated
%          parm: {h,rh,sc}; where
%            h: lowpass analysis filter
%            rh: lowpass synthesis filter
%            sc: how often the filters should be applied
% Output:  yhat: is the approximated result after using
%          lowpass analysis, and lowpass synthesis filter 
%          on the time series y for a smoother trendline.
function yhat = aprox(y,parm)

h = parm{1}; rh = parm{2}; sc = parm{3};
% Make sure that 'y','h' and 'rh' are column vectors
y=y(:)'; h=h(:)'; rh=rh(:)'; 

% Using the theory on page 15 in wavelet_01.pdf 
ytmp=y;
for i=1:sc
  % Convolving the analysis filter with the detailed data (at scale i-1)
  ytmp=conv(h,ytmp); % yielding data on a rougher scale (at scale i)
  % Downsampling by 2
  ytmp=ytmp(1:2:length(ytmp));
end

for i=1:sc
  % Upsampling by 2
  y_before = ytmp;
  ytmp = zeros(2*length(y_before),1);
  ytmp(1:2:end) = y_before;
  % convolving the synthesis filter with the rough data
  ytmp = conv(rh,ytmp);
end

% Have to cut off excess entries in the beginning and end of 'ytmp'
D=floor((length(h)+length(rh))/2)-1;
for i=1:sc
  d(i) = D*2^(i-1);
end
d=sum(d);
yhat=ytmp(1+d:length(y)+d)';
end