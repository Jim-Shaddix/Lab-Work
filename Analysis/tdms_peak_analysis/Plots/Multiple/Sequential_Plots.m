function Sequential_Plots(tdms_data, plot_params)
% This function plots data from the tdms files in a sequential fashion 
% based on flags that are passed in.
%
% PARAMETERS:
  
    % Set: Defaults
    if nargin < 2
        plot_params = 'raw';
    end

    for i = 1:length(tdms_data)
        
        % Plot: single file
        fig = figure;
        Plot_File(tdms_data(i),plot_params)
        
        % Set: axis data
        xlabel('Frequency (hz)')
        ylabel('Voltage (V)')
        title(['Subplot: ',int2str(i)])
        
        hold off
        
        uiwait(fig);
        
    end
    
end