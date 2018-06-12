function [tdms_data,RUSdata]=RUSload(path_to_files)
% * Reads directory (path_to_files) for filenames and 
%   loads all TDMS files into Cell Array. 
% * Extracts Temperature from filename string by finding character 'K'. 
%
% EXAMPLE CALL: 
%  path_to_files='/Users/peter/Desktop/Research/BaIrO3/RUS/5_15_2018/TDMS/';
%  RUSdataCell=RUSload(path_to_files)
%
% POTENTIAL IMPROVEMENTS:
% * tdms_file_names -> use (array) instead of (cell-array)
% * RUSdata         -> use (array) instead of (cell-array)
% * Find a more robust way to parse the temperature

% Read in File Names, From the Given Directory
dir_data   = dir(path_to_files);
file_names = {dir_data.name};

% Store tdms File Names in: [Cell-Array] -> tdms_file_names
tdms_file_names = {};
j=1;
for i=1:length(file_names)
    if contains(file_names{i},'tdms') == 1
        tdms_file_names{j}=file_names{i};
        j=j+1;
    end
end

% Store tdms File Data in: [Cell] -> RUSdata
RUSdata   = cell(1, length(tdms_file_names));
tdms_data = struct([]);
for i=1:length(tdms_file_names)
    
    % Store tdms Data Struct
    RUSdata{i} = TDMS_getStruct([path_to_files,tdms_file_names{i}]);
    
    % Store File Name
    RUSdata{i}.FileName=tdms_file_names{i};
    
    % Store Temperature From File Name
    temperature_ind = strfind(RUSdata{i}.FileName,'K');
    temperature_str = RUSdata{i}.FileName(temperature_ind-3:temperature_ind);
    
    RUSdata{i}.temperature_str = temperature_str;
    RUSdata{i}.temperature     = str2double(temperature_str(1:3));
    
    tdms_data(i).file_name       = tdms_file_names{i};
    tdms_data(i).temperature_str = temperature_str;
    tdms_data(i).temperature     = str2double(temperature_str(1:3));
    
    tdms_data(i).frequency       = RUSdata{i}.p.Frequency.data;
    tdms_data(i).signal_x        = RUSdata{i}.p.Signal_X.data;
    tdms_data(i).signal_y        = RUSdata{i}.p.Signal_Y.data;
    
    % get peak fields -> [cell-array] fields
    peak_struct = RUSdata{i}.fit;
    fields      = fieldnames(peak_struct);
    
    % -------------------------------------------
    % Store Peak Frequencies
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Peak')
            tdms_data(i).given_peaks(k).Frequencies = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store F
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'F')
            tdms_data(i).given_peaks(k).F = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store Width
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Width')
            tdms_data(i).given_peaks(k).Width = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store Amplitude
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Amplitude')
            tdms_data(i).given_peaks(k).Amplitude = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store Phase
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Phase')
            tdms_data(i).given_peaks(k).Phase = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store Xbg
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Xbg')
            tdms_data(i).given_peaks(k).Xbg = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
    % Store Ybg
    k = 1;
    for j = 1:length(fields)
        if contains(fields{j}, 'Ybg')
            tdms_data(i).given_peaks(k).Ybg = peak_struct.(fields{j}).data;
            k = k+1;
        end
    end
    
%     % M = containers.Map('a',5)
%     field_ids = ['Peak','F','Width','Amplitude','Phase','Xbg','Ybg'];
%     indices  = zeros(length(fields));
%     m = containers.Map(field_ids,indices);
%     
%     % Store Peak Frequencies
%     for k = 1:length(field_ids)
%         for j = 1:length(fields)
%             if contains(fields{j}, field_ids(k))
%                 
%                 m(k) = m(k) + 1;
%                 
%                 switch k 
%                     case 1
%                         tdms_data(i).given_peaks(m(k)).frequencies = ...
%                             peak_struct.(fields{j}).data;
%                     case 2
%                         tdms_data(i).given_peaks(m(k)).F = ...
%                             peak_struct.(fields{j}).data;
%                     case 3
%                         tdms_data(i).given_peaks(m(k)).Width = ...
%                             peak_struct.(fields{j}).data;
%                     case 4
%                         tdms_data(i).given_peaks(m(k)).Amplitude = ...
%                             peak_struct.(fields{j}).data;
%                     case 5
%                         tdms_data(i).given_peaks(m(k)).Phase = ...
%                             peak_struct.(fields{j}).data;
%                     case 6
%                         tdms_data(i).given_peaks(m(k)).Xbg = ...
%                             peak_struct.(fields{j}).data; 
%                     case 7
%                         tdms_data(i).given_peaks(m(k)).Ybg = ...
%                             peak_struct.(fields{j}).data;   
%                 end
%             end
%         end    
%     end
    

    
    
    
    
    
end




end

