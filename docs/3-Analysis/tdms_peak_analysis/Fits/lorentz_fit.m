function fit = Lorentz_Fit(cell_x_cor_fit, cell_y_cor_fit, cell_guess, fit_options)
% This function fits a complex lorentzian function to all of the peaks 
% in a given dataset, returns the arrays of the fit parameters found, and
% coordinates associated with the applied fit function.
%
% PARAMETERS:
% cell_x_cor_fit: [Cell Array] each cell contains:
%                 The x-coordinates to perform the fit on.
%
% cell_y_cor_fit: [Cell Array] each cell contains:
%                 The y-coordinates to perform the fit on.
%
% cell_guess:     [Cell Array] each cell contains:
%                 An ititial guess for fit perameters
% RETURNS:
% 1. [cell]: each cell contains:
%            a struct describing the fit performed 

    % function handle for: [complex lorentzian]
    % x = [A, theta, gamma, f_0, offset]
    %lorentz_fnc = @(x, x_cor_fit) x(1) .* exp(1i .* x(2)) ./ ...
    %                           (x_cor_fit(1,:) - x(4) + 1i .* x(3)) + x(5);
    
    model = @(x, x_cor_fit) ... 
    x(1) ./ ((x_cor_fit(1,:) - x(4)).^2+x(3).^2) .* ...
    ((x_cor_fit(1,:) - x(4)).*cos(x(2)) + x(3).*sin(x(2))) + x(5) + ...
    1i * (x(1) ./ ((x_cor_fit(1,:) - x(4)).^2+x(3).^2) .* ...
        ((x_cor_fit(1,:) - x(4)).*sin(x(2)) + x(3).*cos(x(2))) + x(6));
    
    lorentz_fnc=@(x, x_cor_fit) [real(model(x, x_cor_fit)); imag(model(x, x_cor_fit))]; 
        
    % instantiate struct to return                    
    %fit = cell(1,length(cell_x_cor_fit));
                        
    for i = 1:length(cell_x_cor_fit)
        
        % easier access to data
        x_cor_fit = cell_x_cor_fit{i};
        y_cor_fit = cell_y_cor_fit{i};
        guess     = cell_guess{i};
        
        % Perform Fit:
        %   xEst:     fit parameters (Array of Floats) 
        %   resnorm:  sum of the squared residuals (Float) 
        %   residual: (Array of Floats)
        %   exitFlag: [1] -> function converged 
        %             [2] -> change x < tolerance 
        %             [3] -> change residual < tolerance
        
        % x = [A, theta, gamma, f_0, offset]
        [Est, resnorm, residual, exitFlag, ouput, lambda, jacobian] = ...
                        lsqcurvefit( ... 
                                     lorentz_fnc, guess,   ...
                                     x_cor_fit,            ...
                                     [real(y_cor_fit);imag(y_cor_fit)], ... 
                                     [-inf,-inf,0,-inf,-inf,-inf], ...
                                     [],fit_options);  
        % Error Values                         
        ci = nlparci(Est,residual,'jacobian',jacobian);
        
        % GET: Y-coordinates from fit
        fit_curve = lorentz_fnc(Est,x_cor_fit);

        % SET: fit signal
        fit(i).frequencies = x_cor_fit;
        fit(i).signal_x    = fit_curve(1,:);
        fit(i).signal_y    = fit_curve(2,:);

        % SET: fit parameters
        fit(i).A        = Est(1);
        fit(i).theta    = Est(2);
        fit(i).gamma    = Est(3);
        fit(i).f_0      = Est(4);
        fit(i).x_offset = Est(5);
        fit(i).x_offset = Est(6);
        
        % SET: fit parameter errors (95% confidence)
        fit(i).A_err        = (ci(1,2) - ci(1,1))/2;
        fit(i).theta_err    = (ci(2,2) - ci(2,1))/2;
        fit(i).gamma_err    = (ci(3,2) - ci(3,1))/2;
        fit(i).f_0_err      = (ci(4,2) - ci(4,1))/2;
        fit(i).x_offset_err = (ci(5,2) - ci(5,1))/2;
        fit(i).x_offset_err = (ci(6,2) - ci(6,1))/2;

    end

end