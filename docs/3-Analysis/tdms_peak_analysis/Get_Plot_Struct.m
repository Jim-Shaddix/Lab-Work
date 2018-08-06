function plot_struct = Get_Plot_Struct()
%GET_PLOT_STRUCT: This struct contains all of the possible options for
% creating a single plot.  

    %% Preprocess %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % cell array of function pointers.
    % - all these functions get applied to the raw data, prior to making any
    %   plots
    plot_struct.preprocess = {};

    %% Main Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % determines whether or not to plot the raw or magnitude data
    plot_struct.raw = 0;
    plot_struct.mag = 0;

    %% PLOTTING & CALCULATING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Three word parameters:
    % 1. peaks
    % 2. raw/mag:       (What type of data to plot the peak/fit)
    % 3. raw/mag/given: (Where the peak/fit comes.)
    % First  number denotes whether or not the peaks should be plotted
    % Second number denotes whether or not the fit should be plotted
    plot_struct.peaks_raw_given = [0,0];
    plot_struct.peaks_raw_set   = [0,0];
    plot_struct.peaks_mag_given = [0,0];
    plot_struct.peaks_mag_set   = [0,0];
    plot_struct.peaks_tracked   = 0;
    
    %% PEAKS
    % Parameters: for Track_Peaks_Interval
    plot_struct.track_interval = 15000;
    plot_struct.track_freq = 881200;
    
    % Parameters: for findpeaks
    find_peak_opts.MinPeakDistance   = 20000;
    find_peak_opts.MinPeakProminence = 0.0001;
    find_peak_opts.WidthReference    = 'halfprom';
    plot_struct.peak_options        = find_peak_opts;
    
    %% FITTING
    % Optimization Parameters: for lsqcurvefit
    options = optimoptions(@lsqcurvefit,     ...
                            'Display','off', ...
                            'TolX', 1e-10,   ...
                            'TolFun', 1e-10, ...
                            'MaxFunctionEvaluations', 1000000, ...
                            'MaxIterations', 1000000);
    plot_struct.fit_options = options;
    
    % Functions for determing interval-width
    plot_struct.fit_interval_raw = @(width_half_prom) width_half_prom;
    plot_struct.fit_interval_mag = @(width) 4*width;
    
    %% Plotting Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Displays: Plot Peak Widths
    plot_struct.plot_width = 0;
    
    % keyword arguements used for plotting the raw and magnitude data
    plot_struct.x_param   = {'r-','DisplayName','siganl-x'};
    plot_struct.y_param   = {'b-','DisplayName','signal-y'};
    plot_struct.mag_param = {'g-','DisplayName','siganl-magnitude'};
    
    plot_struct.fit_x_param    = {'y', 'LineWidth',4,'HandleVisibility','off'};
    plot_struct.fit_y_param    = {'c', 'LineWidth',4,'HandleVisibility','off'};
    plot_struct.fit_mag_param  = {'m', 'LineWidth',4,'HandleVisibility','off'};
    
    plot_struct.peak_x_param   = {'r*','HandleVisibility','off'};
    plot_struct.peak_y_param   = {'b*','HandleVisibility','off'};
    plot_struct.peak_mag_param = {'m*','HandleVisibility','off'};
    
    plot_struct.peak_tracked_param = {'m*','HandleVisibility','off'};


end

