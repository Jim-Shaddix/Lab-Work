function [cell_peaks_of_interest, cell_interval] = Track_Peaks_Interval(cell_peaks,freq_track,interval_size)
%PICK_PEAK_INTERVAL: This method tracks a particular peak, by constructing
% an interval about the x-coordinate where a peak occurs, and than
% capturing the peaks corresponding to the next file that fall inside that
% interval. The center of the interval is set to the new peak that is
% found.
%
% RETURNS: a cell array of all of the peaks of interest.
% PARAMETERS: * cell_peaks: [cell array] each element contains all of the 
%                           peak structs associated with a file.
%             * freq_track: The frequency to begin tracking.
%             * interval_size: the size of the interval that is used for 
%                              tracking peaks. 

    % ALLOCATE: indices in the peaks, that 
    cell_peaks_of_interest = cell(1,length(cell_peaks));
    cell_interval          = cell(1,length(cell_peaks));
    
    % refferernce frequency, gets updated for each loop iteration
    freq_ref = freq_track;
    
    for i = 1:length(cell_peaks)
        
        % GET: Peaks
        peaks = cell_peaks{i};
                
        % SET: interval
        mmin = freq_ref-interval_size/2;
        mmax = freq_ref+interval_size/2;
        cell_interval{i} = [mmin,mmax];
        
        % GET: peaks in interval
        peaks_in_interval = peaks( mmin < [peaks.Frequencies] & ...
                                   mmax > [peaks.Frequencies] );
        
        % SET: cell_peaks_of_interest
        [~,max_index] = max([peaks_in_interval.mag]);
        cell_peaks_of_interest{i} = peaks_in_interval(max_index);             
        
        % UPDATE: frequency refference
        if isempty(peaks_in_interval) == 0
            freq_ref = cell_peaks_of_interest{i}.Frequencies;
        end
   
    end

end
