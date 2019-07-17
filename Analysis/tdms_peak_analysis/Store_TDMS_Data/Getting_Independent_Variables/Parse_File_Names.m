function map_meas_values = Parse_File_Names(cell_tdms_file_names)
%STORE_INDEPENDENT_VARIABLES 
% PARAMETERS: 
%   * cell_tdms_file_names: cell array of tdms file names.
% RETURNS:
% map_meas_values: map (char array          -> cell array of numbers): 
%                      (indpendent variable -> values)

    %% PARSE: Independent Variable Values From File Names
    %
    %   The value of independent variables are stored in the file names.
    %   For RUS-probe experiments, that typically means temperature and
    %   and magnetic field values. This section of the code will parse
    %   out those values from the filenames.
    %   * Values are parsed out using regular expressions.
    %     * All fields with values of with indpendent variable values
    %       I am interested in processing are sepperated by underscores.
    %
    %     EXAMPLE FILE NAMES:
    %     * For the units T and oe, valid file names are displayed below.
    %
    %     * x:   represents some character
    %     * ...: used to denote that any number of characters are valid.
    %     * f: repsents some floating point number
    %     
    %     1. xxx ... _fT_  ... xxx.tdms
    %     2. xxx ... _foe_ ... xxx.tdms
    %     3. xxx ... _fT_  ... _foe_ ... xxx.tdms
    %     4. xxx ... _foe_ ... _fT_  ... xxx.tdms
    
    % Map 
    map_meas_values = containers.Map;
        
    function stripped_value = strip_value(unit2match, file_name)
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

