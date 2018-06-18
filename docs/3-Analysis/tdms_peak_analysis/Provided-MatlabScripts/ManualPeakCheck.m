% After loading all data as RUSdata=RUSload(...), 
% set filenumber with FileNum
% run 1st 2 lines to see maximum peak number, set to PeakNum
% run all to output temperature and highest two fitted peaks

FileNum=21;
RUSdata{FileNum}.fit

PeakNum=24;
t=RUSdata{FileNum}.Temperature;
high2=RUSdata{FileNum}.fit.(['Peak',num2str(PeakNum-1)]).data;
high=RUSdata{FileNum}.fit.(['Peak',num2str(PeakNum)]).data;
disp(['T ',num2str(t),' f2 ',num2str(high2),' f ',num2str(high)])
