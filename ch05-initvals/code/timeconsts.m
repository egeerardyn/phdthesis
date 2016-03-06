close all;
clear variables;
clc;

Q   = [6 20]; % [dB]
wCo = 0.05;   % [pi rad/s]

G = cell(numel(Q), 1);
for ii = 1:numel(G)
    [B,A] = cheby1(2, Q(ii), wCo);
    G{ii} = tf(B,A,1);
    clear B A
end

[wn, xi] = cellfun(@damp, G,'Un', false);
takeFirst = @(v) cellfun(@(x) x(1), v, 'Un', true); % only works for 1st/2nd order systems
wn = takeFirst(wn);
xi = takeFirst(xi);

tau = 1./(xi.*wn); %[s] time constant
NBW= [36;48];
N = [3368 , 4462;
     20250, 26792];

for ii = 1:numel(G)
    fprintf('System %d (Q = %g dB, wn = %g rad/s, xi = %g, tau = %g)\n', ...
           ii, Q(ii), wn(ii), xi(ii), tau(ii))
    fprintf('Experiment length:')
    disp(N(ii, :));   
    fprintf('# bins in 3dB BW:')
    disp(NBW.');   
    fprintf('Experiment length normalized for tau:')
    disp(N(ii, :)./tau(ii));
    fprintf('\n');
end
