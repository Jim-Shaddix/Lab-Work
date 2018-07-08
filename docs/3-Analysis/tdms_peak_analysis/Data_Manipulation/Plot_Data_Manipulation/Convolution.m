function processed_data = Convolution(data)
% Dataplay:  returns the processed data to that can be used for:
% finding peaks, and making plots.
%
% PARAMETERS: data = data that will be processed
% RETURNS: processed_data

    %trying a convolution with a gaussian distribution
    len = length(data);
    len = len+20;
    one = -2:.1:2;
    norm = (1./10).*normpdf(one,0,1);
    w = conv(data,norm);
    w = w(21:len);
    % This reiterates the same convolution to smooth out the data as much
    % as needed to have almost only just the main peaks
    for i = 1:7
        w = conv(w,norm);
        w = w(21:len);
    end
%     w = conv(w,norm);
%     w = w(21:len);
%     w = conv(w,norm);
%     w = w(21:len);
%     w = conv(w,norm);
%     w = w(21:len);
%     w = conv(w,norm);
%     w = w(21:len);
%     w = conv(w,norm);
%     w = w(21:len);
%     w = conv(w,norm);
%     w = w(21:len);
    w = 1.4.*w;
    processed_data = w;
end