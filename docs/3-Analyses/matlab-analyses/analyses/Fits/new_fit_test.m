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
    xdata = 800:2000;
    ydata = (A./((xdata(1,:) - f0).^2 + gamma^2)).*((xdata(1,:) - f0).* ...
            cos(theta) + gamma * sin(theta));
     
    % Initial guess of fit paramaters for:
    % real portion of a complex Lorentizan function
    %   [A, theta, gamma, f_0]
    x = [A-5, theta, gamma-5, (min(xdata)+max(xdata))/2];
        
else
    
    % Experimental data to be fitted
    mmin = 0.92*10^6; % minimum x-coordinate
    mmax = 0.97*10^6; % maximum x-coordinate
    index = mmin < tdms_data(1).frequency & tdms_data(1).frequency < mmax;
    xdata = tdms_data(1).frequency(index);
    ydata = tdms_data(1).signal_x(index);
    
    % Fit paramater guesses:
    %   [A, theta, gamma, f_0]
    x = [1, 0,     10,    (mmin+mmax)/2];
end

% Function Handle For:
% real portion of complex lorentzian
lorentz_fnc = @(x, xdata) (x(1)./((xdata(1,:) - x(4)).^2 + x(3)^2)).* ...
                          ((xdata(1,:) - x(4)).*cos(x(2)) + x(3) *    ...
                          sin(x(2)));
                      
% optional parameters for fit
options = optimoptions(@lsqcurvefit,     ...
                        'Display','off', ...
                        'TolX', 1e-10,   ...
                        'TolFun', 1e-10, ...
                        'MaxFunctionEvaluations', 10000000, ...
                        'MaxIterations', 10000000);
                    
% Perform Fit:
%   xEst:     fit parameters (Array of Floats) 
%   resnorm:  sum of the squared residuals (Float) 
%   residual: (Array of Floats)
%   exitFlag: [1] -> function converged 
%             [2] -> change x < tolerance 
%             [3] -> change residual < tolerance
[xEst,resnorm, residual, exitFlag] = lsqcurvefit(lorentz_fnc, x, xdata, ydata,[],[],options);

% Y-Coordinates from fit
fit_curve = lorentz_fnc(xEst,xdata);

%% Display

disp("Estimated Fit Parameters:")
disp(xEst)
disp("Exit Flag:")
disp(exitFlag)

plot(xdata,ydata,'r')
hold on;
plot(xdata,fit_curve,'b--')
legend('Lorentz Line', 'Fit Line')

