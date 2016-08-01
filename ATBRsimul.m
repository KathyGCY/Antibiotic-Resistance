function ATBRsimul(r, rm, alpha1n, beta1n, alpha1m, beta1m, alpha2, beta2, Nsub, ceil, floor, t1, t2, t3, nday, Ninitial, Minitial, rmutant)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% MATLAB %%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% R % T % B % M %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is a n day simulation for ATB resistance on E.Coli
% r = E. Coli doubles every 20 min
% rm = Mutant E. Coli doubles every 20 min
% alpha1n = For Beta Distribution Proportion of surviving H.Sapien bacteria after ATB
% beta1n = For Beta Distribution Proportion of surviving H.Sapien bacteria after ATB
% alpha1m = For Beta Distribution Proportion of surviving Mutant bacteria after ATB
% beta1m = For Beta Distribution Proportion of surviving Mutant bacteria after ATB
% alpha2 = For Beta Distribution Proportion of surviving bacteria immune system
% beta2 = For Beta Distribution Proportion of surviving bacteria immune system
% Nsub = Number of simulated subjects
% ceil = Ceiling number of bacteria
% ceil = Floor number of bacteria
% t1 = Time of First ATB Regimen
% t2 = Time of Second ATB Regimen
% t3 = Time of Third ATB Regimen
% nday = number of days in the trail
% Ninitial = Initial Number of Bacteria
% Minitial = Initial Number of Mutant Bacteria
% rmutant = Proportion of X-Gene
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% LET % THE % FUN % BEGIN % ! %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
durante = 24 * 60 * nday; % Loop in minutes
morir = zeros(1, Nsub);
days = zeros(1, Nsub);
h = waitbar(0, 'Sweet Dreams Are Made Of These...'); % Progress Bar
steps = Nsub;
tic
for it = 1:Nsub % 1000000 simulated subjects
    step = it;
    % Initialization within loop
    N = zeros(durante + 1, 1); % Number of H. Sapien Bacteria
    M = zeros(durante + 1, 1); % Number of Mutant Bacteria
    N(1)=normrnd(Ninitial, 100); % Initial Encounter Number
    M(1)= Minitial; % Initial Encounter Number
    rho = betarnd(alpha1n, beta1n, 3, 1); % Proportion of surviving H. Sapien Bacteria after ATB
    rhom = betarnd(alpha1m, beta1m, 3, 1); % Proportion of surviving Mutant Bacteria after ATB
    rho1 = rho(1); % H. Sapien V.S. ATB1
    rho2 = rho(2); % H. Sapien V.S. ATB2
    rho3 = rho(3); % H. Sapien V.S. ATB3
    rho1m = rhom(1); % Mutant V.S. ATB1
    rho2m = rhom(2); % Mutant V.S. ATB2
    rho3m = rhom(3); % Mutant V.S. ATB3
    vol = normrnd(0,100, [durante + 1,1]); % Volatility of GBM
    phi = betarnd(alpha2, beta2, Nsub, 1); % Each has different immune system
    for i = 2:durante + 1
        N(i) = N(i-1) * exp(r) + vol(i); % GBM Growth of Bacteira
        N(i) = N(i) * phi(it); % Immune System Kills a small proportion
        M(i) = M(i-1) * exp(rm) + vol(i); % GBM Growth of Mutant
        N(i) = N(i) * (1 - rmutant); %Small proportion mutates
        M(i) = M(i) + N(i) * rmutant; % Mutant Offspring + New Mutant
        if N(i) + M(i) >= ceil
            % disp('DEAD')
            % Subject Dead if too many backteria
            morir(it) = 1;
            days(it) = i;
            break
        elseif N(i) + M(i) <= floor
            % disp('LIVE')
            % Subject Live if too few backteria
            morir(it) = 0;
            days(it) = i;
            break
        elseif i == t1 % ATB Reg1
            N(i) = rho1 * N(i); % H. Sapien Bacteria
            M(i) = rho1m * M(i); % Mutant Bacteria
        elseif i == t2 % ATB Reg2
            N(i) = rho2 * N(i); % H. Sapien Bacteria
            M(i) = rho2m * M(i); % Mutant Bacteria 
        elseif i == t3% ATB Reg3
            N(i) = rho3 * N(i); % H. Sapien Bacteria
            M(i) = rho3m * M(i); % Mutant Bacteria      
        elseif i == durante + 1
            % disp('LIVE')
            % Subject Live till end of trail
            morir(it) = 0;
            days(it) = i;
        end
    end
   waitbar(step / steps)
end 
close(h) 
toc
mortalityrate = sum(morir)/Nsub; % Mortality Rate
index = (morir == 1);
deathdays = days(index);
[f, xi] = ksdensity(deathdays); % Kernel Density of Days of Mortality
figure
plot(xi, f, 'Color', [1,0.84705882352,0.92549019607]);
hold on
index1 = (morir == 0);
survivedays = days(index1);
[f1,xi] = ksdensity(survivedays); % Kernel Density of Days of Survival
plot(xi, f1, 'Color', [0.505882353,0.84705882352,0.9254901960781568627451]);
hold off
disp(mortalityrate)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 28th %%%%% JULY %%%%% 2016 %%%%% HAIL %%%%% HYDRA %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%