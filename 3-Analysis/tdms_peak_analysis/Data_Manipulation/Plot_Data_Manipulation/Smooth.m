function smoothed = Smooth(data)
    % Smooth data using a gaussian weighted moving average of width 25.
    % Other widths may be better, but higher flattens the line more.
    smoothed = smoothdata(data, 'gaussian', 25);
end