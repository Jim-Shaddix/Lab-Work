
% A, theta, fn, Q, x_real, x_imag
A      = 2;
theta  = pi / 4;
fn     = 2;
Q      = 1;
x_real = 0;
x_imag = 0;
params = [A, theta, fn ,Q, x_real, x_imag];

x_cor = 2;
result = trial_model(params, x_cor);

% current model
project = Get_Project_Struct();
result_other = project.model(params, x_cor)
