close all;
clear variables;
clc;

f = [1 3/2 pi];
delta = eps(double(1));
fBin        = round(f/delta);
fQuantized  = fBin * delta;

Tquant = 1./fQuantized;

% lcm of rational numbers = lcm (numerators) / gcd (denominators)

LCM = 1;
GCD = gcd(fBin(1), gcd(fBin(2), fBin(3)));

T = 1/delta * LCM / GCD;
Tdy = T/24/3600;
Tyr = Tdy/365.2425;

fprintf('delta = %g\n',delta);
fprintf('T = %g s = %g days =  %g yr\n', T, Tdy, Tyr);
