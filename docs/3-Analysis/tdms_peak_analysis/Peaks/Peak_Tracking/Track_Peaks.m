function peaks_of_interest = Get_Peaks_Near_Freq(tdms_data_all, peak_str, freq_ref, interval_size, discrim_method)
%GET_PEAKS_NEAR_FREQ: tracks a particular peak across multiple files, and
%                     returns all of the peak structs, concerning the peak
%                     of intersts

    % GET: peak_indices
    peak_indices   = Track_Peaks_Interval(tdms_data_all,      ...
                                        peak_str,       ...
                                        freq_ref,       ...
                                        interval_size,  ...
                                        discrim_method, ...
                                        false);                       
    % ALLOCATE/SET: return variables
    peaks_of_interest = {length(peak_indices)};
    %peak_temp = zeros(1,length(peak_indices));
    for i = 1:length(peak_indices)
         if peak_indices(i) == 0
            continue
         end
         peaks_of_interest{i} = tdms_data_all(i).(peak_str)(peak_indices(i));
   %      peak_temp(i) = tdms_data_all(i).temperature;
    end
    
end