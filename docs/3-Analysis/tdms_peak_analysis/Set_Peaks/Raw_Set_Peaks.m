function data = Raw_Set_Peaks(tdms_data)
% sets the peaks to be plotted: using [peakfind]
% - this function currently picks to many peaks

    for i = 1:length(tdms_data)
        
        % set real peaks
        [xpeak, xpeak_freq] =  ...
            findpeaks(tdms_data(i).signal_x,tdms_data(i).frequency);
        
        for j = 1:length(xpeak)
            tdms_data(i).raw_set_peaks(j).x_signal      = xpeak(j);
            tdms_data(i).raw_set_peaks(j).x_frequencies = xpeak_freq(j);
        end
        
        % set imag peaks
        [ypeak, ypeak_freq] =  ...
            findpeaks(tdms_data(i).signal_y,tdms_data(i).frequency);
        
        for j = 1:length(ypeak)
            tdms_data(i).raw_set_peaks(j).y_signal      = ypeak(j);
            tdms_data(i).raw_set_peaks(j).y_frequencies = ypeak_freq(j);
        end
        
        % set return value
        data = tdms_data;
        
    end
end

