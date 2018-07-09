function Plot_File(td, plot_params)
% This function plots the data from a single tdms file, and uses
% plot_params to determine what information to plot.
%
% PARAMETERS:
% 1. plot_params = [String Array]
%       - each string specified in this array is used as a flag, that
%         determines what data will be plotted
%         Options: [raw, raw_fit, raw_mag_given_peaks, raw_set_peaks,
%                   quad, quad_mag_given_peaks]

        hold on
        
        % Raw Fit
        if ismember('raw_fit',plot_params) == 1
            for j = 1:length(td.mag_given_peaks)
                % real data
                plot(td.mag_given_peaks(j).fit.frequencies,  ...
                     td.mag_given_peaks(j).fit.signal_x,     ...
                     'y', 'LineWidth',4)
                % imag data
                plot(td.mag_given_peaks(j).fit.frequencies,  ...
                     td.mag_given_peaks(j).fit.signal_y,     ...
                     'c', 'LineWidth',4)                 
            end
        end
        
        % Raw Signal:
        if ismember('raw',plot_params) == 1
            plot(td.frequency, td.signal_x,'r-')
            plot(td.frequency, td.signal_y,'b-')
        end
        
        % Quad Signal
        if ismember('mag',plot_params) == 1
            plot(td.frequency, Magnitude(td.signal_x, td.signal_y),'g')
        end
        
        % Raw Set Peaks:
        if ismember('raw_set_peaks',plot_params) == 1
            for j = 1:length(td.raw_set_peaks)
                sp = td.raw_set_peaks(j);
                plot(sp.x_frequencies, sp.x_signal,'r*')
                plot(sp.y_frequencies, sp.y_signal,'b*')
            end
        end
        
        % Raw Given Peaks:
        if ismember('raw_given_peaks',plot_params) == 1
            for j = 1:length(td.mag_given_peaks)
                % real data
                plot(td.mag_given_peaks(j).Frequencies,        ...
                     td.mag_given_peaks(j).signal_x,           ...
                     'r*')
                % imag data
                plot(td.mag_given_peaks(j).Frequencies,        ...
                     td.mag_given_peaks(j).signal_y,           ...
                     'b*')
            end
        end
        
        % Magnitude Given Peaks:
        if ismember('mag_given_peaks',plot_params) == 1
            for j = 1:length(td.mag_given_peaks)
                plot(td.mag_given_peaks(j).Frequencies,        ...
                     td.mag_given_peaks(j).mag,                ...
                     'g*')
            end
        end
         
        % Magnitude Calculated Peaks:
        if ismember('mag_set_peaks',plot_params) == 1  
            for j = 1:length(td.mag_set_peaks)
                plot(td.mag_set_peaks(j).frequencies,        ...
                     td.mag_set_peaks(j).signal,                ...
                     'g*')
            end
        end

end