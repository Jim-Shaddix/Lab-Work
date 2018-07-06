function [Est, fit_x, fit_real, fit_imag] = Lorentz_Fit_File(tdms_data, peak_data, peak_width)
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

    % fit coordinates/parameters to be returned
    fit_x    = cell(1, length(peak_data));
    fit_real = cell(1, length(peak_data));
    fit_imag = cell(1, length(peak_data));
    Est      = cell(1, length(peak_data));

    % perform fit on each peak in file
    for i = 1:length(peak_data)

        % GET: coordinates to be fit
        [x_cor, y_cor] = Lorentz_Fit_Get_Cor(peak_data(i).Frequencies, peak_width, ...
                                     tdms_data.frequency, tdms_data.signal_x,tdms_data.signal_y);

        % Fit Parameters Guess:
        % [A, theta, gamma, f_0, offset]
        [a,b,c,d,e] = Lorentz_Fit_Get_Guess(peak_data(i).Frequencies, ...
                                      peak_data(i).signal_x,   ...
                                      peak_data(i).signal_y);
        guess = [a,b,c,d,e];
        
        % Perform Fit & assighn variables to be returned
        [Est{i},fit_x{i},fit_real{i},fit_imag{i}] =  ...
            Lorentz_Fit(x_cor, y_cor, guess);

    end

end