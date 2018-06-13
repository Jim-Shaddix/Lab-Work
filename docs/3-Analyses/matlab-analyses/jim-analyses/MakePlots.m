function MakePlots(tdms_data)
% This function makes subplots of the data passed in.

    % Initializing the Canvas
    fig = figure;
    fig.Units = 'centimeters';
    fig.Position(3:4) = [45  30];

    % The scroll sub-plot works by creating a page of figures
    % based on the number of columns and rows.
    rows = 4;
    cols = 4;

    for i = 1:length(tdms_data)

        scrollsubplot(rows,cols,i);
        td = tdms_data(i);
        
        hold on
        plot(td.frequency, td.signal_x)
        plot(td.frequency, td.signal_y)
        %plot(td.frequency, td.my_quad)
        
        % Calculated Peaks
        %plot(td.xpeak_freq, td.xpeak,'b*')
        %plot(td.ypeak_freq, td.ypeak,'r*')
        
        % Given Peaks
        %disp(td.given_peaks.index)
        plot(td.given_peaks.Frequencies, ...
             td.signal_x(td.given_peaks.index), ...
             'g*')
               
        hold off

        title(['Subplot: ',int2str(i)])   
    end
    
end