function Plot_Tracked_Peaks(ax,peaks_of_interest,x_cor,str_to_plot,linespec)
    %% Plot Settings
    marker_appearance = {linespec, 'MarkerSize', 3};

    % Get: x/y axis labels from the regular plots
    project_config = Get_Project_Struct();
    x_lbl = project_config.file_x_axis_measurment;
    y_lbl = project_config.file_y_axis_measurment;
    
    %% Plot frequency: if it was passed in
    if strcmp(str_to_plot, x_lbl) == 1
        freq = [peaks_of_interest.Frequencies];
        plot(ax,x_cor,freq,marker_appearance{:}, ...
            'DisplayName', [str_to_plot,' # of points: ',num2str(length(x_cor))]);
        ylabel(ax,"Frequency (khz)",'FontSize', 15)
        return
    end

    % Plot Potential: if it was passed in
    if strcmp(str_to_plot, y_lbl) == 1
        V = [peaks_of_interest.mag];
        plot(ax,x_cor,V,marker_appearance{:}, ...
            'DisplayName', [str_to_plot,' # of points: ',num2str(length(x_cor))]);
        ylabel(ax,"Potential Magnitude (V)",'FontSize', 15)
        return
    end

    %% GET: Plot Data    
    % GET: fit-struct/temp of peaks
    fits  = [peaks_of_interest.fit];
    fit_param     = [fits.(str_to_plot)];
    fit_param_err_min = [fits.([str_to_plot,'_err_min'])];
    fit_param_err_max = [fits.([str_to_plot,'_err_max'])];

    %% Plot
    errorbar(ax, ...
         x_cor,...
         fit_param, ...
         fit_param_err_min, fit_param_err_max, ...
         marker_appearance{:}, ...
        'DisplayName', [str_to_plot,' # of points: ',num2str(length(x_cor))]);
    
    ylabel(ax,['Fit Parameter (',str_to_plot,')'],'FontSize', 15);
    
end

