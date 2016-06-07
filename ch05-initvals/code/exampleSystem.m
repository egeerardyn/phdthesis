close all;
clear variables;
clc;

tfO2 = @(K,wn,z) tf(K*wn^2,[1 2*z*wn wn.^2]);
randccn = @(varargin) (randn(varargin{:}) + 1i*randn(varargin{:}))/sqrt(2);

G = tfO2(1,1,0.05) + tfO2(2,5,0.05) + tfO2(1,10,0.01) + tfO2(5, 20,0.2);


w     = logspace(-1,2,200);
FRF   = squeeze(freqresp(G,w));
Noise = randccn(size(FRF))*2;


%% plot
figure;

hAx(1) = subplot(1,2,1);
plot(w, db(FRF), 'LineWidth', 2,'Color',tango('green',3));

hAx(2) = subplot(1,2,2);
plot(w, db(FRF+Noise), 'LineWidth', 2,'Color',tango('red',2));

set(hAx, 'XScale','log','XLim',[min(w) max(w)], 'YLim',[-20 40], 'Visible','off')


%% export
matlab2tikz('../figs/example-noise.tikz','width','\figurewidth','height','\figureheight')