% Author: Helga Ingimundardóttir
% Call:    filters = daub(N)
% Input:   N  = width of the support (number of coefficients) and must be an even number
% Output:  filters is a struct with the fields
%          filters.an.low = analysis lowpass filter
%          filters.an.high  = analysis highpass filter
%          filters.sy.low = synthesis lowpass filter
%          filters.sy.high = synthesis highpass filter
% ... for the Daubechies Wavelet basis
function filters = daub(N)

if rem(N,2)
  error( 'Error: width of the support must be of even length')
end
A = N/2;

% Have to implement the polynomial 'p' [see research book]
tmp = zeros(A,A+A-1);
tmp(1,A) = 1;

for k=1:A-1
  subtmp = [1 -2 1];
  for j=2:k
    subtmp = conv(subtmp,[1 -2 1]);
    % conv is inbuilt in MATLAB and if the inputs are vectors of polynomial coefficients, convolving them is equivalent to multiplying the two polynomials. 
  end
  subtmp = nchoosek(A-1+k,k)*(-1/4)^k*subtmp;
  % Add the zeros on each side of the subtmp
  tmp(k+1,:) = [zeros(1,A-k-1),subtmp,zeros(1,A-k-1)];
end

% The tmp-matrix has to be summed for each column (for the represent the same term in the polynomial 'p'
polyp = sum(tmp,1);

% Finding the roots/vanishing points of the polynomial 'p'
poly_zeros = roots(polyp); % inbuilt in MATLAB

% For the 'extremal phase' we choose the roots within the unit circle
zerosinside = poly_zeros(find(abs(poly_zeros)<=1));

% Need to sort the zeros for real and imaginary for ease of computation
imagzero = [];
realzero = [];
for i=1:length(zerosinside)
  if imag(zerosinside(i))~=0
    imagzero(end+1)=zerosinside(i);
  else
    realzero(end+1)=zerosinside(i);
  end
end

% From the vanishing points we can make the synthesis lowpass filter 'rh'
rh = [1,1];
for i=2:A
  rh = conv(rh,[1,1]);
end
for i=1:length(realzero)
  rh = conv(rh,[1  -realzero(i)]);
end
for i=1:2:length(imagzero)    
    rh = conv(rh,[1  -2*real(imagzero(i))  (abs(imagzero(i)))^2 ]);
    % Note: Conjugate roots are multiplied together before they're convolved with other roots. That's why we sorted out the real zeros from the imaginary ones.  
end

% Normalizing term derived from the polynomial 'p' for the filter 'rh'
norm_term = 1;
for i=1:A-1
    norm_term = norm_term * abs(zerosinside(i));
end
norm_term = abs(polyp(1))/norm_term;
norm_term = (1/2)^A * sqrt(2) * sqrt(norm_term);

rh = norm_term * rh;

% Since the Daubechies filter is orthogonal we get the other filters in the following manner: 
for i=1:length(rh)
    rg(i) = (-1)^(i+1)*rh(end-i+1);
    % 'rg' is 'rh' reversed with everyother term multiplied by -1
end
% 'h' and 'g' are reversals of 'rh' and 'rg' respectively.
h = rh(length(rh):-1:1);
g = rg(length(rh):-1:1);

filters.an = struct('low',h,'high',g);
filters.sy = struct('low',rh,'high',rg);
end