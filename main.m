clc
close all
clear

Re = 100000;

NameFiles = {'CL_data.txt'};

% due to high amount of DATA this part used to read data from the file
fileID = fopen(NameFiles{1},'r');
formatSpec = '%f %f';
sizeA = [2 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
A = A'; %used to oriente reading data

AoA =A(:, 1);
Cl_63_015 = A(:, 2);


NameFiles = {'naca_63_015.txt'};

% due to high amount of DATA this part used to read data from the file
fileID = fopen(NameFiles{1},'r');
formatSpec = '%f %f';
sizeA = [2 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
A = A'; %used to oriente reading data

xposition =A(:, 1);
yposition = A(:, 2);



figure (1)
hold on
plot(AoA, Cl_63_015, '-') % plot

co = 0.71: 0.02:0.81;
for k_ = 1:length(co)
    k_;
    coeff = co(k_);

    xc__ = -0.25: 0.01: 2;
    length(xc__);
    E = zeros(length(xc__));

    for i = 1: length(xc__)
        for j = 1: length(AoA)
            Cl(i, j) = FCl_calculater(xc__(i), Re, coeff, AoA(j));
        end
    end
    err = 0;
    for i = 1: length(xc__)
        err = err + sum(abs(( Cl_63_015(:) - Cl(i,:))^2));
    end

    [M, I] = min( err);
    II(k_) = I;

    figure (1)
    hold on
	
%     plot(AoA, Cl(length(xc__), :), 'k:') % plot
%     plot(AoA, Cl(1, :), 'g:') % plot
    plot(AoA, Cl(I, :), '--', 'linewidth',2) % plot
    legend('Cl NACA 63-015', 'Location','southeast')


    alpha = 3;
    [L, Cl, xa, ya, x, y, chord] = FjoukwesikiAirfoil(xc__(I), Re, coeff, alpha);


    figure (2)
    fs= 12;
    iplot = 1;

    subplot(1,2,iplot)
    set(gcf,'position',[74 127 1203 508]) 

    plot(x,y,'k-','linewidth',2)

    xlabel('$\xi$','interpreter','latex','color','k','fontsize',fs)
    ylabel('$\eta$','interpreter','latex','color','k','fontsize',fs)
    set(gca,'fontsize',fs)

    % xticks(-0.9:0.2:0.5)
    % yticks(-0.4:0.2: 0.4)
    grid on
    grid minor

    text(-1,0.0,['$AoA=',num2str(alpha,'%2d'),' ^\circ, Re = ', num2str(Re,'%3.1f'),'  $'],'interpreter','latex','color','k','fontsize',fs)

    subplot(1,2,iplot+1)

    plot(xa, ya,'k-','linewidth',2)
    xlabel('$x$','interpreter','latex','color','k','fontsize',fs)
    ylabel('$y$','interpreter','latex','color','k','fontsize',fs)
    set(gca,'fontsize',fs)
    text(-1,-0.0,['$Lift=',num2str(L,'%4.3f'),' \mathrm{N}, Cl = ', num2str(Cl,'%4.3f'),'$'],'interpreter','latex','color','k','fontsize',12)

    grid on
    grid minor


    figure (3)
    hold on

    plot( chord *xposition, chord *yposition, 'k-', 'linewidth',2) % plot
    grid on
    grid minor
    plot(abs(min(xa)) +xa, ya,'g--','linewidth',2)

    % for i= 1:10:I
    %     [L1, Cl1, xa1, ya1, x1, y1, ch] = FjoukwesikiAirfoil(xc__(i), Re, Raduis, alpha);
    %     plot(abs(min(xa1)) +xa1,ya1,'r--', 'linewidth',1)
    % end
    % 

    % for i = 1: 5: I

    % end

end

figure (4)
hold on
plot(AoA, Cl_63_015, '-') % plot

for j = 1: length(AoA)
    Cl(j) = FCl_calculater(xc__(II(4)), Re, coeff, AoA(j));
end

plot(AoA, Cl(:), '--', 'linewidth',2) % plot


[L, Cl, xa, ya, x, y, chord] = FjoukwesikiAirfoil(xc__(II(4)), Re, co(4), alpha);

legend('Cl NACA 63-015', 'Optimum value',  'Location','southeast')

figure (5)
hold on

plot( chord *xposition, chord *yposition, 'k-', 'linewidth',2) % plot
grid on
grid minor
plot(abs(min(xa)) +xa, ya,'r--','linewidth',2)

