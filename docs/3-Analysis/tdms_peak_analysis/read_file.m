clear
clc

fprintf("--- Started ---\n");

% SET: paths
addpath(genpath('Store_TDMS_Data')); % for reading tdms files

path_good = '../../2-Files_To_Analyze/31 May 18 TaV2/sp001_053118_TaV2_300.0K_800-1200kHz.tdms';
path_bad  = '../../2-Files_To_Analyze/TaV2 October 27 2018/sp001_102718_TaV2_300.0K_800-1200kHz.tdms';

path_trial  = '../../2-Files_To_Analyze/trial/sp001_010819.tdms';
path_trial2 = '../../2-Files_To_Analyze/trial2/sp003_011419_Fe3PO7_1-2MHz_Sample1.tdms';

% READ: data
RUSdata = TDMS_getStruct(path_trial2);

% STORE: data from tdms files
fprintf(' --- Finished: Reading Data ---\n\n')
