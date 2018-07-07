function processed_data = Dataplay(data)
% Dataplay: this function detrends and convoluts the data that is passed
% in, and than returns the processed data.
%
% PARAMETERS: data = data that will be processed
% RETURNS: processed

    %trying a convolution with a gaussian distribution
    len = length(data);
    detrend_data = detrend(data);
    len = len+20;
    one = -2:.1:2;
    norm = (1./10).*normpdf(one,0,1);
    w = conv(detrend_data,norm);
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
%     w = 1.4.*w;
    processed_data = w;
end