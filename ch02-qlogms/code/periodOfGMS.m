close all;
clear variables;
clc;

f = [1 3/2 pi];

float = 'single';

epsilon = double(eps(float));
mk      = (round(f/epsilon));
fQuantized  = mk * epsilon;

Tquant = 1./fQuantized;

% lcm of rational numbers = lcm (numerators) / gcd (denominators)
% http://math.stackexchange.com/questions/44836/rational-numbers-lcm-and-hcf
LCM = 1;

T = 1/epsilon * LCM / vgcd(mk);

Tdy = T/24/3600;
Tyr = Tdy/365.2425;

fprintf('epsilon = %g (%s)\n',epsilon, float);
fprintf('T = %g s = %g days =  %g yr\n', T, Tdy, Tyr);
