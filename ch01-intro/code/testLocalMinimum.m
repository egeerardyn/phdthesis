% Just a tiny script to show local minima
%
% In practice, one would not use this kind of algorithm for fitting those
% complex exponentials (exactly due to these local minima)

%% Settings
dt     = 0.1;
N      = 128;
t      = (0:N-1)*dt;
a0     = 0.01;
b0     = pi;
theta0 = a0 + b0*1j;
thetaInit = a0 + 2.3j;
model0 = model0;
model  = @(theta,t) real(exp(-theta.*t));
cost   = @(theta) sum(abs(model(theta,t) - model0(theta0,t)).^2)/N;

%% 
bRange = linspace(2,4,200);
theta   = a0+bRange*1j;

costVal = arrayfun(cost, theta);

%% Optimization
thetaHat = fminsearch(cost, thetaInit);

%% model
figure; hold on;
plot(t, model(theta0, t),'-k');
plot(t, model(thetaHat, t),'-r');

%% cost
figure; hold on;
plot(bRange, costVal)
plot(imag(theta0)  , cost(theta0),'ok')
plot(imag(thetaHat), cost(thetaHat),'xr');
plot(imag(thetaInit), cost(thetaInit),'.r');
