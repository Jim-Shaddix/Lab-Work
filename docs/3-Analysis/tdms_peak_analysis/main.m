%% Initialization
% These settings initialize the program, and our subject to change.
clear
clc

% SET: paths
addpath(genpath('Store_TDMS_Data')); % for reading tdms files
addpath(genpath('Fits'));            % for fitting Lorentzian to data
addpath(genpath('Plots'));           % for plotting data
addpath(genpath('Set_Peaks'));       % for setting peak values

% SET: variables
f1 = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/2-Files_To_Analyze/' ... 
       '31 May 18 TaV2/'];
f2 = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/2-Files_To_Analyze/' ... 
       '15 May 18 BalrO3/'];
f3 = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/2-Files_To_Analyze/' ... 
       'CoNb2O6 061218/'];
f4 = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/2-Files_To_Analyze/' ... 
       'More CoNb206/'];

path_to_tdms_files = f3;

% width of data to perform peak fit on               
peak_width = 0.01*10^6;

clear f1 f2 f3 f4
%% Read In Data

% STORE: data from tdms files
tdms_data = Store_TDMS_Data(path_to_tdms_files);
disp('Finished Reading Data')

%% Perform Fit

% PERFORM: fit on each peak, in each file.
for i = 1:length(tdms_data)
    
    l = tdms_data(i);
    
    % CHECK: if any peaks were found
    if isempty(l.mag_given_peaks)
        continue
    end
    
    % PERFORM: fit
    [Est, fit_x, fit_real, fit_imag] = Lorentz_Fit(l.frequency, ...
                                              l.signal_x, l.signal_y, ...
                                              [l.mag_given_peaks.Frequencies], ...
                                              peak_width);  

   % STORE: features associated with each fit
   for j = 1:length(l.mag_given_peaks)  
       
       % STORE: fit coordinates
       tdms_data(i).mag_given_peaks(j).fit.frequencies = cell2mat(fit_x(j));
       tdms_data(i).mag_given_peaks(j).fit.signal_x    = cell2mat(fit_real(j));
       tdms_data(i).mag_given_peaks(j).fit.signal_y    = cell2mat(fit_imag(j));
       
       % STORE: fit parameters
       % [A, theta, gamma, f_0, offset]
       lorentz_param = cell2mat(Est(j));
       tdms_data(i).mag_given_peaks(j).fit.A      = lorentz_param(1);
       tdms_data(i).mag_given_peaks(j).fit.theta  = lorentz_param(2);
       tdms_data(i).mag_given_peaks(j).fit.gamma  = lorentz_param(3);
       tdms_data(i).mag_given_peaks(j).fit.f_0    = lorentz_param(4);
       tdms_data(i).mag_given_peaks(j).fit.offset = lorentz_param(5);
       
   end
end

% SET: peaks picked from raw data
tdms_data = Raw_Set_Peaks(tdms_data);
disp("Finished Performing Fit")

%% Plot

% PLOT: Raw Data
%MakePlots(tdms_data,true,["raw","raw_fit","raw_given_peaks"])
%MakePlots(tdms_data(1),false,["raw","raw_fit","mag"])

% PLOT: Set Peaks
%MakePlots(tdms_data(1),true,["raw","raw_set_peaks"])

% PLOT: Quadature Data
%MakePlots(tdms_data(1:5),true,["mag","mag_given_peaks"])

%% Clean Up Variables
clear path_to_tdms_files i j l fit_x fit_real fit_imag Est lorentz_param;
disp(" --- Finished ---")
