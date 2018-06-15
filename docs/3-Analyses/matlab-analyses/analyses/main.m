                  %% Initialization
% These Settings Are All Subject to Change.

% Setting Paths
addpath(genpath('scrollsubplot'));   % For Scrollable Subplots
addpath(genpath('Store_TDMS_Data')); % For Reading tdms Files

% Variables to Initialize
path_to_tdms_files = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/'...
                      '2-Files_To_Analyze/31 May 18 TaV2/'];           

                  %% Read In Data
% Reading, and storing data from tdms files, based on the directory
% specified by path_to_tdms_files variable.
% NOTE: (1 file) -> (takes 0.25s)
tdms_data = Store_TDMS_Data(path_to_tdms_files);
clear path_to_tdms_files

                %% Plots
tdms_data = set_peaks(tdms_data);
MakePlots(tdms_data)

                %% Fit Function
disp('done')

                %% Functions
                
% sets the peaks to be plotted: using peakfind
% - this function currently picks to many peaks
function data = set_peaks(tdms_data)
    for i = 1:length(tdms_data)
        [tdms_data(i).xpeak,tdms_data(i).xpeak_freq] = ...
            findpeaks(tdms_data(i).signal_x,tdms_data(i).frequency); 
        [tdms_data(i).ypeak,tdms_data(i).ypeak_freq] = ...
            findpeaks(tdms_data(i).signal_y,tdms_data(i).frequency); 
    data = tdms_data;
    end
end

% sets the peaks to be plotted
function data = set_lorentzian_peaks(tdms_data)
    data = 0;
end