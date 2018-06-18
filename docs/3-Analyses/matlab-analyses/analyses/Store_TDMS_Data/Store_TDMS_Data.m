
function tdms_data = Store_TDMS_Data(path_to_tdms_files)
% This function:
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
                
% Quadature Data
tdms_data = set_quad(tdms_data);

% Frequency Index Where Each Peak Occured
for i = 1:length(tdms_data)  
    for j = 1:length(tdms_data(i).given_peaks)      
        tdms_data(i).given_peaks(j).index = ...
            find(tdms_data(i).frequency == tdms_data(i).given_peaks(j).Frequencies,1);   
    end
end
  
                %% Functions              
% sets the quadature data
function data = set_quad(tdms_struct)
    for i = 1:length(tdms_struct)
        tdms_struct(i).my_quad = sqrt([tdms_struct(i).signal_x].^2 + [tdms_struct(i).signal_y].^2);
        data(i) = tdms_struct(i);
    end
end

end