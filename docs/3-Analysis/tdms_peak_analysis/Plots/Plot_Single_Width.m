function Plot_Width(tdms_data)
    
    % Peak Indices Corresponding To:
    % - peaks occuring near a particular tempuency
    peak_index = [1,1,1,2 ... 
             3,1,2,2 ...
             3,3,2,2 ...
             3,3,2,2 ...
             2,2,2,1 ...
             2,1,1,2 ...
             3,2,2,2 ...
             2,1,1,1 ...
             1,1,2,1 ...
             0,0,1,0 ...
             1];
     
    % SET: gammas/temp of peaks
    gamma = [];
    temp  = [];
    for i = 1:length(tdms_data)
        if peak_index(i) == 0
            continue
        end
        temp(end+1) = tdms_data(i).temperature;
        gamma(end+1) = tdms_data(i).mag_given_peaks(peak_index(i)).fit.gamma;      
    end

    % GET: indices
    threshold = 0.03;
    index_pos = (gamma>=threshold);
    index_neg = (gamma<threshold);
    
    % GET: plot values
    gamma_big   = gamma(index_pos);
    gamma_small = gamma(index_neg);
    temp_big    = temp(index_pos);
    temp_small  = temp(index_neg);
    
    % PLOT: Good Points
    hold on
    grid on
    plot(temp_big,gamma_big, ...
        'bo',            ...
        'MarkerSize',5)
    
    
    % PLOT: Bad Points
    
    %abs
    %gamma_small = abs(gamma_small);
    
    lbl_dwn = .1*max(gamma_big);
    for i = 1:length(temp_small)
        plot(temp_small(i),gamma_small(i), ...
            'ro',            ...
            'MarkerSize',5)
        text(temp_small(i),gamma_small(i)+lbl_dwn,num2str(i));
    end
    
    % Axis Settings
    title({'TAV2 Peaks at $8.8*10^{5}$ (khz)','Function Being Fit: $z(f) = \frac{Ae^{i \theta}}{f-f_{0}+i\gamma}$'},'Interpreter','latex')
    ax = gca;
    ax.TitleFontSizeMultiplier = 2;
    ylabel('$\gamma$','Interpreter','latex','FontSize', 15)
    xlabel('Temperature (K)','FontSize', 15)
    legend(['\gamma > ',num2str(threshold),' # of points: ',num2str(length(temp_big))], ...
           ['\gamma < ',num2str(threshold),' # of points: ',num2str(length(temp_small))])

end



 
