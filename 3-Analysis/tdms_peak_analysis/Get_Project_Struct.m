function project_config = Get_Project_Struct()
% Returns a sruct that that contains fields that govern the behavior of
% a single run of this application. 
%
% * These fields are global to every file that is read in, meaning, these
%   fields will be the same for every file that is read in.

%% File Info
project_config.map_measurement_unit = ...
    containers.Map({'temperature','magnetic_field'}, ...
                   {'K','oe'});
               
project_config.file_x_axis_measurment = 'Frequency (khz)';
project_config.file_y_axis_measurment = 'Voltage (V)';
 
%% Fit Info
project_config.fit_lbls = {'A', 'theta', 'gamma', 'f_0', 'x_offset', 'y_offset'};

%OLD FIT
%function handle for: [complex lorentzian]
x = ['A', 'theta', 'gamma', 'f_0', 'x_offset', 'y_offset']
project_config.model = @(x, x_cor_fit) ... 
       x(1) ./ ((x_cor_fit(1,:) - x(4)).^2+x(3).^2) .* ...
       ((x_cor_fit(1,:) - x(4)).*cos(x(2)) + x(3).*sin(x(2))) + x(5) + ...
       ...
       1i * (x(1) ./ ((x_cor_fit(1,:) - x(4)).^2+x(3).^2) .* ...
       ((x_cor_fit(1,:) - x(4)).*sin(x(2)) - x(3).*cos(x(2))) + x(6));

%% New Fit   
% project_config.fit_lbls = {'A', 'theta', 'fn', 'Q', 'x_offset', 'y_offset'};
% 
% %NEW FIT
% %x = ['A', 'theta', 'fn', 'Q', 'x_offset', 'y_offset']
% project_config.model = @(x, x_cor_fit)       ...
%         x(1) * exp(-1j * x(2)) ./             ... % numerator
%         ( ...
%         x(3)^2 - x_cor_fit(1,:).^2 -      ... % denomonater-term-1
%         1j * x(3) * x_cor_fit(1,:) / x(4)    ... % denomonater-term-2
%         ) + ... 
%         x(5) + 1j * x(6);                        % offset

end