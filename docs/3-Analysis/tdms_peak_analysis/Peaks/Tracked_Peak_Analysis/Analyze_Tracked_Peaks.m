function Analyze_Tracked_Peaks(ax, cell_peaks_tracked, peak_temps, str_plot_left, str_plot_right)
% plot the width of each peak found, describing a single peak
%
%
    %% Axis Settings 
    reset(ax)
    grid(ax,'on')
    title(ax,'TAV2 Peaks Near 8.8*10^{5} (khz)');
    xlabel(ax,'Temperature (K)','FontSize', 15);
    %set(ax,'NextPlot','replacechildren') ;
 
    %% Plots
    
    % remove current lines
    %ClearLinesFromAxes(ax)
    
    % filter cell_peaks_tracked and peak_temps
    % - I am filtering, because some of peaks_tracked are empty
    peaks_tracked = {};
    valid_temps = [];
    for i = 1:length(cell_peaks_tracked)
        if ~isempty(cell_peaks_tracked{i})
            peaks_tracked{end+1} = cell_peaks_tracked{i};
            valid_temps(end+1) = peak_temps(i);
        end
    end
    peaks_tracked = [peaks_tracked{:}];
    
    if strcmp(str_plot_right,"None") == 1 
        Plot_Tracked_Peaks(ax,peaks_tracked,valid_temps,str_plot_left,'ro');
    else
        % plot left
        yyaxis(ax,'left')
        Plot_Tracked_Peaks(ax,peaks_tracked,valid_temps,str_plot_left,'ro');
        ax.YColor = [1 0 0];
        % plot right
        yyaxis(ax,'right')
        Plot_Tracked_Peaks(ax,peaks_tracked,valid_temps,str_plot_right,'bo');
        ax.YColor = [0 0 1];
    end
    
end


