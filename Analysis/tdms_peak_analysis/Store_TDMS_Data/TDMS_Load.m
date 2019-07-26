function tdms_data=TDMS_Load(path_to_files)
% 1. Reads directory (path_to_files) for filenames and 
%    loads all TDMS files into Cell Array. 
% 2. Extracts Temperature and Magnetic fields from filenames.
%    See the next section for a more thourogh description of how this is
%    done.
% 3. extracts signal_x, and signal_y data from the tdms files.
%
% PARAMETERS:
% 1. path_to_files (char array): describes the directory path to search for 
%                                tdms files.

    %% Store File Information ----------------------------------------------
    
    % UPDATE path_to_files
    % - this is done to accomodate the TDMS_getStruct function, that
    %   requires that the directory passed in ends with '/'.
    path_to_files = char(path_to_files);
    if path_to_files(end) ~= '/'
        path_to_files(end+1) = '/';
    end

    % GET: structure that descibes the provided path
    dir_struct = dir(path_to_files);
    
    % CHECK: if a faulty directory was passed in.
    % refferences to the current and previous directory will always be
    % found, so if no files or directiories are found, than a faulty path
    % was used.
    if isempty(dir_struct)
        error(['No files were found in the directory specified!',     ...
               ' This may be the result of a non-existent directory', ...
               ' being specified.']);
    end
    
    % GET: file names ending with .tdms
    file_names      = string({dir_struct.name});
    tdms_file_names = file_names(endsWith(file_names,'.tdms'));
    
    % CHECK: [For if a .tdms file was found]
    if isempty(tdms_file_names)
        fprintf('No tdms Files Were Found in the directory passed in:\n')
        fprintf([char(path_to_files),'\n\n'])
        fprintf('These are the files/directories that were found:\n');
        disp(file_names');
        error('Failed to find tdms files in the provided path !!!');
    end
    
    %% INIT struct
    
    % units / measurments are used in the next section for 
    % parsing file names
    project_config = Get_Project_Struct();
    units        = project_config.map_measurement_unit.values;
    measurements = project_config.map_measurement_unit.keys;
    
    % Creates the struct template that I will be storing all 
    % of the info from the tdms files into.
    tdms_data = Get_RUS_Data_Struct(measurements);
    tdms_data(2:length(tdms_file_names)) = tdms_data(1);
    
    % store all of the tdms file names into tdms_data struct
    cell_tdms_file_names =  num2cell(tdms_file_names);
    [tdms_data.file_name] = cell_tdms_file_names{:};
    
    %% PARSE: Independent Variable Values From File Names

    % store measurments
    map_meas_values = Get_Independent_Variables(tdms_data);
    for i=1:length(measurements)
        m = measurements{i};
        cell_values = map_meas_values(m);
        [tdms_data.(m)] = cell_values{:};
    end
        
    % Creating ID's
    % would have been smarter to use strjoin.
    for i=1:length(tdms_data)
        for j=1:length(units)
            tdms_data(i).id = [tdms_data(i).id, ...
                               num2str(tdms_data(i).(measurements{j})), ...
                               units{j}];
            if j ~= length(units)
                tdms_data(i).id = [tdms_data(i).id,' - '];
            end
        end
        tdms_data(i).id = [tdms_data(i).id, ' - ', num2str(i)];
    end
    
    %% read in data
    for i=1:length(tdms_file_names)
        % Store Signal Information ----------------------------------------
        
        % Prints Information as it is being read in
        fprintf('Reading In: File-Number = %i \t file_name = %s\n',i,tdms_file_names{i})
        
        % STORE: uses a package found online for reading tdms files, to
        % store all of the data from the tdms file into a struct
        RUSdata = TDMS_getStruct([path_to_files,tdms_file_names{i}]);

        tdms_data(i).signal_x        = RUSdata.p.Signal_X.data;
        tdms_data(i).signal_y        = RUSdata.p.Signal_Y.data;
        tdms_data(i).frequency       = RUSdata.p.Frequency.data;

    end
    
    [tdms_data.plot_info] = deal(Get_Plot_Struct());

    % * Assign titles to plots
    %   - because plot titles need to be dynamically determined, I have
    %     waited until I have read in all of the data to store this value
    for i=1:length(tdms_data)
       tdms_data(i).plot_info.title = tdms_data(i).plot_info.get_title(tdms_data(i)); 
    end

    
end


