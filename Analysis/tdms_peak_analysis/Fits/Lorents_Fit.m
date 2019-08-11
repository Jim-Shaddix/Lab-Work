function fit = Lorents_Fit(cell_x_cor_fit, cell_y_cor_fit, cell_guess, fit_options, fit_lbls, model)
% This function fits a complex lorentzian function to all of the peaks 
% in a given dataset, returns the arrays of the fit parameters found, and
% coordinates associated with the applied fit function.
%
% In order to understand how this fit works:
% read from here: https://www.mathworks.com/help/optim/ug/fit-model-to-complex-data.html
%
% PARAMETERS:
% cell_x_cor_fit: [Cell Array] each cell contains:
%                 The x-coordinates to perform the fit on.
%
% cell_y_cor_fit: [Cell Array] each cell contains:
%                 The y-coordinates to perform the fit on.
%
% cell_guess:     [Cell Array] each cell contains:
%                 An ititial guess for fit perameters.
%                 [A, theta, gamma, f_0, x_offset, y_offset];
% RETURNS:
% 1. [cell]: each cell contains:
%            a struct describing the fit performed 

    % Function to fit
    lorentz_fnc = @(guess, x_cor_fit) [real(model(guess, x_cor_fit)); ...
                                       imag(model(guess, x_cor_fit))]; 
    
    % Iniitial Function to fit: (real / imag)
    lorentz_ratio = @(guess, x_cor_fit) real(model(guess, x_cor_fit)) ./ ...
                                        imag(model(guess, x_cor_fit));
    
    % Perform a fit on each of the peaks
    for i = 1:length(cell_x_cor_fit)
        
        % ALIAS's: easier access to data
        x_cor_fit = cell_x_cor_fit{i};
        y_cor_fit = cell_y_cor_fit{i};
        guess     = cell_guess{i};
        
        % offset y coordinates:
        % Get value to translate the data by. When you take the ratio
        % of the real to the imaginary data, there is an issue if you 
        % divide by zero. I am getting rid of this issue by adding a 
        % constant factor of two * the minimum of the imaginary data.
        offset = 2 * abs(min(imag(y_cor_fit)));
        guess(end-1: end) = offset;
        y_cor_fit = y_cor_fit + offset + offset * 1j;
        
        guess(1) = 1; % reset A
        
        % Perform Initial Fit: (on the ratio real / imag lorenzian)
        [Est, resnorm, residual, exitFlag, ouput, lambda, jacobian] = ...
                lsqcurvefit( ... 
                             lorentz_ratio, ... % function to fit 
                             guess,      ... % intial parameters
                             x_cor_fit,  ... % x-coordinates
                             real(y_cor_fit) ./ imag(y_cor_fit), ... % y-coordinates
                             [], ... % lower bounds
                             [], ... % upper bounds
                             fit_options); % parameters that specify how to perform fit
                             %[-inf,-inf,0,-inf,-inf,-inf], %... % lower bounds
                             %[],  ... % upper bounds
        
        % remove the offset in the guess and the data
        Est(end-1: end) = 0;
        y_cor_fit = y_cor_fit - offset - offset * 1j;

        guess(1) = 200; % set A
        
        % Perform Fit:
        %   xEst:     fit parameters (Array of Floats) 
        %   resnorm:  sum of the squared residuals (Float) 
        %   residual: (Array of Floats)
        %   exitFlag: [1] -> function converged 
        %             [2] -> change x < tolerance 
        %             [3] -> change residual < tolerance
        [Est, resnorm, residual, exitFlag, ouput, lambda, jacobian] = ...
                        lsqcurvefit( ... 
                                     lorentz_fnc,... % function to fit 
                                     Est,      ... % intial parameters
                                     x_cor_fit,  ... % x-coordinates
                                     [real(y_cor_fit);imag(y_cor_fit)], ... % y-coordinates
                                     [], ... % lower bounds
                                     [], ... % upper bounds
                                     fit_options); % parameters specify, how to perform fit
                                     %[-inf,-inf,0,-inf,-inf,-inf], %... % lower bounds
                                     %[],                                ... % upper bounds
                                    
                                 
        % Error Values             
        ci = nlparci(Est,residual, 'jacobian', jacobian);
        
        % GET: Y-coordinates from fit
        fit_curve = lorentz_fnc(Est, x_cor_fit);

        % SET: fit signal values
        fit(i).frequencies = x_cor_fit;
        fit(i).signal_x    = fit_curve(1,:);
        fit(i).signal_y    = fit_curve(2,:);

        % SETTING: fit info
        for j=1:length(fit_lbls)
            
            % SET: fit parameters 
            fit(i).(fit_lbls{j}) = Est(j);
            
            % SET: fit parameter errors 
            % - associated with 95% confidence intervals
            fit(i).([fit_lbls{j},'_err_min']) = Est(j)  - ci(j,1);
            fit(i).([fit_lbls{j},'_err_max']) = ci(j,2) - Est(j);
        end

    end

end