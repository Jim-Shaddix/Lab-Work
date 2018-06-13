function RUSdataCSV=RUSCSVload(FileFolder);
%FileFolder='/Users/peter/Desktop/Research/BaIrO3/RUS/5_15_2018/CSV/';
cd(FileFolder)
DirectoryStore=dir;
FileNames={DirectoryStore.name};
Files={FileNames{3:length(FileNames)}};
jj=1;
for i=[1:length(Files)]
    dataTable=[];dataStruct=[];Fnames=[];
    dataTable=readtable([FileFolder,Files{i}]);
    dataStruct=table2struct(dataTable);
    Fnames=fieldnames(dataStruct);
    for ii=1:length(dataStruct)
        for j=1:length(Fnames);
            if isempty(dataStruct(ii).(Fnames{j}))
            else
                tempRUSdataCSV{jj}.(Fnames{j})(ii)=findmult(dataStruct(ii).(Fnames{j}));
                tempRUSdataCSV{jj}.FileName=Files{i};
                temperatureInd=findstr(tempRUSdataCSV{i}.FileName,'K');
                tempRUSdataCSV{jj}.TemperatureStr=tempRUSdataCSV{i}.FileName(temperatureInd-3:temperatureInd);
                tempRUSdataCSV{jj}.Temperature=str2num(tempRUSdataCSV{i}.TemperatureStr(1:3));
                Temperatures(jj)=tempRUSdataCSV{jj}.Temperature;
            end;
        end;
    end;
    jj=jj+1;
end
[~,sortind]=sort(Temperatures);
sortind=fliplr(sortind);
for i=1:length(sortind)
RUSdataCSV{i}=tempRUSdataCSV{sortind(i)};
end
end



%% multi parse
function outmult=findmult(textvalue)
multVal=textvalue(end);
if multVal=='k'
    multi=1E3;
    outmult=multi*str2num(textvalue(1:end-1));
elseif multVal=='u'
    multi=1E-6;
    outmult=multi*str2num(textvalue(1:end-1));
elseif multVal=='M'
    multi=1E6;
    outmult=multi*str2num(textvalue(1:end-1));
elseif multVal=='m'
    multi=1E-3;
    outmult=multi*str2num(textvalue(1:end-1));
    elseif multVal=='n'
    multi=1E-9;
    outmult=multi*str2num(textvalue(1:end-1));
elseif isempty(multVal)
else
    multi=1;
    outmult=multi*str2num(textvalue(1:end-1));
end
end

%% 