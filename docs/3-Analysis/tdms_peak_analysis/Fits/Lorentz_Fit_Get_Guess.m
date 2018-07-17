function guesses = Lorentz_Fit_Get_Guess(cell_x_peak,cell_y_peak_real,cell_y_peak_imag)
% LORENTZ_FIT_GUESS: returns the fit parameter guesses for a Lorentzian 
% function: [A, theta, gamma, f_0, offset]
%
% PARAMETERS:
% 1. x: where the peak occured on the x-axis
% 2. y_peak_real: where the peak occured on the y-axis
% 3. y_peak_imag: where the peak occured on the y-axis

% EXAMPLE CALL:
% * Lorentz_Fit_Guess(tdms_data.mag_given_peaks(1))
        
    len = length(cell_x_peak);

    guesses  = cell(len);

    for i = 1:len
        
        x_peak      = cell_x_peak{i};
        y_peak_real = cell_y_peak_real{i};
        y_peak_imag = cell_y_peak_imag{i};
        
        % SET: parameters
        %A = fit_data;
        %x = [max([y_peak_real,y_peak_imag]), 0,     10,    (mmin+mmax)/2, 0];
        A      = max(y_peak_real,y_peak_imag);
        theta  = 0;
        gamma  = 10;
        f_0    = x_peak;
        offset = 0;
        
        guesses{i} = [A,theta,gamma,f_0,offset];
        
    end


end