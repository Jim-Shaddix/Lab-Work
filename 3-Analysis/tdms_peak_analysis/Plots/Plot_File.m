function Plot_File(ax, tdms_data, plot_info)
% This function plots the data from a single tdms file, and uses
% plot_struct to determine what information to plot.
% - I should note that the order in which the plots are made is important
%   because this determines the stacking order of the plots.

    hold(ax, 'on')
    
    % easier access to data
    if nargin < 3
        info = tdms_data.plot_info;
    else
        info = plot_info;
    end
    
    frequency = tdms_data.frequency;
    signal_x  = tdms_data.signal_x;
    signal_y  = tdms_data.signal_y;
    
    legend_entries = {};
    
    %% FITS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % PLOT FIT: on raw data
    function Plot_Fit_Raw(bool,peak_struct)
        if bool == 1 && ~isempty(tdms_data.(peak_struct))
            all_peaks_to_fit = [tdms_data.(peak_struct)];
            all_fits         = [all_peaks_to_fit.fit];

            for z = 1:length(all_fits)
                
                x_param = info.fit_x_param;
                y_param = info.fit_y_param;
                
                if z ~= 1
                    x_param = [x_param,{'HandleVisibility','off'}];
                    y_param = [y_param,{'HandleVisibility','off'}];
                end
                
                plot(ax, ...
                     all_fits(z).frequencies,  ...
                     all_fits(z).signal_x,     ...
                     x_param{:})

                plot(ax, ...
                     all_fits(z).frequencies,  ...
                     all_fits(z).signal_y,     ...
                     y_param{:})
                     %info.fit_y_param{:})
            end
            
            % add legend entries
            legend_entries = [legend_entries, ...
                              info.x_fit_label, ...
                              info.y_fit_label];
            
        end
    end 

    % PLOT FIT: on mag data
    function Plot_Fit_Mag(bool,peak_struct)
        if bool == 1 && ~isempty(tdms_data.(peak_struct))
            
            all_peaks_to_fit = [tdms_data.(peak_struct)];
            all_fits         = [all_peaks_to_fit.fit];
            
            for z = 1:length(all_fits)
                
                mag_param = info.fit_mag_param;
                
                if z ~= 1
                    mag_param = [mag_param,{'HandleVisibility','off'}];
                end
                
                plot(ax, ...
                     [all_fits(z).frequencies],  ...
                     Magnitude(all_fits(z).signal_x,all_fits(z).signal_y), ...
                     mag_param{:})
            end
            legend_entries = [legend_entries,info.mag_fit_label];
        end
    end 

    % (FITS) Peaks_Mag_Given 
    peak_struct = "peaks_mag_given";
    Plot_Fit_Raw(info.peaks_raw_given(2),peak_struct)
    Plot_Fit_Mag(info.peaks_mag_given(2),peak_struct)

    % (FITS) Peaks_Mag_Set
    peak_struct = "peaks_mag_set";
    Plot_Fit_Raw(info.peaks_raw_set(2),peak_struct)
    Plot_Fit_Mag(info.peaks_mag_set(2),peak_struct)

    %% SIGNAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % pre-process the signal
    for i = 1:length(info.preprocess)
        func = info.preprocess{i};
        signal_x = func(signal_x);
        signal_y = func(signal_y);
    end
    
    % Raw Signal:
    if info.raw == 1
        plot(ax, frequency, signal_x, info.x_param{:})
        plot(ax, frequency, signal_y, info.y_param{:})
        legend_entries = [legend_entries,info.x_label,info.y_label];
    end

    % Magnitude Signal
    if info.mag == 1
        mag = Magnitude(signal_x, signal_y);
        plot(ax, frequency, mag, info.mag_param{:})
        legend_entries = [legend_entries,info.mag_label];
    end

    %% PEAKS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % (PEAKS) GIVEN 
    peak_struct = "peaks_mag_given";
    if info.peaks_raw_given(1) == 1 && ~isempty(tdms_data.(peak_struct))
        all_peaks = [tdms_data.(peak_struct)];
        plot(ax, [all_peaks.Frequencies],[all_peaks.signal_x], info.peak_x_param{:})
        plot(ax, [all_peaks.Frequencies],[all_peaks.signal_y], info.peak_y_param{:})
    end
    if info.peaks_mag_given(1) == 1 && ~isempty(tdms_data.(peak_struct))
        all_peaks = [tdms_data.(peak_struct)];
        plot(ax, [all_peaks.Frequencies], [all_peaks.mag], info.peak_mag_param{:})
    end
    
    % (PEAKS) SET
    peak_struct = "peaks_mag_set";
    if info.peaks_raw_set(1) == 1 && ~isempty(tdms_data.(peak_struct))
        all_peaks = [tdms_data.(peak_struct)];
        plot(ax, [all_peaks.Frequencies],[all_peaks.signal_x],info.peak_x_param{:})
        plot(ax, [all_peaks.Frequencies],[all_peaks.signal_y],info.peak_y_param{:})
        legend_entries = [legend_entries,info.x_peak_label,info.y_peak_label];
    end
    if info.peaks_mag_set(1) == 1 && ~isempty(tdms_data.(peak_struct))
        all_peaks = [tdms_data.(peak_struct)];
        plot(ax, [all_peaks.Frequencies],[all_peaks.mag],info.peak_mag_param{:})
        legend_entries = [legend_entries,info.mag_peak_label];
    end
    
    % plotting labels on peak magnitudes
    if info.mag_labels == 1 && ~isempty(tdms_data.(peak_struct))
        all_peaks = [tdms_data.(peak_struct)];
        for i=1:length(all_peaks)
            text(ax,all_peaks(i).Frequencies,all_peaks(i).mag,['  ',int2str(i)])
        end
    end
    
    % (PEAKS) Tracked
    peak_struct = "peaks_tracked";
    if info.peaks_tracked == 1 && ~isempty(tdms_data.(peak_struct))
        
        % easier accesss to data
        peak_tracked = tdms_data.peaks_tracked;
        peak_freq = peak_tracked.Frequencies;
        peak_mag = peak_tracked.mag;
        %mmin = peak_tracked.interval(1);
        %mmax = peak_tracked.interval(2); 
        
        % Plot: peak found in current file
        %plot(ax,[peak_freq, peak_freq],y_lim,'b--','DisplayName','found frequency');
        plot(ax,peak_freq ,peak_mag,'bx','DisplayName','peak tracked',...
                                         'MarkerSize',15,'LineWidth',3);
    end

    % (PEAKS) WIDTHS
    if info.plot_width == 1 && info.mag == 1
        findpeaks(Magnitude(signal_x,signal_y),frequency,info.peak_options,'Annotate','extents')
    end
    
    %% GENERAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % removes tick marks
    if info.remove_ticks == 1
        set(ax,'xticklabel',[])
        set(ax,'yticklabel',[])
    end
    
    % sets legend
    if info.legend == 1
        legend(ax,legend_entries)
    end
    
    % sets the access maximum and minimum. I use this for reusing axis
    % limits.
    if length(info.XLim) == 2 && length(info.YLim) == 2
        ax.XLim = info.XLim;
        ax.YLim = info.YLim;
    end
    
end


