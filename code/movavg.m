function y = movavg(x,window)
a = 1;
b = ones(1,window)./window;
y = filter(b,a,x);
end