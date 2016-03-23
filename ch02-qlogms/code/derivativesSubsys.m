clear all;
close all;
clc;

syms K wz s wn xi wp 
syms m
m = 1; % mupad refuses to check for equality when m is symbolic (prolly some restraint is needed)

G1 = K/(s+wp)
G2 = K*(s/wz+1)/(s^2/wn^2 + 2*xi*s/wn + 1)^m
% G2 = K*wn^(2*m)*(s+wz)/wz/(s^2 + 2*xi*wn*s + wn^2)^m

derivative = @(f, x) simplify(diff(f,x))

dG2dK  = derivative(G2,K)
dG2dwz = derivative(G2,wz)
dG2dwn = derivative(G2,wn)
dG2dxi = derivative(G2,xi)


numer = K*wn^(2*m)/wz*(s+wz);
D     = s^2 + 2*xi*wn*s+wn^2;
denom = (D)^m;

assert(logical(simplify(G2 == numer/denom)))

%% Manual calculations
% as displayed in the thesis
dG2dK_man  =  G2/K
dG2dwz_man = -K*wn^(2*m)*s/wz^2/D^m
dG2dwn_man =  2*m*K*wn^(2*m-1)*(s+wz)/wz*(s+xi*wn)*s/D^(m+1)
dG2dxi_man = -2*K*m*wn^(2*m+1)*s*(s+wz)/wz/D^(m+1)

%% Check for equality between muPad and manual calculations
symEqual = @(a,b) logical(simplify(a==b));

assert(symEqual(dG2dK_man,  dG2dK) , 'dGdK is wrong')
assert(symEqual(dG2dwz_man, dG2dwz), 'dGdwz is wrong')
assert(symEqual(dG2dwn_man, dG2dwn), 'dGdwn is wrong')
assert(symEqual(dG2dxi_man, dG2dxi), 'dGdxi is wrong')
disp('All derivates are checked')

%% Prepare to plot
derivs = [dG2dK;dG2dwz;dG2dwn;dG2dxi];
values = struct('xi', 0.025, ...
                'K', 0.5, ...
                'wn', 1);
wzVal  = values.wn* [0.1 1 10];
wVal   = logspace(log10(0.004), log10(50), 500);

derivs = subs(derivs, K,  values.K);
derivs = subs(derivs, xi, values.xi);
derivs = subs(derivs, wn, values.wn);
derivs = arrayfun( @(wzVal) subs(derivs, wz, wzVal), wzVal, 'Un', false);
derivs = [derivs{:}];

figure('name', 'Bode plots of derivatives');
sz  = size(derivs);
hAx = repmat(gca, sz);
for iTf = 1:numel(derivs)
    thisTf = vectorize(derivs(iTf));
    [indI, indJ] = ind2sub(sz, iTf);
    elem         = sub2ind(flip(sz), indJ, indI);
    
    hAx(iTf) = subplot(sz(1), sz(2), elem);
    
    % `inline` is likely to disappear, but is required for vectorize
    TFVal = feval(inline(vectorize(thisTf)), 1i*wVal); %#ok
    plot(wVal, abs(TFVal),'-k','LineWidth',2)
end

set(hAx,'XScale','log','YScale','log','XLim', [min(wVal) max(wVal)]);
