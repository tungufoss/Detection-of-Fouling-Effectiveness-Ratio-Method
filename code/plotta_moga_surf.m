function [Xinterp,Yinterp,Zinterp] = plotta_moga_surf(x,y,z)

% Determine the minimum and the maximum x and y values:
xmin = min(x); ymin = min(y);
xmax = max(x); ymax = max(y); 

% Define the resolution of the grid:
xres=30;
yres=30;

% Define the range and spacing of the x- and y-coordinates,
% and then fit them into X and Y
xv = linspace(xmin, xmax, xres);
yv = linspace(ymin, ymax, yres);
[Xinterp,Yinterp] = meshgrid(xv,yv); 

% Calculate Z in the X-Y interpolation space, which is an 
% evenly spaced grid:
Zinterp = griddata(x,y,z,Xinterp,Yinterp); 

surfc(Xinterp,Yinterp,Zinterp)
colormap('bone'), colorbar
view(140, 35), grid on, axis tight
ylabel('Correctly classified clean CFHE');
xlabel('Correctly classified fouled CFHE');
zlabel('Detection times');

end