function tdms_data = Store_TDMS_Data(path_to_tdms_files, cut)
% 1.) Reads in data From tdms files
% 2.) Synthesizes and stores new inforamtion from the data read in.

if nargin < 2
    cut = 5;
end
           
% SET: tdms File Data
tdms_data = RUSload(path_to_tdms_files);

%% Synthesize More Information
% In this section I store synthesized information in the tdms_data struct
  
% SET: magnitude
tdms_data = set_magnitude(tdms_data);

% SET: plot points where the peak occured
for i = 1:length(tdms_data)  
    for j = 1:length(tdms_data(i).mag_given_peaks)  
        
        td = tdms_data(i); % for convienience
        
        % index in the frequency list, where the peak occured
        index = find(td.frequency == td.mag_given_peaks(j).Frequencies,1);
        
        % set y-coordinates
        tdms_data(i).mag_given_peaks(j).signal_x = td.signal_x(index);
        tdms_data(i).mag_given_peaks(j).signal_y = td.signal_y(index);
        tdms_data(i).mag_given_peaks(j).mag      = td.magnitude(index);
        
    end
end

% cut off the first couple plot points.
% - this is done to remove anomalous peaks that may disrupt the analysis
% for i = 1:length(tdms_data) 
%     tdms_data(i).frequency = tdms_data(i).frequency(cut:end);
%     tdms_data(i).signal_x  = tdms_data(i).frequency(cut:end);
%     tdms_data(i).signal_y  = tdms_data(i).frequency(cut:end);
% end


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