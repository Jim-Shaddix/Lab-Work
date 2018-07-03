function tdms_data = Store_TDMS_Data(path_to_tdms_files)
% 1.) Reads in data From tdms files
% 2.) Synthesizes and stores new inforamtion from the data read in.

%% Read In Data                
% Reading, and storing data from tdms files, based on the directory
% specified by path_to_tdms_files variable.
                  
% Read in tdms File Data:
% NOTE: (1 file) -> (takes 0.25s)
tdms_data = RUSload(path_to_tdms_files);

%% Synthesize More Information
% In this section I store synthesized information in the tdms_data struct
  
% SET: index from the frequency data Where each peak Occured
for i = 1:length(tdms_data)  
    for j = 1:length(tdms_data(i).mag_given_peaks)      
        tdms_data(i).mag_given_peaks(j).index =  ...
            find(tdms_data(i).frequency   == ...
                                tdms_data(i).mag_given_peaks(j).Frequencies,1);   
    end
end

% SET: magnitude
tdms_data = set_magnitude(tdms_data);

% reorder the fields
names      = fieldnames(tdms_data);
temp_data  = names(end);
names(end) = names(end - 1);
names(end - 1) = temp_data;
tdms_data = orderfields(tdms_data, names);

%% Functions  

% RETURN: tdms_data with magnitude set
function data = set_magnitude(tdms_struct)
    for k = 1:length(tdms_struct)
        tdms_struct(k).magnitude = sqrt([tdms_struct(k).signal_x].^2 + ...
                                        [tdms_struct(k).signal_y].^2);
        data(k) = tdms_struct(k);
    end
end

end