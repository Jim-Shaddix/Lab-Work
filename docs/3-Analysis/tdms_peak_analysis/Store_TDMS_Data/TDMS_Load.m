function tdms_data=TDMS_Load(path_to_files)
% 1. Reads directory (path_to_files) for filenames and 
%    loads all TDMS files into Cell Array. 
% 2. Extracts Temperature from filename string by finding character 'K'. 

    % Store File Information ----------------------------------------------

    % UPDATE path_to_files
    % - this is done to accomodate the TDMS_getStruct function, that
    %   requires that the directory passed in ends with /.
    path_to_files = char(path_to_files);
    if path_to_files(end) ~= '/'
        path_to_files(end+1) = '/';
    end

    % GET: structure that descibes the provided path
    dir_struct      = dir(path_to_files);
    
    % CHECK: if a faulty directory was passed in
    % refferences to the current and previous directory will always be
    % found, so if no files or directiories are found, than a faulty path
    % was used.
    if isempty(dir_struct)
        error(['The directory passed in could not be reached', ...
               ' from current path.']);
    end
    
    % GET: file names ending with .tdms
    file_names      = string({dir_struct.name});
    tdms_file_names = file_names(endsWith(file_names,'.tdms'));
    
    % CHECK: that tdms files were found
    if isempty(tdms_file_names)
        fprintf('No tdms Files Were Found in the directory passed in:\n')
        fprintf([char(path_to_files),'\n\n'])
        fprintf('These are the files/directories that were found:\n');
        disp(file_names');
        error('Failed to find tmds files in the provided path !!!');
    end
    
    % Creates the struct template that I will be storing all 
    % of the info from the tdms files into.
    tdms_data = Get_RUS_Data_Struct(length(tdms_file_names));
    
    % store all of the tdms file names into our struct
    cell_tdms_file_names =  num2cell(tdms_file_names);
    [tdms_data.file_name] = cell_tdms_file_names{:};
    
    for i=1:length(tdms_file_names)
        % Store Signal Information ----------------------------------------
        
        % Prints Information as it is being read in
        fprintf('Reading In: File-Number = %i \t file_name = %s\n',i,tdms_file_names{i})
        
        % STORE: uses a package found online for reading tdms files, to
        % store all of the data from the tdms file into a struct
        RUSdata = TDMS_getStruct([path_to_files,tdms_file_names{i}]);

        % GET/STORE: Temperature From File Name Using Regex
        pattern = '\d{0,3}\.?\d+K';
        temperature_str = erase(regexp(tdms_file_names{i}, pattern, 'match'), 'K');
        tdms_data(i).temperature     = str2double(temperature_str);

        % STORE: Plot Data
        % Eliminates leading 0 in data set if needed.
        % In particular, I through out the first 4 values if a zero was
        % found, just in case something was going wrong.
        if RUSdata.p.Signal_X.data(1) == 0 || RUSdata.p.Signal_Y.data(1) == 0
            tdms_data(i).signal_x        = RUSdata.p.Signal_X.data(5:length(RUSdata.p.Signal_X.data));
            tdms_data(i).signal_y        = RUSdata.p.Signal_Y.data(5:length(RUSdata.p.Signal_Y.data));
            tdms_data(i).frequency       = RUSdata.p.Frequency.data(5:length(RUSdata.p.Frequency.data));
        else
            tdms_data(i).signal_x        = RUSdata.p.Signal_X.data;
            tdms_data(i).signal_y        = RUSdata.p.Signal_Y.data;
            tdms_data(i).frequency       = RUSdata.p.Frequency.data;
        end

        % CHECK: if peaks were found in the tdms file
        if ~isfield(RUSdata,'fit')
            continue
        end

        % Store Peak Information ------------------------------------------
        
        % GET: peak field_names -> [cell-array] field_names
        peak_struct = RUSdata.fit;
        field_names = fieldnames(peak_struct);
        
        unique_fields = {'Peak','F','Width','Amplitude','Phase','Xbg','Ybg'};
        struct_fields = {'Frequencies','F','Width','Amplitude','Phase','Xbg','Ybg'};
        map = containers.Map(unique_fields,ones(1,length(unique_fields)));

        for j = 1:length(field_names)
            for k = 1:length(unique_fields)
                if contains(field_names{j}, unique_fields(k))
                    tdms_data(i).peaks_mag_given(map(unique_fields{k})).(struct_fields{k}) = ...
                        peak_struct.(field_names{j}).data;
                    map(unique_fields{k}) = map(unique_fields{k}) + 1;
                end
            end
        end

    end
end

