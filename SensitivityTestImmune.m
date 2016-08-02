%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% MATLAB %%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% R % T % B % M %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is a Sensitivity Test of Immune System for a 10 day simulation for ATB resistance on E.Coli
r = 0.01505; % E. Coli doubles every 20 min
rm = 0.01505; % Mutant E. Coli doubles every 20 min
alpha1n = 2; % For Beta Distribution Proportion of surviving H.Sapien bacteria after ATB
beta1n = 18; % For Beta Distribution Proportion of surviving H.Sapien bacteria after ATB
alpha1m = 0.99; % For Beta Distribution Proportion of surviving Mutant bacteria after ATB
beta1m = 0.1; % For Beta Distribution Proportion of surviving Mutant bacteria after ATB
Nsub = 10000; % Number of simulated subjects
ceil = 1000000000; % Ceiling number of bacteria
floor = 10000; % Floor number of bacteria
t1 = 60; % Time of First ATB Regimen
t2 = 4320; % Time of Second ATB Regimen
t3 = 8640; % Time of Third ATB Regimen
nday = 10; % 10 days
Ninitial = 100000000; % Initial Number of Bacteria
Minitial = 100; % Initial Number of Mutant Bacteria
rmutant = 1e-6; % Proportion of X-Gene
MorirMat=zeros(10);
dataframe = [];
h = waitbar(0, 'Sweet Dreams Are Made Of These...'); % Progress Bar
steps = 100;
tic
for a=1:10
    for b=1:10
        alpha2 = a;
        beta2 = b;
        durante = 24 * 60 * nday; % Loop in minutes
        morir = zeros(1, Nsub);
        days = zeros(1, Nsub);
        step = 10*(a-1)+b;
        for it = 1:Nsub % simulated subjects
            rng(it); % Set Random Seed to make it replicable
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
            for i = 2:durante + 1 % Daily Updated
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
        end 
        mortalityrate = sum(morir)/Nsub; % Mortality Rate
        MorirMat(a, b) = mortalityrate;
        tempvec = [a, b, mortalityrate];
        dataframe = [dataframe;tempvec];
        waitbar(step / steps)
    end
end
close(h) 
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 28th %%%%% JULY %%%%% 2016 %%%%% HAIL %%%%% HYDRA %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%