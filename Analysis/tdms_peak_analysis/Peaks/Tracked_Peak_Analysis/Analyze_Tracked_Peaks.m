function Analyze_Tracked_Peaks(ax, cell_peaks_tracked, x_cor, x_axis_lbl, str_plot_left, str_plot_right)
% Determines how to plot the data on two axis
% Parameters:
% 1. ax: axes to plot on
% 2. cell_peaks_tracked: [Cell Array of Peak Structs] of the tracked peaks
%                        (including empty peak structs)
%
% 3. x_coor:[Array Numbers] all of the temperatures associated with tracked
%               peaks
%
% 4. str_plot_left: [Array Characters] the field in the fit struct that 
%                   will be used for the left axis
%
% 5. str_plot_right: [Array Characters] the field in the fit struct that
%                    will be used for the right axis. This field may also 
%                    be none, if you do not want to make a plot for the
%                    y-axis.
%
% 6. Sig_x_coord: [Array numbers]: I will plot a vertical line at each of
%                 the x-coordinates that are present in this array.

    %% Filter Tracked Peaks

    % filter cell_peaks_tracked and x_coor
    % - I am filtering, because some of peaks_tracked are empty
    peaks_tracked = {};
    valid_x_cor = [];
    for i = 1:length(cell_peaks_tracked)
        if ~isempty(cell_peaks_tracked{i})
            peaks_tracked{end+1} = cell_peaks_tracked{i};
            valid_x_cor(end+1) = x_cor(i);
        end
    end
    peaks_tracked = [peaks_tracked{:}];
    
    %% Axis Settings 
    reset(ax)
    grid(ax,'on')
    title(ax,['Peak Lives in Frequency Range', newline '[',        ...
             sprintf('%0.3e', min([peaks_tracked.Frequencies])), ...
             ' - ', ...
             sprintf('%0.3e', max([peaks_tracked.Frequencies]))  ...
             '] (khz)'])
    xlabel(ax, x_axis_lbl,'FontSize', 15);
    %set(ax,'NextPlot','replacechildren') ;
    %ClearLinesFromAxes(ax) % remove current lines
    
    %% Plots
    if strcmp(str_plot_right,"None") == 1 
        Plot_Tracked_Peaks(ax,peaks_tracked,valid_x_cor,str_plot_left,'ro');
    else
        % plot left
        yyaxis(ax,'left')
        Plot_Tracked_Peaks(ax,peaks_tracked,valid_x_cor,str_plot_left,'ro');
        ax.YColor = [1 0 0];
        % plot right
        yyaxis(ax,'right')
        Plot_Tracked_Peaks(ax,peaks_tracked,valid_x_cor,str_plot_right,'bo');
        ax.YColor = [0 0 1];
    end
    

end


