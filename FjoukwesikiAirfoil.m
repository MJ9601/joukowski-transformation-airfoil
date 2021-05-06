
function  [L, Cl, xa, ya, x, y, c] = FjoukwesikiAirfoil(xc, Re, coef, alpha)
% fluid parameter (air)
vis = 0.00001837;
rho = 1.225;
Re = Re;
xc = xc;
R = 2.5;
b = R/ coef;

% user-defined parameters
% c = c;       % Chord length, m
h = 0.0;    % Maximum camber, m
% t = t;   % maximum thickness, m

   % U_\infty, m/s
alpha = alpha;   % Angle of Attack


% 
% xc = -t/(3*sqrt(3));


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

Uinf = Re * vis / c/ rho;

Ga0 = 4*pi*Uinf*R*sin(alpha*pi/180+2*h/c);

fprintf('The radius of the cylinder is R = %5.3f.\n',R)
fprintf('The circulation that satisify the Kutta Condition is %5.3f m^2/s.\n',Ga0)
ni = 500;
nj = 500;
x0 = linspace(-0.6,0.6,ni+1);
y0 = linspace(-0.6,0.6,nj+1);
[xx,yy] = meshgrid(x0,y0);

rr = sqrt((xx-xc).^2 +(yy-yc).^2);
tt = atan2(yy-yc,xx-xc) - alpha/180*pi;

Ga = Ga0;
psi0 = Ga/2/pi*log(R);

index = [0.2:0.3:3.4]/2;
index(abs(index-1)<0.1)=[];
index = index * psi0;


psi = Uinf*rr.*sin(tt).*(1-R^2./(rr.^2)) + Ga/2/pi.*log(rr);
psi(rr<=R) = nan;



L =  Uinf * rho * Ga;
Cl = L/(0.5 * rho * c * Uinf ^ 2);
ya = 0.45 *ya;










