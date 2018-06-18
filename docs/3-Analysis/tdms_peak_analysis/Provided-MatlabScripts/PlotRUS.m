function PlotRUS(RUSdata,peakTrack);
figure;hold on;legendstore=[];
for i=1:length(RUSdata)
   plot(RUSdata{i}.p.Frequency.data,RUSdata{i}.p.Signal_X.data)
   legendstore{i}=RUSdata{i}.Props.name(1:5);
end;xlabel('Frequency [Hz]');ylabel('Signal X [arb]');legend(legendstore)
figure;hold on;
for i=1:length(RUSdata)
   plot(RUSdata{i}.p.Frequency.data,RUSdata{i}.p.Signal_Y.data) 
end;xlabel('Frequency [Hz]');ylabel('Signal Y [arb]');legend(legendstore)
for i=1:length(RUSdata);
    peakFreqs=[];peakSignal=[];peakRegion=[];
    peakRegion=find(and(RUSdata{i}.p.Frequency.data>=peakTrack-15000,RUSdata{i}.p.Frequency.data<=peakTrack+15000));
    peakFreqs=RUSdata{i}.p.Frequency.data(peakRegion);
    peakSignal=RUSdata{i}.p.Signal_X.data(peakRegion);
    peakFreq(i)=peakFreqs(find(max(peakSignal)==peakSignal));
    temperatures(i)=RUSdata{i}.Temperature;
end
figure;plot(temperatures,peakFreq);title(['Track peak ',num2str(peakTrack),' Hz']);xlabel('i');ylabel('Freq_{peak} [Hz]')

end