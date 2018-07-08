function [outputArg1,outputArg2] = Cut_Font(tdms_data, count)
%CUT_DATA removes the first "count" elements from the front of the dataset.
%This function removes the first frequency, signal_x, signal_y values that
%are being stored. This function also removes the given peaks that were
%cutoff as well. 
%
% NOTE: 
% * This function should be called prior to setting your own peaks
% * This function is used to remove anomalous peaks that may disrupt the 
%   analysis

    % cut off the first couple plot points.
    for i = 1:length(tdms_data) 
         tdms_data(i).frequency = tdms_data(i).frequency(cut:end);
         tdms_data(i).signal_x  = tdms_data(i).frequency(cut:end);
         tdms_data(i).signal_y  = tdms_data(i).frequency(cut:end);
    end

end