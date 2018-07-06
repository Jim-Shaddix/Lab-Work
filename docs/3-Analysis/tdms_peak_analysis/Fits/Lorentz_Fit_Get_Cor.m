function [x_cor, y_cor] = Lorentz_Fit_Get_Cor(peak_x_cor, peak_width, all_x_cor, all_real_cor,all_imag_cor)
% LORENTZ_FIT_REGION: Returns the x/y-coordinates, that will be 
% used to perform the lorentizian fit.
%
% RETURNS:
% * x_cor: The x-coordinates that will be used for the fit
% * y_cor: The  complex y-coordinates that will be used for the fit
%
% PARAMETERS:
% * peak_x_cor: the x coordinate associated with where a peak occured.
% * peak_width: the width of x-coordinates associated with how large the
%               fit interval is.
% * all_x_cor: All of the x-coordinates associated with data
% * all_real_cor: All of the real-coordinates associated with data
% * all_imag_cor: All of the imaginary-coordinates associated with data
%
% EXAMPLE CALL:
% 

    % GET: indices of data to be fitted
    mmin = peak_x_cor - peak_width/2; % minimum x-coordinate
    mmax = peak_x_cor + peak_width/2; % maximum x-coordinate
    indices = mmin <= all_x_cor & all_x_cor <= mmax;
    
    % SET: x_cor & y_cor that will be fitted:   
    y_real = all_real_cor(indices);
    y_imag = all_imag_cor(indices);
    
    y_cor = y_real + 1i.*y_imag;
    x_cor  = all_x_cor(indices);
    
end

