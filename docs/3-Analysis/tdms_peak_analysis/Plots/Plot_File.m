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
        
        % Raw Set Peaks:
        if ismember('raw_set_peaks',plot_params) == 1
            for j = 1:length(td.raw_set_peaks)
                sp = td.raw_set_peaks(j);
                %disp(sp.x_frequencies)
                plot(sp.x_frequencies, sp.x_signal,'r*')
                plot(sp.y_frequencies, sp.y_signal,'b*')
                %plot(td.ypeak_freq, td.ypeak,'b*')
            end
        end
        
        % Raw Given Peaks:
        if ismember('raw_given_peaks',plot_params) == 1
            for j = 1:length(td.mag_given_peaks)
                % real data
                plot(td.mag_given_peaks(j).Frequencies,        ...
                     td.signal_x(td.mag_given_peaks(j).index), ...
                     'r*')
                % imag data
                plot(td.mag_given_peaks(j).Frequencies,        ...
                     td.signal_y(td.mag_given_peaks(j).index), ...
                     'b*')
            end
        end

        % Quad Signal
        if ismember('mag',plot_params) == 1
            plot(td.frequency, td.magnitude,'g')
        end
        
        % Quad Given Peaks:
        if ismember('mag_given_peaks',plot_params) == 1
            for j = 1:length(td.mag_given_peaks)
                % real data
                plot(td.mag_given_peaks(j).Frequencies,        ...
                     td.magnitude(td.mag_given_peaks(j).index), ...
                     'g*')
            end
        end
         
        % Quad Calculated Peaks:
%         if ismember('mag_set_peaks',plot_params) == 1
%             
%             % real data
%             plot(td.xpeak_freq, td.xpeak, 'r*')
%             
%             % imag data
%             plot(td.ypeak_freq, td.ypeak, 'b*')
%         end

end