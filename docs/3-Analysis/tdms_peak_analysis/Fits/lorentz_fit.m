function [fit_x, fit_real, fit_imag] = lorentz_fit(all_x_cor, all_real_cor, all_imag_cor, peak_x_cor, peak_width)
% PARAMETERS:
%   1. all_x_cor: The x coordinates describing the range of values that 
%                 are considered for analyses
%   2. all_real_cor: The real coordinates from the data that are associated
%                    with the x coordinates
%   3. all_imag_cor: The imag coordinates from the data that are associated
%                    with the x coordinates
%   4. peak_x_cor: The x-values associated with all of the peaks that are
%                  being considered
%   5. peak_width: The width of each peak that will be used to fit the
%                  complex lorentzian function
% RETURN:
%   1. fit_x: [Cell-Array] The x-values, associated with the fit that took
%             place for each peak
%   2. fit_real: [Cell-Array] The real-values, associated with the fit that
%                 took place for each peak
%   3. fit_imag: [Cell-Array] The x-values, associated with the fit that
%                took place for each peak
%
% DESCRIPTION:
%   This function fits a complex lorentzian function to all of the peaks 
%   in a given dataset.

% coordinates to be returned
fit_x    = {};
fit_real = {};
fit_imag = {};

% function handle for: [complex lorentzian]
lorentz_fnc = @(x, x_cor) x(1) .* exp(1i .* x(2)) ./ ...
                            (x_cor(1,:) - x(4) + 1i .* x(3));
                      
% optional parameters for fit
options = optimoptions(@lsqcurvefit,     ...
                        'Display','off', ...
                        'TolX', 1e-10,   ...
                        'TolFun', 1e-10, ...
                        'MaxFunctionEvaluations', 100000, ...
                        'MaxIterations', 100000);

% perform fit on each peak
for i = 1:length(peak_x_cor)
    
    % get indices of data to be fitted
    mmin = peak_x_cor(i) - peak_width/2; % minimum x-coordinate
    mmax = peak_x_cor(i) + peak_width/2; % maximum x-coordinate
    indices = mmin <= all_x_cor & all_x_cor <= mmax;
    
    % data to be fitted
    x_cor = all_x_cor(indices);
    y_real = all_real_cor(indices);
    y_imag = all_imag_cor(indices);
    
    % Fit Paramater Guesses:
    %   [A, theta, gamma, f_0]
    x = [max([y_real,y_imag]), 0,     10,    (mmin+mmax)/2];
    
    % Perform Fit:
    %   xEst:     fit parameters (Array of Floats) 
    %   resnorm:  sum of the squared residuals (Float) 
    %   residual: (Array of Floats)
    %   exitFlag: [1] -> function converged 
    %             [2] -> change x < tolerance 
    %             [3] -> change residual < tolerance
    [xEst, resnorm, residual, exitFlag] = lsqcurvefit( ... 
                                                    lorentz_fnc, x, ...
                                                    x_cor, y_real + 1i.*y_imag, ... 
                                                    [],[],options);
    % Y-coordinates from fit
    fit_curve = lorentz_fnc(xEst,x_cor);
    
    % assighn variables to be returned
    fit_x       = [fit_x,    x_cor];
    fit_real    = [fit_real, real(fit_curve)];
    fit_imag    = [fit_imag, imag(fit_curve)];

end



end
                    


