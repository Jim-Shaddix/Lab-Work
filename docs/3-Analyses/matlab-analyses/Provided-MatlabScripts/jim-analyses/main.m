
% Setting Paths:
addpath(genpath('StructBrowser')); % For Lookung At Structs more easily
addpath(genpath('scrollsubplot')); % For scrollable subplots
addpath(genpath('Matlab_readTDMS_package')); % For Reading tdms

% Variables to Initialize
path_to_tdms_files = ['~/Documents/Pro/Git/Repos/Lab-Work/docs/'...
                      '2-Files_To_Analyze/31 May 18 TaV2/'];

% Read in tdms File Data:
% NOTE: (1 file) -> (takes 0.25s)
[tdms_data,RUSdata] = RUSload(path_to_tdms_files);
clear path_to_tdms_files




%% Make Subplots

% initializing the plot canvas
fig = figure;
fig.Units = 'centimeters';
fig.Position(3:4) = [45  30];

% the scroll sub-plot works by creating a page with figures
% - based on columns and rows
rows = 4;
cols = 4;

for i = 1:length(tdms_data)
    
    scrollsubplot(rows,cols,i);
    
    plot(tdms_data(i).frequency,tdms_data(i).signal_x)
    hold on
    plot(tdms_data(i).frequency,tdms_data(i).signal_y)
    
    findpeaks(tdms_data(i).signal_x)
    findpeaks(tdms_data(i).signal_y)
    hold off
    
    
    title(['Subplot: ',int2str(i)])
    
end
%% Fit Function




disp('done')