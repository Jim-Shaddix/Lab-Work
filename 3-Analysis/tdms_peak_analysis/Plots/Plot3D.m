function Plot3D(tdms_data, x_lbl, y_lbl, z_lbl)
% plots all of the peak frequencies vs temperature.

    % struct of global variables
    project_config = Get_Project_Struct();

    % Refference to peaks
    cell_peaks = {tdms_data.peaks};

    % lbls to plot
    lbls = cell(x_lbl, y_lbl, z_lbl);
    
    % I will fill plot data with 3 vectors that are associated with
    % the lbls
    plot_data = [0,0,0];
    
    meas = {project_config.file_x_axis_measurment, ...
            project_config.file_y_axis_measurment};
    
    % Handle axis data
    for i=1:length(lbls)
        if strcmp(lbls(i), project_config.file_x_axis_measurment)
            plot_data[i] = tdms_data
        end
        
        if strcmp(lbls(i), project_config.file_y_axis_measurment)
            
        end
    end
    
    for i = 1:length(cell_peaks)
        peaks = cell_peaks{i};
        if isempty(peaks)
            continue
        end
        temps_to_plot = [temps_to_plot,repmat(all_temps(i),1,length(peaks))];
        freqs_to_plot = [freqs_to_plot,peaks.Frequencies];
        fits = [peaks.fit];
        gammas_to_plot = [gammas_to_plot,fits.gamma];
        A_to_plot = [A_to_plot,fits.A];
    end
    
    figure();
    scatter3(temps_to_plot,freqs_to_plot,gammas_to_plot,'Display','Single Peak');
    
    title('All Peak Frequenices vs. Temperature vs. Fit Parameter Gamma')
    xlabel('Temperature (K)')
    ylabel('Frequency (hz)')
    zlabel('Fit Parameter Gamma (hz)')
end