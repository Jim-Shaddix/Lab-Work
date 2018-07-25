function Plot_Width(tdms_data)

    % set widths, and frequencies of peaks
    width = 0;
    freq  = 0;
    for i = 1:length(tdms_data)
        for j = 1:length(tdms_data(i).mag_given_peaks)
            freq(end+1) = tdms_data(i).temperature;
            width(end+1) = tdms_data(i).mag_given_peaks(j).fit.gamma;
        end
    end

    hold on
    plot(freq,width, ...
        'bo',        ...
        'MarkerSize',5)


    title({'TAV2 ','Function Being Fit: $z(f) = \frac{Ae^{i \theta}}{f-f_{0}+i\gamma}$'},'Interpreter','latex')
    ax = gca;
    ax.TitleFontSizeMultiplier = 2;
    ylabel('$\gamma$','Interpreter','latex','FontSize', 15)
    xlabel('Temperature (K)','FontSize', 15)
    legend("Width")

end

