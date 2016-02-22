clear all;
close all;
clc;

syms K wz s wn xi
syms m
m = 5; % mupad refuses to check for equality when m is symbolic (prolly some restraint is needed)

G = K*(s/wz+1)/(s^2/wn^2 + 2*xi*s/wn + 1)^m

derivative = @(f, x) simplify(diff(f,x))

dGdK  = derivative(G,K)
dGdwz = derivative(G,wz)
dGdwn = derivative(G,wn)
dGdxi = derivative(G,xi)

numer = K*wn^(2*m)/wz*(s+wz);
D     = s^2 + 2*xi*wn*s+wn^2;
denom = (D)^m;

assert(logical(simplify(G == numer/denom)))

dGdK_man  = G/K
dGdwz_man = -K*wn^(2*m)*s/wz^2/D^m
dGdwn_man =  2*m*K*wn^(2*m-1)/wz*(s+wz)*(s+xi*wn)*s/D^(m+1)
dGdxi_man = -2*K*m*wn^(2*m+1)*s*(s+wz)/wz/D^(m+1)

assert(logical(simplify(dGdK_man  == dGdK)) , 'dGdK is wrong')
assert(logical(simplify(dGdwz_man == dGdwz)), 'dGdwz is wrong')
assert(logical(simplify(dGdwn_man == dGdwn)), 'dGdwn is wrong')
assert(logical(simplify(dGdxi_man == dGdxi)), 'dGdxi is wrong')
