
data = {'sp001_053118_TaV2_300.0K_800-1200kHz.tdms',     ... % 31 May
        'sp001_050419_CoNb2O6_1.8K_0oe_50-2000kHz.tdms', ... %CO
        'sp001_040919_FAPbBr_290K_0oe_50Hz-1MHz.tdms'};      % FAB
    
%unit2match = 'K';
unit2match = 'oe';

temps = cellfun(@(f) strip_value(unit2match, f), data)

function stripped_value = strip_value(unit2match, file_name)
% Strips out a value associated with a filename
% filename: character array to strip from.
% unit2match: my program will strip out values associated with the units 
%             passed in.

    matches = regexp(file_name,['_[+-]?\d*\.?\d*',unit2match,'_'], 'match');
    if isempty(matches)
       stripped_value = nan;
    else
       stripped_value = matches{end}(2:end-(length(unit2match)+1));
       stripped_value = str2double(stripped_value);
    end
    
end