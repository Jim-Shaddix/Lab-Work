function MakePlots(tdms_data, subplots, plot_params)
% This function plots data from the tdms files, based on flags that 
% are passed in.
%
% PARAMETERS:
% 1. subplots = [boolean]
%       - True: plots from tdms_data are made in a subplot
%       - False: all the plots are made one at a time
% 2. plot_params = [String Array]
%       - each string specified in this array is used as a flag, that
%         determines what data will be plotted
%         Options: [raw, raw_fit, raw_mag_given_peaks, raw_set_peaks,
%                   quad, quad_mag_given_peaks]
    
    % Set Defaults
    if nargin < 2
        subplots = true;
    end
    
    if nargin < 3
        plot_params = 'raw';
    end

    % Initializing the Canvas
    if subplots == true
        fig = figure;
    end
    
    % The scroll sub-plot works by creating a page of figures
    % based on the number of columns and rows.
    rows = 4;
    cols = 4;

    for i = 1:length(tdms_data)
        
        % create subplots, if flag is set
        if subplots == true
            axes = scrollsubplot(rows,cols,i);
        else
            fig = figure;
            xlabel('Frequency (hz)')
            ylabel('Voltage (V)')
        end
        
        % Plot a single file
        td = tdms_data(i);
        Plot_File(td,plot_params)        
        
        title(['Subplot: ',int2str(i)])
        hold off
        
        if subplots == false
            uiwait(fig);
        else
            set(axes, 'ButtonDownFcn', {'Pop_Up_Plot', td, plot_params,i})
        end
        
    end
    
end