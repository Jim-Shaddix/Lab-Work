function Analyze_Single_Freq(ax, peaks_of_interest, peak_temps, str_plot_left, str_plot_right)
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
    
    if strcmp(str_plot_right,"None") == 1 
        % right axis -> invisible
        %if length(ax.YAxis) > 1
        %    ax.YAxis(2).Visible='off';
        %end
        % plot
        Plot_Single_Freq(ax,peaks_of_interest,peak_temps,str_plot_left,'ro');
        %ax.YColor = [0.15 0.15 0.15];
    else
        % plot left
        yyaxis(ax,'left')
        Plot_Single_Freq(ax,peaks_of_interest,peak_temps,str_plot_left,'ro');
        ax.YColor = [1 0 0];
        % plot right
        yyaxis(ax,'right')
        Plot_Single_Freq(ax,peaks_of_interest,peak_temps,str_plot_right,'bo');
        %ax.YAxis(2).Visible='on';
        ax.YColor = [0 0 1];
    end

    
end


