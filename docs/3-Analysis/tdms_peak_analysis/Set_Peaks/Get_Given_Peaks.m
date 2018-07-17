function all_peak_info = Get_Given_Peaks(cell_frequency, cell_signal_x, cell_signal_y, cell_mag_given_peaks)

    % INITIALIZE: return value
    all_peak_info = cell(1,length(cell_frequency));

    % SET: return struct fields
    for i = 1:length(all_peak_info)
        
        % easier access to data
        freq            = cell_frequency{i};
        signal_x        = cell_signal_x{i};
        signal_y        = cell_signal_y{i};
        mag_given_peaks = cell_mag_given_peaks{i};
        
        mag = Magnitude(signal_x, signal_y);
            
        for j = 1:length(mag_given_peaks) 

            % index in the frequency list, where the peak occured
            index = find(freq == mag_given_peaks(j).Frequencies, 1);

            % SET: y-coordinates
            mag_given_peaks(j).signal_x = signal_x(index);
            mag_given_peaks(j).signal_y = signal_y(index);
            mag_given_peaks(j).mag      = mag(index);

        end
        all_peak_info{i} = mag_given_peaks;
    end
end
