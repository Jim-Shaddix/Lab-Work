function result = trial_model(fit_params, x_cor)
%TRIAL_MODEL Summary of this function goes here
%   Detailed explanation goes here

A     = fit_params(1);
theta = fit_params(2);
fn    = fit_params(3);
Q     = fit_params(4);
r_bg  = fit_params(5);
i_bg  = fit_params(6);

num_1     = exp(-1i * theta); % numerator
denom_1   = fn^2 - x_cor.^2;       % denomenator term 1
denom_2   = 1i * fn * x_cor ./ Q;  % denomenator term 2
func_no_A = num_1 ./ (denom_1 - denom_2); % function without A
result = A*func_no_A;% result
end