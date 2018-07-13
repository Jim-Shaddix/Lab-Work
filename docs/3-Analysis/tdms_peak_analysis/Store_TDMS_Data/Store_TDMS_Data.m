function tdms_data = Store_TDMS_Data(path_to_tdms_files)
% 1.) Reads in data From tdms files
% 2.) Synthesizes and stores new inforamtion from the data read in.
           
% SET: tdms File Data
tdms_data = RUSload(path_to_tdms_files);

%% Synthesize More Information
% In this section I store synthesized information in the tdms_data struct

% SET: plot points where the peak occured
for i = 1:length(tdms_data)  
    for j = 1:length(tdms_data(i).mag_given_peaks)
        
        td = tdms_data(i); % for convienience
        mag = Magnitude(td.signal_x,td.signal_y);
        
        % index in the frequency list, where the peak occured
        index = find(td.frequency == td.mag_given_peaks(j).Frequencies,1);
        
        % set y-coordinates
        tdms_data(i).mag_given_peaks(j).signal_x = td.signal_x(index);
        tdms_data(i).mag_given_peaks(j).signal_y = td.signal_y(index);
        tdms_data(i).mag_given_peaks(j).mag      = mag(index);
        
    end
end

end
