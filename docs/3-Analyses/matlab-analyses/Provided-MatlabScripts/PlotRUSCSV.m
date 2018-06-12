function PlotRUSCSV(RUSdataCSV,offset);
figure;hold on;legendstore=[];colorset=flipud(winter(length(RUSdataCSV)));
jj=0;
for i=[1,3:11,14:24];%length(RUSdataCSV);
   plot(RUSdataCSV{i}.Frequency_Hz_Signal,RUSdataCSV{i}.Magnitude_V__Signal+(jj)*offset,'Color',colorset(i,:));
   legendstore{length(legendstore)+1}=RUSdataCSV{i}.TemperatureStr;
   x(i,:)=RUSdataCSV{i}.Frequency_Hz_Signal;
   y(i,:)=ones(1,length(x(i,:)))*offset*(i-1);
   z(i,:)=RUSdataCSV{i}.Magnitude_V__Signal;
   jj=jj+1;
end;xlabel('Frequency [Hz]');ylabel('Magnitude [arb]');legend(legendstore)

%figure;surf(x,y,z);
%shading interp
end