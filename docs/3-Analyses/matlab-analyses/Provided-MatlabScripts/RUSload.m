
function RUSdata=RUSload(FileFolder);
%Function reads directory (FileFolder) for filenames and loads all TDMS files into
%single data structure. Extracts Temperature from filename string by finding character 'K'. 
%
%
%Example: FileFolder='/Users/peter/Desktop/Research/BaIrO3/RUS/5_15_2018/TDMS/';
%RUSdataCell=RUSload(FileFolder)

cd(FileFolder)
DirectoryStore=dir;
FileNames={DirectoryStore.name};j=1;
for i=1:length(FileNames);
    filenameTDMS=FileNames{i};
    if isempty(findstr(filenameTDMS,'tdms'))
    else
        Files{j}=FileNames{i};
        j=j+1;
    end
end
    for i=1:length(Files)
        RUSdata{i}=TDMS_getStruct([FileFolder,Files{i}]);
        RUSdata{i}.FileName=Files{i};
        temperatureInd=findstr(RUSdata{i}.FileName,'K');
        RUSdata{i}.TemperatureStr=RUSdata{i}.FileName(temperatureInd-3:temperatureInd);
        RUSdata{i}.Temperature=str2num(RUSdata{i}.TemperatureStr(1:3));
    end
end

