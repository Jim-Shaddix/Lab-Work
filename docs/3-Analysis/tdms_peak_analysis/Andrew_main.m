%% Store Crap
file1 = 'C:\Users\Cepheid\Documents\GitHub\rus-probe\docs\2-Files_To_Analyze\31 May 18 TaV2\';
% file2 = 
tdms_data = Store_TDMS_Data(file1);

%% Fitting stuff
tdms_data = 

%% Call Plots
i = 7;
x = tdms_data(i).signal_x;
y = tdms_data(i).signal_y;
freq = tdms_data(i).frequency./1000;

hold on;
plot(freq, x)
plot(freq, y)

name = tdms_data(i).file_name(14:length(tdms_data(i).file_name)-5);
l = legend(name);
set(l,'Interpreter', 'none');
