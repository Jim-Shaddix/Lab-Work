function project_config = Get_Project_Struct()
% Returns a sruct that that contains fields that govern the behavior of
% a single run of this application. 
%
% * These fields are global to every file that is read in, meaning, these
%   fields will be the same for every file that is read in.
                                  
project_config.map_measurement_unit = ...
    containers.Map({'temperature','magnetic_field'}, ...
                   {'K','oe'});
               
project_config.file_x_axis_measurment = 'Frequency (khz)';
project_config.file_y_axis_measurment = 'Voltage (V)';
               
end