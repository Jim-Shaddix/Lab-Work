function [xPeaks, xWidth, yPeaks, yWidth, xLocs, yLocs] = find_peak_trial(xData, yData, freqs)
%     tdms_data = RUSload_test(file_path);

%     windowSize = 5;
%     b = (1/windowSize)*ones(1,windowSize);
%     a = 1;
%     hold on;
lev = 5;
wname = 'db2';
for i = 1:4
    
    xD = wden(xData,'sqtwolog','s','one',lev,wname);
    yD = wden(yData,'sqtwolog','s','one',lev,wname);
    
    %         plot(f,x)
    %         plot(f,xD)
    
    [xpks, xlocs,xW] = findpeaks(xD,freqs,'MinPeakDistance',10000, 'MinPeakProminence', 0.000003);
    %         findpeaks(xD,f,'MinPeakDistance',10000, 'MinPeakProminence', 0.000003);
    %         text(xlocs+.02,xpks,num2str((1:numel(xpks))'))
    %         disp(xW)
    [ypks, ylocs, yW] = findpeaks(yD,freqs,'MinPeakDistance',10000, 'MinPeakProminence', 0.000003);
    %         findpeaks(yD,f,'MinPeakDistance',1000, 'MinPeakProminence', 0.000009);
    %         text(ylocs+.02,ypks,num2str((1:numel(ypks))'))
    %         figure();
    
    xPeaks = xpks;
    xWidth = xW;
    xLocs = xlocs;
    yPeaks = ypks;
    yWidth = yW;
    yLocs = ylocs;
end
end

