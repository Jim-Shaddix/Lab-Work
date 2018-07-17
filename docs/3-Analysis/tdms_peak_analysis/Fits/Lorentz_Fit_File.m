function fit = Lorentz_Fit_File(cell_x_cor_all, cell_real_cor_all, cell_imag_cor_all, cell_peak_data, peak_width)
% Lorentz_ Fit_File.m Fits a complex lorentzian function to all of the peaks 
% in a given dataset, returns the arrays of the fit parameters found, and
% coordinates associated with the applied fit function.
%
% PARAMETERS:
%   1. tdms_data:
%   2. peak_data:
%   3. peak_width:
%
% RETURN:
%   1. Est: [Cell-Array] Each cell contains the 5 calculated fit parameters
%   2. fit_x: [Cell-Array] The x-values, associated with the fit that took
%                          place for each peak
%   3. fit_real: [Cell-Array] The real-values, associated with the fit that
%                took place for each peak
%   4. fit_imag: [Cell-Array] The x-values, associated with the fit that
%                took place for each peak

    %fit(length(peak_data)) = struct();
    
    % perform fit on each peak in each file
    for i = 1:length(cell_peak_data)

        x_cor_all  = cell_x_cor_all{i};
        y_cor_all  = cell_real_cor_all{i} + cell_imag_cor_all{i}.*1i;
        peak_data  = cell_peak_data{i};
        
        % CHECK: if any peaks were found
        if isempty(peak_data)
            continue
        end
        
        % GET: coordinates to be fit
        [x_cor_fit, y_cor_fit] = Lorentz_Fit_Get_Cor([peak_data.Frequencies], peak_width, ...
                                     x_cor_all, y_cor_all);

        % Fit Parameters Guess:
        % [A, theta, gamma, f_0, offset]
        guesses = Lorentz_Fit_Get_Guess({peak_data.Frequencies}, ...
                                        {peak_data.signal_x},          ...
                                        {peak_data.signal_y});
        
        % Perform Fit & assighn variables to be returned
        a = Lorentz_Fit(x_cor_fit, y_cor_fit, guesses);
        fit{i} =  a;
        disp("FIT File:")
        disp(i)
    end

end