%% Initialization
% These settings initialize the program, and our subject to change.

% setting paths
addpath(genpath('scrollsubplot'));   % for scrollable subplots
addpath(genpath('Store_TDMS_Data')); % for reading tdms files
addpath(genpath('Fits'));            % for fitting Lorentzian to data
addpath(genpath('Set_Peaks'));       % for setting peak values

% variables to initialize
path_to_tdms_files = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/'...
                      '2-Files_To_Analyze/31 May 18 TaV2/']; 

% width of data to perform peak fit on                
peak_width = 0.01*10^6; 

%% Read In Data

% storing data from tdms files
tdms_data = Store_TDMS_Data(path_to_tdms_files);
disp('Finished Reading Data')

%% Perform Fit

% perform fit on each peak, in each file.
for i = 1:length(tdms_data)
    l = tdms_data(i);
    [Est, fit_x, fit_real, fit_imag] = lorentz_fit(l.frequency, ...
                                              l.signal_x, l.signal_y, ...
                                              [l.given_peaks.Frequencies], ...
                                              peak_width);  

   % store resulting fit coordinates associated with each peak                                       
   for j = 1:length(l.given_peaks)               
       tdms_data(i).given_peaks(j).fit.frequencies = cell2mat(fit_x(j));
       tdms_data(i).given_peaks(j).fit.signal_x    = cell2mat(fit_real(j));
       tdms_data(i).given_peaks(j).fit.signal_y    = cell2mat(fit_imag(j));
       
       % x = [A, theta, gamma, f_0, offset]
       %tdms_data(i).given_peaks(j).fit.A = Est(j);
   end
   
end

%% Plot 

% sets peaks picked from raw data
tdms_data = Set_Raw_Peaks(tdms_data);

% Plot Raw Data
%MakePlots(tdms_data,true,["raw","raw_fit"])
MakePlots(tdms_data(22),false,["raw","raw_fit"])

% Plot Set Peaks
%MakePlots(tdms_data(1),true,["raw","raw_set_peaks"])

% Plot Quadature Data
% MakePlots(tdms_data([1:5,20]),false,["quad","quad_given_peaks"])

%% Clean Up Variables
clear path_to_tdms_files i j l fit_x fit_real fit_imag;