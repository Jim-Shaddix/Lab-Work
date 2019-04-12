function all_peak_info = Get_Set_Peaks(cell_frequency, cell_signal_x, cell_signal_y, cell_peak_opts)
% sets the peaks to be plotted: using [peakfind] for both
%
% PARAMETERS:
% 1. mag_boolean: [boolean] if true,  fit is performed on the magnitude data
%                        if false, fit is performed on the raw data
% 2. cell_freuqency: [Cell] each cell contains all the frequncies
%                           associated with a particular file
% 3/4. cell_signal_x/y: [Cell] each cell contains all the signal data
%                           associated with a particular file
% 4. peak_opts: [struct] containing the optional parameters for peakfind
%
% RETURNS:
% 1. [cells of structs] -> each struct describing the peak found

    % ALLOCATE: return value
    all_peak_info = cell(1,length(cell_frequency));
    
    % SET: return struct fields
    for i = 1:length(all_peak_info)
        
        % easier access to data
        freq      = cell_frequency{i};
        signal_x  = cell_signal_x{i};
        signal_y  = cell_signal_y{i};
        peak_opts = cell_peak_opts{i};
        
        mag = Magnitude(signal_x, signal_y);
 
        % GET: peak info
        [peak_signal, peak_freq, peak_width] = findpeaks(mag, freq, peak_opts);
        
        % skip rest iteration if no peaks found
        if isempty(peak_signal)
            continue
        end

                
        % SET: peak info
        set_peaks(length(peak_signal)) = struct();

        for j = 1:length(peak_signal)

            % SET: basic info
            set_peaks(j).signal      = peak_signal(j);
            set_peaks(j).Frequencies = peak_freq(j);
            set_peaks(j).Width       = peak_width(j);

            % index in the frequency list, where the peak occured
            index = find(freq == set_peaks(j).Frequencies, 1);

            % SET: y-coordinates
            set_peaks(j).signal_x = signal_x(index);
            set_peaks(j).signal_y = signal_y(index);
            set_peaks(j).mag      = mag(index);

        end
            
        all_peak_info{i} = set_peaks;
        clear set_peaks
    end
end


