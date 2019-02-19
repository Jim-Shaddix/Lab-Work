function tdms_data = Process_Data(tdms_data, plot_info_struct)
% this function sets all of the fields specified by plot_info
% 
% PARAMETERS
% * tdms_data: [struct array] all of the data that will be proccessed
% * plot_info_struct: [struct array] allows you to pass in a sepperate plot info struct, if you don't want
%                     to use the one stored in tdms_data. The length of 
%                     plot_info_struct must match the length of tdms_data.
    
    if nargin < 2
        plot_info_struct = [tdms_data.plot_info];
    end

    % SET: fit_data in peaks & return peaks
    function peaks = Set_Fits(peaks, fit_options, fit_width_multiplier, hard_coded_width, fit_width, given_bool)
        peaks = Lorentz_Fit_File(       ...
                        {frequency},    ...
                        {signal_x},     ...
                        {signal_y},     ...
                        peaks,          ...
                        fit_options,    ...
                        fit_width_multiplier, ...
                        hard_coded_width,     ... 
                        fit_width,            ...
                        given_bool); 
    end

    for i = 1:length(tdms_data)
        %% Shortcuts / Preprocess Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % easier access to data
        td        = tdms_data(i);
        info      = plot_info_struct(i);
        frequency = td.frequency;
        signal_x  = td.signal_x;
        signal_y  = td.signal_y;

        % preprocess the data
        for j = 1:length(info.preprocess)
            func = info.preprocess{j};
            signal_x = func(signal_x);
            signal_y = func(signal_y);
        end
        
        %% Get Peaks %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        param = {{frequency}, ...
                 {signal_x},  ...
                 {signal_y}};

        % mag_given_peaks
        if sum(info.peaks_raw_given) >= 1 || sum(info.peaks_mag_given) >= 1
            given_peaks = Get_Given_Peaks(param{:}, {td.peaks_mag_given});
        end

        % mag_set_peaks
        if sum(info.peaks_raw_set) >= 1 || sum(info.peaks_mag_set) >= 1
            set_peaks = Get_Set_Peaks(param{:}, {info.peak_options});
        end

        %% Get FIT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % mag_given_peaks
        if info.peaks_raw_given(2) || info.peaks_mag_given(2)
            given_peaks = Set_Fits(given_peaks, {info.fit_options}, ...
                info.fit_width_multiplier, info.hard_coded_width, ...
                info.fit_width, 1); 
        end
        
        % mag_set_peaks
        if info.peaks_raw_set(2) || info.peaks_mag_set(2)
            set_peaks = Set_Fits(set_peaks, {info.fit_options}, ...
                info.fit_width_multiplier, info.hard_coded_width, ...
                info.fit_width, 0);
        end
        
        %% SET DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if sum(info.peaks_raw_given) >= 1 || sum(info.peaks_mag_given) >= 1
            [tdms_data(i).peaks_mag_given] = given_peaks{:};
        end
        
        if sum(info.peaks_raw_set) >= 1 || sum(info.peaks_mag_set) >= 1
            [tdms_data(i).peaks_mag_set]   = set_peaks{:};
        end

        disp(['Finished Processing File ',num2str(i),' of ',num2str(length(tdms_data))])
    end % loop over tdms_data
end