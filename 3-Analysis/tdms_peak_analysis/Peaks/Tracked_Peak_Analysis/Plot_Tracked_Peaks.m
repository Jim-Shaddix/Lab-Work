function Plot_Single_Freq(ax,peaks_of_interest,peak_temps,str_to_plot,linespec)
% plot the width of each peak found, describing a single peak

    %% Plot Settings
    marker_appearance = {linespec, 'MarkerSize', 3};

    %% Plot frequency: if it was passed in
    if strcmp(str_to_plot,'frequency') == 1
        freq = [peaks_of_interest.Frequencies];
        plot(ax,peak_temps,freq,marker_appearance{:}, ...
            'DisplayName', [str_to_plot,' # of points: ',num2str(length(peak_temps))]);
        ylabel(ax,"Frequency (khz)",'FontSize', 15)
        return
    end

    % Plot Potential: if it was passed in
    if strcmp(str_to_plot,'V') == 1
        V = [peaks_of_interest.mag];
        plot(ax,peak_temps,V,marker_appearance{:}, ...
            'DisplayName', [str_to_plot,' # of points: ',num2str(length(peak_temps))]);
        ylabel(ax,"Potential Magnitude (V)",'FontSize', 15)
        return
    end

    %% GET: Plot Data    
    % GET: fit-struct/temp of peaks
    fits  = [peaks_of_interest.fit];
    fit_param     = [fits.(str_to_plot)];
    fit_param_err = [fits.([str_to_plot,'_err'])];
    fit_param_err_min = [fits.([str_to_plot,'_err_min'])];
    fit_param_err_max = [fits.([str_to_plot,'_err_min'])];

    %% Plot   
    errorbar(ax, ...
         peak_temps,...
         fit_param, ...
         fit_param_err_min, fit_param_err_max, ...
         marker_appearance{:}, ...
        'DisplayName', [str_to_plot,' # of points: ',num2str(length(peak_temps))]);
    
    ylabel(ax,['Fit Parameter (',str_to_plot,')'],'FontSize', 15);
    
end

