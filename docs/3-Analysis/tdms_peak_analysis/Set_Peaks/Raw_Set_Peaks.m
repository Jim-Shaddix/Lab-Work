function data = Raw_Set_Peaks(tdms_data)
% sets the peaks to be plotted: using [peakfind]
% - this function currently picks to many peaks

    for i = 1:length(tdms_data)
        
        % easier access to data
        signal_x = tdms_data(i).signal_x;
        signal_y = tdms_data(i).signal_y;
        freq    = tdms_data(i).frequency;

        %% 
        % optional parameters for fit function
        peak_opts.MinPeakDistance   = 10000;
        peak_opts.MinPeakProminence = 0.001;
        % GET: real peaks
        [xpeak, xpeak_freq, x_width] = findpeaks(signal_x, freq, peak_opts);
        
        % GET: imag peaks
        [ypeak, ypeak_freq, y_width] = findpeaks(signal_y, freq, peak_opts);
              
        %%    
        % SET: real peaks
        for j = 1:length(xpeak)
            tdms_data(i).raw_set_peaks(j).x_signal      = xpeak(j);
            tdms_data(i).raw_set_peaks(j).x_frequencies = xpeak_freq(j);
            tdms_data(i).raw_set_peaks(j).x_width       = x_width(j);
        end
        
        % SET: imag peaks
        for j = 1:length(ypeak)
            tdms_data(i).raw_set_peaks(j).y_signal      = ypeak(j);
            tdms_data(i).raw_set_peaks(j).y_frequencies = ypeak_freq(j);
            tdms_data(i).raw_set_peaks(j).y_width       = y_width(j);
        end
        
        % set return value
        data = tdms_data;
        
    end
end

