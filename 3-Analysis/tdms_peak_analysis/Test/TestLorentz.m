%% plotting initial guess / raw data


%plot(x_cor_fit, real(y_cor_fit),'r','DisplayName', 'Real Data') % real
hold on 
%plot(x_cor_fit, imag(y_cor_fit),'b','DisplayName', 'Imag Data') % imag
%plot(x_cor_fit, sqrt(imag(y_cor_fit).^2 + real(y_cor_fit).^2),'k','DisplayName', 'Magnitude Data') % imag


%        A         theta fn                 Q, real_offset imag_offset
%guess = [1500000, 3.14, 812000.012956560, 900, 0,       0]; % inititial

plot(x_cor_fit, real(model(guess, x_cor_fit)), 'g', 'DisplayName', 'Real Guess')
hold on
%plot(x_cor_fit, imag(model(guess, x_cor_fit)), 'c', 'DisplayName', 'Imag Guess')

legend()

%% sanity test
x = linspace(0.6e6, 1.2e6, 1000);
guess = [410000000.00, 3.14, 1000000.00, 50, 0,       0]; % inititial
%guess = [1500.00, 3.14, 1000000.00, 50, 0,       0]; % inititial

guess_real = real(model(guess, x));
guess_imag = imag(model(guess, x));
guess_mag  = sqrt(guess_imag.^2 + guess_real.^2);

plot(x, guess_real, 'g', 'DisplayName', 'Real Guess')
hold on
plot(x, guess_imag, 'c','DisplayName', 'Imag Guess')
plot(x, guess_mag, 'k', 'DisplayName', 'Magnitude Guess')
legend()

% find peak frequency
index_at_max = find(guess_mag == max(guess_mag));
peak_freq = x(index_at_max);
disp(['Peak Frequency: ',num2str(peak_freq)])


