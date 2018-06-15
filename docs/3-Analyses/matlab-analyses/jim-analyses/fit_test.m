% A = 90;
% theta = 0;
% gamma = 10;
% f0 = 1200;
% xdata = 800:2000;
% ydata = (A./((xdata(1,:) - f0).^2 + gamma^2)).*((xdata(1,:) - f0).*cos(theta) + gamma * sin(theta));


rus_data = RUSload('C:/Users/Andrew/Documents/MATLAB/RUS Data/');
xdata = rus_data(1).frequency(10000:11000);
ydata = rus_data(1).signal_x(10000:11000);

x = [1, 0, 10, 900000];
lorentz_fnc = @(x, xdata) (x(1)./((xdata(1,:) - x(4)).^2 + x(3)^2)).*((xdata(1,:) - x(4)).*cos(x(2)) + x(3) * sin(x(2)));
options = optimoptions(@lsqcurvefit,'Display','off','TolX', 1e-10, 'TolFun', 1e-10, 'MaxFunctionEvaluations', 1000000, 'MaxIterations', 1000000);
[xEst,resnorm, residual, exitFlag] = lsqcurvefit(lorentz_fnc, x, xdata, ydata,[],[],options);
disp(xEst)
disp(exitFlag)
% disp(residual)

fit_curve = (xEst(1,1)./((xdata(1,:) - xEst(1,4)).^2 + xEst(1,3)^2)).*((xdata(1,:) - xEst(1,4)).*cos(xEst(1,2)) + xEst(1,3) * sin(xEst(1,2)));

plot(xdata,ydata)
hold on;
plot(xdata,fit_curve)
legend('Lorentz Line', 'Fit Line')