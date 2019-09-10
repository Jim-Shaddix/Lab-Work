function [map_meas_values] = Read_Variables_From_Struct(cell_tdms_file_names)
% READ_VARIABLES_FROM_STRUCT 

    % Map 
    map_meas_values = containers.Map;

    % measurments: are used as lables to store in formation in a struct
    % unites: are used as values to search for in file names 
    project_config = Get_Project_Struct();
    units        = project_config.map_measurement_unit.values;
    measurements = project_config.map_measurement_unit.keys;

    % store data in tdms_data
    % - loop over the different units, and parse the values from each
    %   file name, associated with the units passed in.
    for i=1:length(units)
        
        % values associated with each unit
        unit_values = cellfun(@(f) strip_value(units{i},f), ...
                              cell_tdms_file_names);
        
        map_meas_values(measurements{i}) = num2cell(unit_values);
    end
    
end