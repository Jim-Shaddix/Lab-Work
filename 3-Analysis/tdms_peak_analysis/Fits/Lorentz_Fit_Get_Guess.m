function guesses = Lorentz_Fit_Get_Guess(cell_x_peak,cell_y_peak_real,cell_y_peak_imag, peak_structs)
% LORENTZ_FIT_GUESS: returns the fit parameter guesses for a Lorentzian 
% function: [A, theta, gamma, f_0, offset]
%
% PARAMETERS:
% 1. x: where the peak occured on the x-axis
% 2. y_peak_real: where the peak occured on the y-axis
% 3. y_peak_imag: where the peak occured on the y-axis
        
    % INITIALIZE: return value
    guesses  = cell(length(cell_x_peak));

    for i = 1:length(cell_x_peak)
        
        % initial guess for old model
        
        % easier access to data
        x_peak      = cell_x_peak{i};
        y_peak_real = cell_y_peak_real{i};
        y_peak_imag = cell_y_peak_imag{i};
        
        % SET: parameters
        A      = max(y_peak_real,y_peak_imag);
        theta  = 0;
        gamma  = 100;
        f_0    = x_peak;
        x_offset = 0;
        y_offset = 0;
        
        % SET: return value
        guesses{i} = [A,theta,gamma,f_0,x_offset,y_offset];
        
        %% NEW Guess: (overwriting previous data)
        % 'A', 'theta', 'fn', 'Q', 'x_offset', 'y_offset'
        % Q_old = 860.914958369647;
        % A_old = 23437499.9986953
        % theta_old = 4.25054230278918
        % x_offset = 0.000104069506066014, ...
        % y_offset = 6.93860286422011e-05
         
%         Q = peak_structs(i).Frequencies / peak_structs(i).Width;
%         
%         % Fit 2 params
%         cell_params = {128, ...
%                        0, ...
%                        x_peak, ...
%                        1200, ...
%                        0, ...
%                        0};
% 
%          [A, theta, fn, Q, x_offset, y_offset] = cell_params{:};
%         
        %%
        % SET: return value
        %guesses{i} = [A, theta, fn, Q, x_offset, y_offset];

        %% Dynamically Determine A:
        % - increase A, until the average magnitude is within a 
        %   factor of 2 of the answer
        
%         % get mean magnitude of the data
%         data_mag = abs(y_peak_real + 1j*y_peak_imag);
%         
%         % Get: mean magnitude of the approximation
%         project_config = Get_Project_Struct();
%         model          = project_config.model;
%         current_approx = model(guesses{i}, x_peak);
%         current_approx_mag = abs(current_approx);
% 
%         % Update A
%         while current_approx_mag < data_mag
%             current_approx_mag = current_approx_mag * 2;
%             guesses{1} = guesses{1} * 2;
%         end

    end

end