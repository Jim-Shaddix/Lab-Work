function tdms_data=RUSload(path_to_files)
% 1. Reads directory (path_to_files) for filenames and 
%    loads all TDMS files into Cell Array. 
% 2. Extracts Temperature from filename string by finding character 'K'. 
%
% EXAMPLE CALL: 
%  path_to_files='/Users/peter/Desktop/Research/BaIrO3/RUS/5_15_2018/TDMS/';
%  RUSdataCell=RUSload(path_to_files)

% GET: file names, from the given directory
dir_data   = dir(path_to_files);
file_names = {dir_data.name};

% STORE: tdms file names in: [Cell-Array] -> tdms_file_names
tdms_file_names = {};
j=1;
for i=1:length(file_names)
    [filepath,name,ext] = fileparts(file_names{i});
    if contains(ext,'.tdms')
        tdms_file_names{j}=file_names{i};
        j=j+1;
    end
end

% CHECK: that tdms files were found
if isempty(tdms_file_names)
    fprintf("No tdms Files Were Found in the directory passed in:\n\n")
    disp(path_to_files)
    fprintf("\n These are the files/directories that were found:\n")
    for i = 1:length(file_names)
        disp(file_names(i))
    end
    error("Failed to find tmds files in the provided path !!!")
end

% STORE: tdms file data in: [Struct] -> tdms_data
tdms_data = struct();
for i=1:length(tdms_file_names)
    
    % STORE: tdms Data Struct
    RUSdata = TDMS_getStruct([path_to_files,tdms_file_names{i}]);
    
    % GET/STORE: File Name
    file_name = tdms_file_names{i};
    tdms_data(i).file_name       = file_name;
    
    % GET/STORE: Temperature From File Name Using Regex
    pattern = '\d{0,3}\.?\d+K';
    temperature_str = erase(regexp(file_name, pattern, 'match'), 'K');
    tdms_data(i).temperature     = str2double(temperature_str);
    
    % STORE: Plot Data
    tdms_data(i).frequency       = RUSdata.p.Frequency.data;
    tdms_data(i).signal_x        = RUSdata.p.Signal_X.data;
    tdms_data(i).signal_y        = RUSdata.p.Signal_Y.data;
    
    % CHECK: if peaks were found in the tdms file
    if ~isfield(RUSdata,'fit')
        continue
    end
    
    % Store Peak Information
    % ---------------------------------------------------------------------
    
    % GET: peak fields -> [cell-array] fields
    peak_struct = RUSdata.fit;
    fields      = fieldnames(peak_struct);
    
    % Store Peak Frequencies
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Peak')
            tdms_data(i).mag_given_peaks(k).Frequencies = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store F
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'F')
            tdms_data(i).mag_given_peaks(k).F = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store Width
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Width')
            tdms_data(i).mag_given_peaks(k).Width = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store Amplitude
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Amplitude')
            tdms_data(i).mag_given_peaks(k).Amplitude = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store Phase
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Phase')
            tdms_data(i).mag_given_peaks(k).Phase = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store Xbg
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Xbg')
            tdms_data(i).mag_given_peaks(k).Xbg = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store Ybg
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Ybg')
            tdms_data(i).mag_given_peaks(k).Ybg = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
end

end

