%% Load TMDS
file1 = 'C:\Users\Cepheid\Documents\GitHub\rus-probe\docs\2-Files_To_Analyze\31 May 18 TaV2\';
file2 = 'C:\Users\Cepheid\Documents\GitHub\rus-probe\docs\2-Files_To_Analyze\CoNb2O6 061218\';
file3 = 'C:\Users\Cepheid\Documents\GitHub\rus-probe\docs\2-Files_To_Analyze\More CoNb2O6\';
file4 = 'C:\Users\Cepheid\Documents\GitHub\rus-probe\docs\2-Files_To_Analyze\Cobalt_ACaxis_500-4000_repeating\';

tdms_data = TDMS_Load(file2);

%% Clean up data
for i = 1:length(tdms_data)
    % Uses weighted gaussian moving average to smooth noisy data
    smoothed_x = Smooth(tdms_data(i).signal_x);
    smoothed_y = Smooth(tdms_data(i).signal_y);
    % Removes linear trends in data
    tdms_data(i).cleaned_x = Detrend(smoothed_x);
    tdms_data(i).cleaned_y = Detrend(smoothed_y);
end
clear smoothed_x; clear smoothed_y;

%% Fitting stuff
peak_width = 0.01*10^6;
perform_fit = true;

if perform_fit == true
    
    peaks = "mag_given_peaks";
    %peaks = "mag_set_peaks";
    %peaks = "mag_given_peaks";

    % PERFORM: fit
    fit_data = Lorentz_Fit_File(           ...
                    {tdms_data.frequency}, ...
                    {tdms_data.cleaned_x},  ...
                    {tdms_data.cleaned_y},  ...
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

%% Convolution Testing
% Smooth then detrend, or detrend then smooth?
for i = 4
    x = tdms_data(i).signal_x;
    figure(i);
    hold on;
    
    smooth_x = Smooth(x);
    smooth_detrend_x = Detrend(smooth_x);
    
    detrend_x = Detrend(x);
    detrend_smooth_x = Smooth(detrend_x);
    
    plot(tdms_data(i).frequency, detrend_smooth_x, 'r-')
    plot(tdms_data(i).frequency, smooth_detrend_x, 'b-')
end


