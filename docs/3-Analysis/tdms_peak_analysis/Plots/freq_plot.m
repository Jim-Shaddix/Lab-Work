function freq_plot(tdms_data)
% plots all of the peak frequencies vs temperature.

    cell_peaks = {tdms_data.peaks_mag_given};
    all_temps      = [tdms_data.temperature];

    %freqs_to_plot = zeros(length(cell_peaks));
    %temps_to_plot = zeros(length(cell_peaks));
    temps_to_plot = [];
    freqs_to_plot = [];
    gammas_to_plot = [];
    A_to_plot = [];
    
    for i = 1:length(cell_peaks)
        peaks = cell_peaks{i};
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