
% set data
rng default % for reproducibility
N = 100;    % number of observations
v0 = [2;3+4i;-.5+.4i];   % coefficient vector
xdata = -log(rand(N,1)); % exponentially distributed
noisedata = randn(N,1).*exp((1i*randn(N,1))); % complex noise
cplxydata = v0(1) + v0(2).*exp(v0(3)*xdata) + noisedata;

% objective function
objfcn = @(v,xdata)v(1)+v(2)*exp(v(3)*xdata);
x0 = (1+1i)*[1;1;1]; % arbitrary initial guess

opts = optimoptions(@lsqnonlin,'Display','off');
opts =optimoptions(@lsqcurvefit,opts); % reuse the options
[vestimated,resnorm] = lsqcurvefit(objfcn,x0,xdata,cplxydata,[],[],opts)
