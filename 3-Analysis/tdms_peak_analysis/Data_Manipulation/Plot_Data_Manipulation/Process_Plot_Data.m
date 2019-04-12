function data = Process_Plot_Data(data)
% Process_Plot_Data: returns the processed data that can be used for:
% finding peaks, and making plots.
%
% PARAMETERkS: data: [Array Doubles] Signal data that will be processed
% RETURNS: processed_data:

    % removes the linear trend in the data
    data = detrend(data);
    
    % smooths the data
    data = Smooth(data);
    
    %trying a convolution with a gaussian distribution
    %processed_data = Convolution(processed_data);
    
end