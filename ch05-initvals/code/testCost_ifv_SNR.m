% Trial: noise introduces local minima in cost func
%
% Idea: use first order system (just pole)
close all;
clear variables;
clc;

p0    = 1;
s     = tf('s');
G0    = p0/(s-p0);
model = @(p,w) p./(1i*w - p).';

p     = logspace(-1,+1,101);
% p     = linspace(0.5,5,101); % closer scale
SNR   = logspace(-3,2,50);
w     = logspace(log10(min(p))-1,log10(max(p))+1,50);

FRF0  = squeeze(freqresp(G0, w));

randccn = @(varargin) (randn(varargin{:}) + 1i*randn(varargin{:}))/sqrt(2);
noise = randccn(size(FRF0)); % one noise realization

noisy = @(FRF, SNR) FRF.*(1+noise/SNR);  % relative error
%noisy = @(FRF, SNR) FRF+noise/SNR ; % absolute error

L2cost = @(theta, SNR)(sum(abs(model(theta, w) - noisy(FRF0, SNR)).^2)/numel(w));

cost  = L2cost;

% cost  = @(theta, SNR) L2cost(theta, SNR)./L2cost(p0, SNR); % relative cost
%  cost  = @(theta, SNR) L2cost(theta, SNR).*SNR.^2; % relative cost

[pp, SNRSNR] = meshgrid(p, SNR);
V = arrayfun(cost, pp, SNRSNR);


%% find optimum per SNR
[minV, idxMin] = min(V,[],2); % find minimizer over the parameter space (per SNR)
Vminima = diag(V(:, idxMin));

%% normalize plot
[maxV, idxMax] = max(V,[],2); 
dV = maxV - minV;
Vscaled = bsxfun(@rdivide, bsxfun(@minus, V, minV), dV);
VscMin = diag(Vscaled(:,idxMin));

%%
figure('name','Cost function'); hold on;
% plotter = @waterfall;
plotter = @mesh;

plotter(p, SNR, (V));
plot3(p(idxMin), SNR, Vminima, 'LineWidth', 2, 'Color','k')

xlabel('\theta','interpreter','latex');
ylabel('SNR')
zlabel('Cost Function');
set(gca,'XScale','log','YScale','log','ZScale','log','YDir','reverse')

%% 
figure('name','Scaled Cost function'); hold on;
% plotter = @waterfall;
plotter = @mesh;

plotter(p, SNR, Vscaled);
plot3(p(idxMin), SNR, VscMin, 'LineWidth', 2, 'Color','k')

xlabel('\theta','interpreter','latex');
ylabel('SNR')
zlabel('Scaled Cost');
set(gca,'XScale','log','YScale','log','YDir','reverse')
