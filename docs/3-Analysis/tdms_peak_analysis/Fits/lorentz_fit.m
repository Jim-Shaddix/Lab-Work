function [Est, fit_x, fit_real, fit_imag] = Lorentz_Fit(x_fit_cor, y_fit_cor, guess)
% This function fits a complex lorentzian function to all of the peaks 
% in a given dataset, returns the arrays of the fit parameters found, and
% coordinates associated with the applied fit function.
%
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
%   1. Est: [Cell-Array] Each cell contains the 5 calculated fit parameters
%   2. fit_x: [Cell-Array] The x-values, associated with the fit that took
%                          place for each peak
%   3. fit_real: [Cell-Array] The real-values, associated with the fit that
%                took place for each peak
%   4. fit_imag: [Cell-Array] The x-values, associated with the fit that
%                took place for each peak

    % function handle for: [complex lorentzian]
    % x = [A, theta, gamma, f_0, offset]
    lorentz_fnc = @(x, x_fit_cor) x(1) .* exp(1i .* x(2)) ./ ...
                               (x_fit_cor(1,:) - x(4) + 1i .* x(3) + x(5));

    % optional parameters for fit function
    options = optimoptions(@lsqcurvefit,     ...
                            'Display','off', ...
                            'TolX', 1e-10,   ...
                            'TolFun', 1e-10, ...
                            'MaxFunctionEvaluations', 1000000, ...
                            'MaxIterations', 1000000);
            
    % Perform Fit:
    %   xEst:     fit parameters (Array of Floats) 
    %   resnorm:  sum of the squared residuals (Float) 
    %   residual: (Array of Floats)
    %   exitFlag: [1] -> function converged 
    %             [2] -> change x < tolerance 
    %             [3] -> change residual < tolerance
    [Est, resnorm, residual, exitFlag] = lsqcurvefit(                  ... 
                                                lorentz_fnc, guess,    ...
                                                x_fit_cor, y_fit_cor,  ... 
                                                [],[],options);
    % Y-coordinates from fit
    fit_curve = lorentz_fnc(Est,x_fit_cor);

    % assighn variables to be returned
    fit_x    = x_fit_cor;
    fit_real = real(fit_curve);
    fit_imag = imag(fit_curve);

end