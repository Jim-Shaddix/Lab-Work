%% Store Crap
tdms_data = Store_TDMS_Data('C:\Users\Cepheid\Documents\GitHub\rus-probe\docs\2-Files_To_Analyze\28June18 960 resonance testing\');

%% Call Plots
i = 17;
x = tdms_data(i).signal_x;
y = tdms_data(i).signal_y;
freq = tdms_data(i).frequency./1000;

hold on;
plot(freq, x)
plot(freq, y)

name = tdms_data(i).file_name(14:length(tdms_data(i).file_name)-5);
l = legend(name);
set(l,'Interpreter', 'none');
