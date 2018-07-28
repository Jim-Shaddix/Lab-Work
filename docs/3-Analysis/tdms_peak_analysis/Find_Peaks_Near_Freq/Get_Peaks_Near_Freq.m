function [peaks_of_interst,peak_temp] = Get_Peaks_Near_Freq(tdms_data_all, peak_str, freq_ref)
%GET_PEAKS_NEAR_FREQ: tracks a particular peak across multiple files, and
%                     returns all of the peak structs, concerning the peak
%                     of intersts

    % tracking the peak near 8.5 *10^5 khz for the given data for TAV2
    peak_indices = [1,1,1,2 ... 
                  3,1,2,2 ...
                  3,3,2,2 ...
                  3,3,2,2 ...
                  2,2,2,1 ...
                  2,1,1,2 ...
                  3,2,2,2 ...
                  2,1,1,1 ...
                  1,1,2,1 ...
                  0,0,1,0 ...
                  1];

    len = length(peak_indices);

    % SET: return variables
    peaks_of_interst = {};
    peak_temp = [];
    for i = 1:len
         if peak_indices(i) == 0
            continue
         end
         peaks_of_interst{end+1} = tdms_data_all(i).(peak_str)(peak_indices(i));
         peak_temp(end+1) = tdms_data_all(i).temperature;
    end
    peaks_of_interst = [peaks_of_interst{:}];
    
end

