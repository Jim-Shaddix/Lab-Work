clear
clc

%% Initialization
% These settings initialize the program, and our subject to change.

% SET: paths
addpath(genpath('Store_TDMS_Data')); % for reading tdms files
addpath(genpath('Fits'));            % for fitting Lorentzian to data
addpath(genpath('Plots'));           % for plotting data
addpath(genpath('Set_Peaks'));       % for setting peak values
addpath(genpath('Data_Manipulation')); % for reading tdms files
addpath(genpath('Peak_Analysis')); % for reading tdms files

% SET: file paths
dir = '../../2-Files_To_Analyze/';

f1 = '31 May 18 TaV2/';
f2 = '15 May 18 BalrO3/';
f3 = 'CoNb2O6 061218/';
f4 = 'More CoNb206/';
   
path_to_tdms_files = [dir,f1];
clear f1 f2 f3 f4 dir

%% Read In Data

% STORE: data from tdms files
tdms_data = TDMS_Load(path_to_tdms_files);
fprintf(' --- Finished: Reading Data ---\n\n')

%% Set Struct
%tdms_data = tdms_data([14,25]);

% GET: plot info
plot_info = Get_Plot_Struct();

% MODIFY: plot info
plot_info.preprocess = {@Process_Plot_Data};
plot_info.raw  = 1;
plot_info.mag  = 1;
%plot_info.plot_width = 1;
plot_info.peaks_raw_given = [1,1];
plot_info.peaks_mag_given = [1,1];
%plot_info.peaks_raw_set   = [1,1];
%plot_info.peaks_mag_set   = [1,1];

% SET: plot info
[tdms_data.plot_info] = deal(plot_info);

clear plot_info

%% Process The Data
tdms_data = Process_Data(tdms_data);
fprintf(" --- Finished processing data --- \n\n")

%% Plot

%tdms_data(1) = Plot_Stuff(tdms_data(1),true);
tdms_data = Sub_Plots(tdms_data);

disp(" --- Finished: Plotting ---")

%% Peak Analysis
% get peaks/temp near refference frequency
freq_ref = 8.5 *10^5;
peak_str = 'peaks_mag_given';

% GET: peaks of interest, and their associated temperatures.
[peaks_of_interest,peak_temps] = Get_Peaks_Near_Freq(tdms_data,peak_str,freq_ref);
%Analyze_Single_Freq(gca, peaks_of_interest, peak_temps, 'f_0', 'gamma')

Peak_Analyzer(tdms_data,peaks_of_interest, peak_temps)

clear freq_ref peak_str peaks_of_interest peak_temps

%% FINISHED
disp("[Finished Script]")
