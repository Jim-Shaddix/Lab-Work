




a=0;




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
