%% Store Crap
file1 = 'C:\Users\Cepheid\Documents\GitHub\rus-probe\docs\2-Files_To_Analyze\31 May 18 TaV2\';
% file2 = 
tdms_data = Store_TDMS_Data(file1);

peak_width = 0.01*10^6;

%% Fitting stuff
perform_fit = true;
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

%% Plot peaks
hold on;

for num = 1:5:41
    x = tdms_data(num).signal_x;
    y = tdms_data(num).signal_y;
    amp = sqrt(x.^2 + y.^2);
    freq = tdms_data(num).frequency./1000;

    plot(freq, amp)

    name = tdms_data(num).file_name(14:length(tdms_data(num).file_name)-5);
    l = legend(name);
    set(l,'Interpreter', 'none');
end
%% Plot gamma
temp = [tdms_data.temperature];
gamma = [];
peak = [1,1,1,2,3,1,2,2,
% for ii = 1:length(tdms_data)
%     for jj = 1:length(tdms_data(ii).mag_given_peaks)
%    
%     end
%     gamma(end+1) = tdms_data(ii).mag_given_peaks(1).fit.gamma;
% end

hold on;
plot(temp, gamma, 'bo')

name = tdms_data(i).file_name(14:length(tdms_data(i).file_name)-5);
l = legend(name);
set(l,'Interpreter', 'none');

%% Gamma Shite

