%% Initialization
% These settings are all subject to change.

% setting paths
addpath(genpath('scrollsubplot'));   % for scrollable subplots
addpath(genpath('Store_TDMS_Data')); % for reading tdms files
addpath(genpath('Fits'));            % for fitting Lorentzian to data

% variables to initialize
path_to_tdms_files = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/'...
                      '2-Files_To_Analyze/31 May 18 TaV2/']; 
                  
% width of data to perform peak fit on                
peak_width = 0.01*10^6; 

%% Read In Data

% storing data from tdms files
tdms_data = Store_TDMS_Data(path_to_tdms_files);
clear path_to_tdms_files

%% Plot Raw Data

tdms_data = set_peaks(tdms_data); % sets peaks picked from data
%MakePlots(tdms_data,'calc_peaks')

%% Perform Fit

% perform fit on each peak, in each file.
for i = 1:length(tdms_data)
    l = tdms_data(i);
    [fit_x, fit_real, fit_imag] = lorentz_fit(l.frequency, ...
                                              l.signal_x, l.signal_y, ...
                                              [l.given_peaks.Frequencies], ...
                                              peak_width);               
   % store results fit coordinates
   % associated with each peak                                       
   for j = 1:length(l.given_peaks)               
       tdms_data(i).given_peaks(j).fit_x    = cell2mat(fit_x(j));
       tdms_data(i).given_peaks(j).fit_real = cell2mat(fit_real(j));
       tdms_data(i).given_peaks(j).fit_imag = cell2mat(fit_imag(j));
   end
   
end

%% Plot Raw Data
MakePlots(tdms_data,true,["raw","raw_fit","raw_given_peaks"])

%% Plot Quadature Data
MakePlots(tdms_data(1:5),false,["quad","quad_given_peaks"])


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

