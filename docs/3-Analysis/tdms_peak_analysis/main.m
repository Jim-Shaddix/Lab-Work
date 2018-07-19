%% Initialization
% These settings initialize the program, and our subject to change.
clear
clc

% SET: paths
addpath(genpath('Store_TDMS_Data')); % for reading tdms files
addpath(genpath('Fits'));            % for fitting Lorentzian to data
addpath(genpath('Plots'));           % for plotting data
addpath(genpath('Set_Peaks'));       % for setting peak values
addpath(genpath('Data_Manipulation')); % for reading tdms files

% SET: file paths
fp1 = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/2-Files_To_Analyze/' ... 
       '31 May 18 TaV2/'];
fp2 = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/2-Files_To_Analyze/' ... 
       '15 May 18 BalrO3/'];
fp3 = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/2-Files_To_Analyze/' ... 
       'CoNb2O6 061218/'];
fp4 = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/2-Files_To_Analyze/' ... 
       'More CoNb206/'];
path_to_tdms_files = fp1;

% findpeak options
find_peak_opts.MinPeakDistance   = 100;
find_peak_opts.MinPeakProminence = 0.0001;

% width of data to perform peak fit on
peak_width = 0.01*10^6;

clear fp1 fp2 fp3 fp4
%% Read In Data

% STORE: data from tdms files
tdms_data = TDMS_Load(path_to_tdms_files);
disp('Finished: Reading Data')

%% Process Signal
%for i = 1:length(tdms_data)
%   tdms_data(i).signal_x = Process_Plot_Data(tdms_data(i).signal_x);
%   tdms_data(i).signal_y = Process_Plot_Data(tdms_data(i).signal_y);
%end
%disp('Finished: Proccessing The Signal')

%% Set Peaks

% mag_given_peaks
a = Get_Given_Peaks({tdms_data.frequency}, ...
                    {tdms_data.signal_x}, ...
                    {tdms_data.signal_y}, ...
                    {tdms_data.mag_given_peaks});
[tdms_data.mag_given_peaks] =  a{:};

param = { ... 
          {tdms_data.frequency}, ...
          {tdms_data.signal_x},  ...
          {tdms_data.signal_y},  ...
          find_peak_opts };

% mag_set_peaks
peak_data = Get_Mag_Peaks(param{:});
[tdms_data.mag_set_peaks] = peak_data{:};

% raw_set_peaks
peak_data = Get_Raw_Peaks(param{:});
[tdms_data.raw_set_peaks] = peak_data{:};

clear cell_frequency cell_signal_x cell_signal_y
disp("Finished: Setting Peaks")
clear param find_peak_opts peak_data

%% Perform Fit
perform_fit = false;
if perform_fit == true
    
    peaks = "mag_given_peaks";
    %peaks = "mag_set_peaks";
    %peaks = "mag_given_peaks";

    % PERFORM: fit
    fit_data = Lorentz_Fit_File(           ...
                    {tdms_data.frequency}, ...
                    {tdms_data.signal_x},  ...
                    {tdms_data.signal_y},  ...
                    {tdms_data.(peaks)},   ...
                    peak_width);

    % SET: fit_data
    for i = 1:length(fit_data)
        for j = 1:length(tdms_data(i).(peaks))
            [tdms_data(i).(peaks)(j).fit] = fit_data{i}(j);
        end
    end

    disp("Finished: Performing Fit")
    clear peaks perform_fit 
    
end

%% Plot

% PLOT: Raw Data
%MakePlots(tdms_data,true,["raw","raw_given_fit","raw_given_peaks"])
MakePlots(tdms_data,true,["raw","raw_given_peaks"])

% PLOT: Set Peaks
%MakePlots(tdms_data(1:5),true,["raw","raw_set_peaks"])

% PLOT: Quadature Data
%MakePlots(tdms_data,true,["mag","mag_set_peaks"])

disp("Finished: Plotting")
%% more stuff
%Plot_Width(tdms_data)
%Plot_Single_Width(tdms_data)

%% Clean Up Variables
clear path_to_tdms_files i j l fit_x fit_real fit_imag Est lorentz_param;
disp(" --- Finished ---")
