%% Initialization
% These settings initialize the program, and our subject to change.
clear 
clc

% setting paths
addpath(genpath('scrollsubplot'));   % for scrollable subplots
addpath(genpath('Store_TDMS_Data')); % for reading tdms files
addpath(genpath('Fits'));            % for fitting Lorentzian to data
addpath(genpath('Plots'));           % for plotting data
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
    
    % perform fit
    l = tdms_data(i);
    [Est, fit_x, fit_real, fit_imag] = Lorentz_Fit(l.frequency, ...
                                              l.signal_x, l.signal_y, ...
                                              [l.mag_given_peaks.Frequencies], ...
                                              peak_width);  

   % store features associated with each fit
   for j = 1:length(l.mag_given_peaks)  
       
       % store fit coordinates
       tdms_data(i).mag_given_peaks(j).fit.frequencies = cell2mat(fit_x(j));
       tdms_data(i).mag_given_peaks(j).fit.signal_x    = cell2mat(fit_real(j));
       tdms_data(i).mag_given_peaks(j).fit.signal_y    = cell2mat(fit_imag(j));
       
       % store fit parameters
       % [A, theta, gamma, f_0, offset]
       lorentz_param = cell2mat(Est(j));
       tdms_data(i).mag_given_peaks(j).fit.A      = lorentz_param(1);
       tdms_data(i).mag_given_peaks(j).fit.theta  = lorentz_param(2);
       tdms_data(i).mag_given_peaks(j).fit.gamma  = lorentz_param(3);
       tdms_data(i).mag_given_peaks(j).fit.f_0    = lorentz_param(4);
       tdms_data(i).mag_given_peaks(j).fit.offset = lorentz_param(5);
       
   end
end

% sets peaks picked from raw data
tdms_data = Raw_Set_Peaks(tdms_data);
disp("Finished Performing Fit")

%% Plot

% Plot Raw Data
MakePlots(tdms_data,true,["raw","raw_fit","raw_given_peaks"])
%MakePlots(tdms_data(1),false,["raw","raw_fit","mag"])

% Plot Set Peaks
%MakePlots(tdms_data(1),true,["raw","raw_set_peaks"])

% Plot Quadature Data
%MakePlots(tdms_data([1:5,20]),true,["mag","mag_given_peaks"])

%% Clean Up Variables
clear path_to_tdms_files i j l fit_x fit_real fit_imag Est lorentz_param;
disp(" --- Finished ---")
