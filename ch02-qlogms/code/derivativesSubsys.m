clear all;
close all;
clc;

syms K wz s wn xi wp 
syms m
m = 5; % mupad refuses to check for equality when m is symbolic (prolly some restraint is needed)

G1 = K/(s+wp)
G2 = K*(s/wz+1)/(s^2/wn^2 + 2*xi*s/wn + 1)^m

derivative = @(f, x) simplify(diff(f,x))

dG2dK  = derivative(G2,K)
dG2dwz = derivative(G2,wz)
dG2dwn = derivative(G2,wn)
dG2dxi = derivative(G2,xi)


numer = K*wn^(2*m)/wz*(s+wz);
D     = s^2 + 2*xi*wn*s+wn^2;
denom = (D)^m;

assert(logical(simplify(G2 == numer/denom)))

dG2dK_man = G2/K
dGdwz_man = -K*wn^(2*m)*s/wz^2/D^m
dGdwn_man =  2*m*K*wn^(2*m-1)/wz*(s+wz)*(s+xi*wn)*s/D^(m+1)
dGdxi_man = -2*K*m*wn^(2*m+1)*s*(s+wz)/wz/D^(m+1)

assert(logical(simplify(dGdK_man  == dG2dK)) , 'dGdK is wrong')
assert(logical(simplify(dGdwz_man == dG2dwz)), 'dGdwz is wrong')
assert(logical(simplify(dGdwn_man == dG2dwn)), 'dGdwn is wrong')
assert(logical(simplify(dGdxi_man == dG2dxi)), 'dGdxi is wrong')
