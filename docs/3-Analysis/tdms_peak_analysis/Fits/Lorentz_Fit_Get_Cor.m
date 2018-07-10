function [fit_x_cor, fit_y_cor] = Lorentz_Fit_Get_Cor(x_cor_peak, peak_width, x_cor_all, y_cor_all)
% LORENTZ_FIT_REGION: Returns the x/y-coordinates, that will be 
% used to perform the lorentizian fit.
%
% RETURNS:
% * fit_x_cor: The x-coordinates that will be used for the fit
% * fit_y_cor: The complex y-coordinates that will be used for the fit
%
% PARAMETERS:
% * x_cor_peak: the x coordinate associated with where a peak occured.
% * peak_width: the width of x-coordinates associated with how large the
%               fit interval is.
% * x_cor_all: All of the x-coordinates associated with data
% * all_real_cor: All of the real-coordinates associated with data
% * all_imag_cor: All of the imaginary-coordinates associated with data
%
% EXAMPLE CALL:
% 

    % GET: indices of data to be fitted
    mmin = x_cor_peak - peak_width/2; % minimum x-coordinate
    mmax = x_cor_peak + peak_width/2; % maximum x-coordinate
    indices = mmin <= x_cor_all & x_cor_all <= mmax;
    
    fit_y_cor  = y_cor_all(indices);
    fit_x_cor  = x_cor_all(indices);
    
end

