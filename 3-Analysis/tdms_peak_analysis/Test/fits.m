
%% sqaure data
x = linspace(1,100,1000);
y = x.^2;
y_noisy = y + rand(1,length(y)) ./ 2 .* y;

%% sine stuff
x = linspace(1,10,100);
y = sin(x).^2;
y_noisy = y + rand(1, length(y)) / 2 .* y;
disp("[Finished]")