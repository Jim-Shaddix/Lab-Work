function processed_data = Process_Plot_Data(data)
% Process_Plot_Data: returns the processed data to that can be used for:
% finding peaks, and making plots.
%
% PARAMETERS: data: data that will be processed
% RETURNS:    processed_data:

    % removes the linear trend in the data
    processed_data = detrend(data);

    %trying a convolution with a gaussian distribution
    processed_data = Convolution(processed_data);
    
end