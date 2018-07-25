function Plot_Single_Width(tdms_data)
% plot the width of each peak found, describing a single peak
%
%
    %% Settings
    figure()
    peaks = "peaks_mag_given"; % field from tdms_data that is used to find fit
    
    marker_size = 9; % size of displayed points
    second_plot = false; % display a second plot
    y_axis_right = 'A'; % field from fit struct to plot on right hand side
    
    mod_theta = true;
    y_lbl = y_axis_right;
    
    % SET: y-axis labels
    if strcmp(y_axis_right,'theta')
        if mod_theta
            y_lbl = 'mod(theta,90) (degrees)';
        else
            y_lbl = 'theta (degrees)';
        end
    end

    %% GET: Peak Indices
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
     
         
    % GET: fit-struct/temp of peaks
    fits  = {};
    temp  = [];
    for i = 1:length(tdms_data)
        if peak_index(i) == 0
            continue
        end
        temp(end+1) = tdms_data(i).temperature;
        fits{end+1} = tdms_data(i).(peaks)(peak_index(i)).fit;      
    end
    fits = [fits{:}];
    
    % STORE: y-coordinates to plot
    gamma = [fits.gamma];
    gamma_err = [fits.gamma_err];
    y2 = [fits.(y_axis_right)];

    %% Plot Fit
    function plot_fit(source,callbackdata)
        figure()
        a = 1:10;
        b = a.^2;
        plot(a,b);
    end
    %% Plot Left
    if second_plot == true
        yyaxis left
    end

    hold on
    
    % PLOT: Good Points %%%%%%%%%%%%%
    e_left = errorbar(temp,gamma,gamma_err,'vertical', ...
        'bs', ...
        'MarkerSize',5, ...
        'MarkerFaceColor', 'b', ...
        'DisplayName', ['\gamma # of points: ',num2str(length(temp))]);   
    
    % Set: context menu
    %hcmenu = uicontextmenu;
    %item1 = uimenu(hcmenu, 'Label', 'Show Plot','Callback',@plot_fit);
    %set(axis_left, 'uicontextmenu', hcmenu);
    
    ylabel('Fit Parameter $\gamma$','Interpreter','latex','FontSize', 15)
    
    %% Plot Right
    if second_plot == true
        yyaxis right

        % process radians to degrees (if plotting theta)
        if strcmp(y_axis_right,'theta')
            y2 = y2.*(360/(2*pi)); % convert to degrees
            if mod_theta
                y2 = mod(y2,90);   % mod 90
            end
        end

        % plot 
        plot(temp,y2,  ...
            'go',      ...
            'MarkerSize',marker_size, ...
            'DisplayName',['Fit Parameter: ',y_axis_right]);

        ylabel(['Fit Parameter ',y_lbl],'Interpreter','latex','FontSize', 15)
    end
    
    %% Axis Settings   
    ax = gca;
    ax.TitleFontSizeMultiplier = 2;
    title({'TAV2 Peaks at $8.8*10^{5}$ (khz)', ...
    'Function Being Fit: $z(f) = \frac{Ae^{i \theta}}{f-f_{0}+i\gamma}$'}, ...
    'Interpreter','latex')

    xlabel('Temperature (K)','FontSize', 15);
    legend();
    grid on

end

