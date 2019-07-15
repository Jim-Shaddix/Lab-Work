function map_meas_values = Get_Independent_Variables(tdms_data)

    % GET: filenames, so we parse values from them.
    cell_tdms_file_names =  num2cell([tdms_data.file_name]);
    
    % Parse values from file names
    map_meas_values = Parse_File_Names(cell_tdms_file_names);
    
end

