function [fit_x_cor, fit_y_cor] = Lorentz_Fit_Get_Window(x_cor_all, y_cor_all, x_cor_peaks, peak_widths, fit_width_multiplier, hard_coded_width, fit_width)
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

    % ALLOCATE: return variables
    fit_x_cor = cell(length(x_cor_peaks));
    fit_y_cor = cell(length(x_cor_peaks));

    for i = 1:length(x_cor_peaks)
        
        % easier access to data
        x_cor_peak = x_cor_peaks(i);
        peak_width = peak_widths(i);
        
        % SET: interval size
        if hard_coded_width == 1
            interval_size = fit_width;
        else 
            interval_size = peak_width * fit_width_multiplier;
        end
        
        % GET: indices of data to be fitted
        mmin = x_cor_peak - interval_size/2; % minimum x-coordinate
        mmax = x_cor_peak + interval_size/2; % maximum x-coordinate
        indices = (mmin <= x_cor_all) & (x_cor_all <= mmax);
        
        % CHECK: that the number of indices is greater than the minimum
        % number of indices that you would like to use for a fit.
        % if this is not done, the program may throw an error when the peak
        % is fit, because you cannot fit a model to a single data point
        while (sum(indices) < 6)
            
            % get boundary elements
            first_index = find(indices,1,'first');
            last_index  = find(indices,1,'last');
            
            % add element to front
            if first_index ~= 1
                indices(first_index - 1) = 1; 
            end
            
            % add element to back
            if last_index ~= length(indices)
                indices(last_index + 1) = 1; 
            end
            
        end

        % STORE: values in return variables
        fit_y_cor{i} = y_cor_all(indices);
        fit_x_cor{i} = x_cor_all(indices);
    end
    
end
