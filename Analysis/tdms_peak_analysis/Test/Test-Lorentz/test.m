
%% test shift in y coordinates
plot(x_cor_fit, real(y_cor_fit), 'r-')
hold on
yline(0)
plot(x_cor_fit, imag(y_cor_fit), 'b-')
title("Before Transformation")


%% show results, after first fit

% GET: Y-coordinates from fit
fit_curve = lorentz_ratio(Est, x_cor_fit);

% Plot fit curve
plot(x_cor_fit, fit_curve, 'DisplayName', 'Fit', 'LineWidth', 2);
hold on;

% Plot data curve
plot(x_cor_fit, real(y_cor_fit) ./ imag(y_cor_fit),'DisplayName', 'Ratio-Data');
legend()