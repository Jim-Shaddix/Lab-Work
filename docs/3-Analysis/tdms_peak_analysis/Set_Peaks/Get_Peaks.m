function all_peak_info = Get_Peaks(mag_boolean, cell_frequency, cell_signal_x, cell_signal_y, peak_opts)
% sets the peaks to be plotted: using [peakfind]

    % SET: optional parameters for fit function
    if nargin < 5
        peak_opts.MinPeakDistance   = 100;
        peak_opts.MinPeakProminence = 0.0001;
    end

    % INITIALIZE: return value
    all_peak_info(length(cell_frequency)) = struct();
    
    % SET: return struct fields
    for i = 1:length(cell_frequency)
        
        % easier access to data
        freq     = cell_frequency{i};
        signal_x = cell_signal_x{i};
        signal_y = cell_signal_y{i};
        
        mag = Magnitude(signal_x, signal_y);
 
        % GET: peak info
        if mag_boolean == true
            [peak_signal, peak_freq, peak_width] = findpeaks(mag, freq, peak_opts);
        else
            [xpeak_signal, xpeak_freq, xpeak_width] = findpeaks(signal_x, freq, peak_opts);
            [ypeak_signal, ypeak_freq, ypeak_width] = findpeaks(signal_y, freq, peak_opts);
        end
                
        % SET: peak info
        if mag_boolean
            
            for j = 1:length(peak_signal)    
                % SET: basic info
                all_peak_info(i).set_peaks(j).signal      = peak_signal(j);
                all_peak_info(i).set_peaks(j).Frequencies = peak_freq(j);
                all_peak_info(i).set_peaks(j).width       = peak_width(j);

                % index in the frequency list, where the peak occured
                index = find(freq == all_peak_info(i).set_peaks(j).Frequencies,1);

                % SET: y-coordinates
                all_peak_info(i).set_peaks(j).signal_x = signal_x(index);
                all_peak_info(i).set_peaks(j).signal_y = signal_y(index);
                all_peak_info(i).set_peaks(j).mag      = mag(index);
            end
            
        else
            
            for j = 1:length(xpeak_signal)
                % SET: basic info
                all_peak_info(i).set_peaks(j).x_signal      = xpeak_signal(j);
                all_peak_info(i).set_peaks(j).x_frequencies = xpeak_freq(j);
                all_peak_info(i).set_peaks(j).x_width       = xpeak_width(j);
            end
            
            for j = 1:length(ypeak_signal)
                % SET: basic info
                all_peak_info(i).set_peaks(j).y_signal      = ypeak_signal(j);
                all_peak_info(i).set_peaks(j).y_frequencies = ypeak_freq(j);
                all_peak_info(i).set_peaks(j).y_width       = ypeak_width(j);
            end
            
        end
        
    end
    
end
