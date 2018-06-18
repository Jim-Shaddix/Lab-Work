%% Initialization Data:

% These variables are used to set paths
% - are subject to change depending on your filesystem
path_to_tdms_files = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/'...
                      '2-Files_To_Analyze/31 May 18 TaV2/'];
path_to_storage_functions = 'Store_TDMS_Data';

% Generate paths
addpath(genpath(path_to_storage_functions));

% Read In Data:
tdms_data = Store_TDMS_Data(path_to_tdms_files);
clear path_to_tdms_files path_to_storage_functions

%% Performing Fit

Fit_Function = 0;

if Fit_Function == true
    
    % Function data to be fitted
    A = 90;
    theta = 0;
    gamma = 10;
    f0 = 1200;
    x_corr = 800:2000;
    y_real = (A./((x_corr(1,:) - f0).^2 + gamma^2)).*((x_corr(1,:) - f0).* ...
            cos(theta) + gamma * sin(theta));
     
    % Initial guess of fit paramaters for:
    % real portion of a complex Lorentizan function
    %   [A, theta, gamma, f_0]
    x = [A-5, theta, gamma-5, (min(x_corr)+max(x_corr))/2];
        
else
    
    % Experimental data to be fitted
    mmin = 0.955*10^6; % minimum x-coordinate
    mmax = 0.965*10^6; % maximum x-coordinate
    index = mmin < tdms_data(1).frequency & tdms_data(1).frequency < mmax;
    x_corr = tdms_data(1).frequency(index);
    y_real = tdms_data(1).signal_x(index);
    y_imag = tdms_data(1).signal_y(index);
    
    % Fit paramater guesses:
    %   [A, theta, gamma, f_0]
    x = [max([y_real,y_imag]), 0,     10,    (mmin+mmax)/2];
    
end

% Function Handle For: [complex lorentzian]
lorentz_fnc = @(x, x_corr) x(1) .* exp(1i .* x(2)) ./ ...
                            (x_corr(1,:) - x(4) + 1i .* x(3));
                      
% optional parameters for fit
options = optimoptions(@lsqcurvefit,     ...
                        'Display','off', ...
                        'TolX', 1e-10,   ...
                        'TolFun', 1e-10, ...
                        'MaxFunctionEvaluations', 100000, ...
                        'MaxIterations', 100000);
                    
% Perform Fit:
%   xEst:     fit parameters (Array of Floats) 
%   resnorm:  sum of the squared residuals (Float) 
%   residual: (Array of Floats)
%   exitFlag: [1] -> function converged 
%             [2] -> change x < tolerance 
%             [3] -> change residual < tolerance
[xEst,resnorm, residual, exitFlag] = lsqcurvefit( ... 
                                                lorentz_fnc, x, ...
                                                x_corr, y_real + 1i.*y_imag, ... 
                                                [],[],options);

% Y-Coordinates from fit
fit_curve = lorentz_fnc(xEst,x_corr);

%% Display

disp("Estimated Fit Parameters:")
disp(xEst)
disp("Exit Flag:")
disp(exitFlag)

% Plot Fits
plot(x_corr,real(fit_curve),'y','LineWidth',4)
hold on;
plot(x_corr,imag(fit_curve),'c','LineWidth',4)

% Plot Data
plot(x_corr,y_real,'r')
plot(x_corr,y_imag,'b')

legend('Fit Real', 'Fit Imag','Data Real', 'Data Imag')


