function [Cl] = FCl_calculater(xc, Re,coef,  alpha)

% fluid parameter (air)
vis = 0.00001837;
rho = 1.225;
Re = Re;
xc = xc;
R =2.5;

b = R/ coef;




% user-defined parameters
% c = c;       % Chord length, m
h = 0.0;    % Maximum camber, m
  % maximum thickness, m


alpha = alpha;   % Angle of Attack

yc = h/2;
% s = 0.35 * c;
% R = sqrt((xc-s)^2+yc^2);

theta = 0:0.0001:2*pi;
x = xc + R*cos(theta);
y = yc + R*sin(theta);

Z = x+1i*y;
Za = (Z + b^2./Z)/2;
xa = real(Za);
ya = imag(Za);


c = max(xa) - min(xa);
c = abs(c);


Uinf = Re * vis / c/ rho;   % U_\infty, m/s

Ga = 4*pi*Uinf*R*sin(alpha*pi/180+2*h/c);
L =  Uinf * rho * Ga;
Cl = L/(0.5 * rho * c * Uinf ^ 2);