function [temperature, magnetic_field] = Get_Independent_Variables(file_name, RUSdata)
    % PARAMETERS:
    % * tdms_data: (struct array) each element stores all of the data
    %              associated with a given file.
    % * path_to_files: (char array) that contains the path name to the tdms
    %                  files
    % * tdms_file_names: (cell array) containing the file names for each of
    %                    the tdms files.
    %
    % RETURN:
    % * map_meas_values (Map) measurments -> values.

    % CHECK: if field and temperature values are stored in the tdms files
    if isfield(RUSdata, 'mnt')

        % Parse values from RUS data structure 
        % - (reads in the first value that is stored in the file)
        temperature = RUSdata.mnt.T.data(1);
        magnetic_field = RUSdata.mnt.B.data(1);
        fprintf('[Parsed from the data]\n\n');

    else

        % Parse values from file names
        %map_meas_values = Parse_File_Names(tdms_data(i).file_name);
        temperature = strip_file('K', file_name);
        magnetic_field = strip_file('oe', file_name);                        
        fprintf('[Parsed from the file name]\n\n');

    end
    
    % SET: magnetic field to zero, if the value
    %      nan was found.
    if isnan(magnetic_field)
        magnetic_field = 0;
    end
    
    % SET: temperature to zero, if the value
    %      nan was found.
    if isnan(temperature)
        temperature = 0;
    end


end


function stripped_value = strip_file(unit2match, file_name)
    % Strips out a value associated with a filename
    % filename: character array to strip from.
    % unit2match: my program will strip out values associated with the units 
    %             passed in.
    
    matches = regexp(file_name,['_[+-]?\d*\.?\d*',unit2match,'_'], 'match');
    if isempty(matches)
       stripped_value = 0;
    else
       stripped_value = matches{end}(2:end-(length(unit2match)+1));
       stripped_value = str2double(stripped_value);
    end

end