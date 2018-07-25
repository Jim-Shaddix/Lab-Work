function tdms_data=Sub_Plots(tdms_data)
% This function plots data from the tdms files, based on flags that 
% are passed in.


    % Initializing the Canvas
    figure();
    
    % The scroll sub-plot works by creating a page of figures
    % based on the number of columns and rows.
    rows = 4;
    cols = 4;

    for i = 1:length(tdms_data)
        
        % CREATE: subplot
        axes = scrollsubplot(rows,cols,i);
        
        % make subplots clickable
        set(axes, 'ButtonDownFcn', {'Sub_Plots_Pop', tdms_data(i),i})

        % PLOT: single file
        tdms_data(i) = Plot_File(tdms_data(i));
        
        title(['Subplot: ',int2str(i)])
        hold off
        
        disp(['Finished Subplot ',int2str(i),' of ',int2str(length(tdms_data))])
        
    end
    
end