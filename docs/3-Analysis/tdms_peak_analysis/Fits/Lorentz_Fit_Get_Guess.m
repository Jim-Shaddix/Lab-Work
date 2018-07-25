function guesses = Lorentz_Fit_Get_Guess(cell_x_peak,cell_y_peak_real,cell_y_peak_imag)
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
        
    end

end