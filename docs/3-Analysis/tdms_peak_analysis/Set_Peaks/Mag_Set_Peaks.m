function data = Mag_Set_Peaks(tdms_data)
% sets the peaks to be plotted: using [peakfind]
% - this function currently picks to many peaks

    for i = 1:length(tdms_data)
        
        % easier access to data
        signal_x = tdms_data(i).signal_x;
        signal_y = tdms_data(i).signal_y;
        freq     = tdms_data(i).frequency;
        mag = Magnitude(signal_x, signal_y);

        %% 
        % optional parameters for fit function
        peak_opts.MinPeakDistance   = 100;
        peak_opts.MinPeakProminence = 0.0001;
        
        % GET:  peaks
        [peak, peak_freq, width] = findpeaks(mag, freq, peak_opts);
                      
        %%    
        % SET: real peaks
        for j = 1:length(peak)
            tdms_data(i).mag_set_peaks(j).signal      = peak(j);
            tdms_data(i).mag_set_peaks(j).frequencies = peak_freq(j);
            tdms_data(i).mag_set_peaks(j).width       = width(j);
        end
        
        % set return value
        data = tdms_data;
        
    end
end
