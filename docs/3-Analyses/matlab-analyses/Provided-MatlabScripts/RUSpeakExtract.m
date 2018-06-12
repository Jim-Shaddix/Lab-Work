for i=1:length(RUSdata);
%RUSdata{i}.fit.(A{5}).data
A=fieldnames(RUSdata{i}.fit);
PeakInd=[];WidthInd=[];AmpInd=[];
for jj=1:length(A);
   name=A{jj};
   if findstr(name,'Peak')==1;
       PeakInd(length(PeakInd)+1)=jj;
   elseif findstr(name,'Width')==1;
       WidthInd(length(WidthInd)+1)=jj;
   elseif findstr(name,'Amplitude')==1;
       AmpInd(length(AmpInd)+1)=jj;
   else
   end
end
jj=1;
for j=PeakInd;
RUSfit{i}.PeakPos(jj)=RUSdata{i}.fit.(A{j}).data;
RUSfit{i}.PeakTemp(jj)=RUSdata{i}.Temperature;
jj=jj+1;
end
jj=1;
for j=WidthInd;
RUSfit{i}.PeakWidth(jj)=RUSdata{i}.fit.(A{j}).data;
RUSfit{i}.PeakWidthTemp(jj)=RUSdata{i}.Temperature;
jj=jj+1;
end
jj=1;
for j=AmpInd;
RUSfit{i}.PeakAmp(jj)=RUSdata{i}.fit.(A{j}).data;
RUSfit{i}.PeakAmpTemp(jj)=RUSdata{i}.Temperature;
jj=jj+1;
end
end



figure;hold on;colorset=jet(length(RUSdata));
for i=1:length(RUSfit)
   plot(RUSfit{i}.PeakTemp(RUSfit{i}.PeakPos>=900000),RUSfit{i}.PeakPos(RUSfit{i}.PeakPos>=900000),'Color',colorset(i,:))
end