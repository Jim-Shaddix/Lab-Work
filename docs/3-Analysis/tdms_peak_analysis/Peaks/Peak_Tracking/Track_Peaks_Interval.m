function [peaks_of_interest, cell_interval] = Track_Peaks_Interval(cell_peaks,freq_track,interval_size, discrim_method, check)
%PICK_PEAK_INTERVAL: returns the indices asscociated with all of the peaks of interest.
% 

    % ALLOCATE: indices in the peaks, that 
    indices_of_interest = zeros(1,length(cell_peaks));
    cell_interval = cell(1,length(cell_peaks));
    
    
    % SET: indices_of_interest
    
    % refferernce frequency, gets updated for each loop iteration
    freq_ref = freq_track;
    for i = 1:length(cell_peaks)
        
        % GET: Peaks
        peaks = cell_peaks{i};
                
        % SET: interval
        mmin = freq_ref-interval_size/2;
        mmax = freq_ref+interval_size/2;
        
        cell_interval{i} = [mmin,mmax];
        
        % GET: peaks in the interval
        indices_in_interval = [];
        for j = 1:length(peaks)
            if peaks(j).Frequencies > mmin && ...
               peaks(j).Frequencies < mmax
               indices_in_interval(end+1) = j;
            end
        end
        
        switch discrim_method
            case 'height'
                largest_height = 0;
                for j = 1:length(indices_in_interval)
                    if peaks(indices_in_interval(j)).mag > largest_height
                        indices_of_interest(i) = indices_in_interval(j);
                    end
                end
            case 'frequency'
                nearest_freq = 0;
                for j = 1:length(indices_in_interval)
                    if abs(peaks(indices_in_interval(j)).Frequencies -  freq_ref) < nearest_freq 
                        indices_of_interest(i) = indices_in_interval(j);
                    end
                end
                
            case 'manual'
                disp('I have not implemented the manual method!!!!')  
        end
        
        % UPDATE: frequency refference
        if isempty(indices_in_interval) == 0
            freq_ref = peaks(indices_of_interest(i)).Frequencies;
        end
        
        %% CHECK: Plot: magnitude data
%         if check == 1
%             fig = figure();
%             % get plot_info struct to plot
%             plot_info = Get_Plot_Struct();
% 
%             % MODIFY: plot info
%             plot_info.preprocess = tdms_data(i).plot_info.preprocess;
%             plot_info.mag  = 1;
%             plot_info.peaks_mag_given = [1,0];
%             Plot_File(tdms_data(i),plot_info);
% 
%             % Plot: original peak
%             y_lim=get(gca,'ylim');
%             plot(gca,[peak_ref, peak_ref],y_lim,'r--','DisplayName','original frequency');
%             
%             % Plot: peak found in current file
%             if isempty(indices_in_interval) == 0
%                 plot(gca,[freq_ref, freq_ref],y_lim,'b--','DisplayName','found frequency');
%             end
% 
%             % Plot: interval
%             if strcmp(discrim_method, 'height') || strcmp(discrim_method, 'frequency')
%                 plot(gca,[mmin, mmin],y_lim,'k','DisplayName','minimum peak bound');
%                 plot(gca,[mmax, mmax],y_lim,'k','DisplayName','maximum peak bound');
%             end
% 
%             title(["Temperature: ",tdms_data(i).temperature])
%             xlabel("Frequency (khz)")
%             ylabel("Voltage (V)")
%             legend()
% 
%             uiwait(fig);
%         end
        
    end

    % ALLOCATE/SET: return variable
    peaks_of_interest = cell(1,length(indices_of_interest)); 
    for i = 1:length(indices_of_interest)
         if indices_of_interest(i) == 0
            continue
         end
         peaks_of_interest{i} = cell_peaks{i}(indices_of_interest(i));
         %peaks_of_interest{i}.interval = interval{i};
         %peaks_of_interest{i}.freq_ref = freq_track;
    end
    
end
