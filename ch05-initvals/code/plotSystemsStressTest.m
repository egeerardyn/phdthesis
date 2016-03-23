close all;
clear variables;
clc;

systems  = systemsForStressTest;
systems  = reshape(systems, 4,4); % reshape here to assure we have 16 filters
szSys    = num2cell(size(systems));

[~,~,Ts] = tfdata(systems{1}, 'v');
t        = [0:Ts:1024]; %[s] time vector for simulation
Tmax     = 200;         %[s] number of taps used for RFIR filter

%% make Bode 
figure('name','Bode Plots');
bo              = bodeoptions;
bo.FreqScale    = 'linear';
bo.PhaseVisible = 'off';
bo.YLim         = [-70 10];
bo.XLim         = [0.1 1]*pi;

for iFilter = 1:numel(systems)
    subplot(szSys{:}, iFilter);
    bode(systems{iFilter}, bo);
end

%% make figure
figure('name','Impulse responses');
hAx = repmat(gca, szSys{:});

scaling = NaN(size(systems));

for iFilter = 1:numel(systems)
    g = impulse(systems{iFilter}, t);
    scaling(iFilter) = max(abs(g));
    gNorm = g./scaling(iFilter);
    % gNorm = g;
    
    hAx(iFilter) = subplot(szSys{:}, iFilter);
    hold on;
    % proj = @(x)x;
    proj = @abs;
    
    plot(t(t<=Tmax), proj(gNorm(t<=Tmax)), 'k');
    plot(t(t>Tmax) , proj(gNorm(t>Tmax)) , 'r');
end
% set(hAx, 'XLim', [min(t) max(t)], 'YLim', [-1 1],...
%          'XAxisLocation','origin','YAxisLocation','origin','box','off')
set(hAx,'YScale','log','XScale','lin')
set(hAx,'YLim',[1e-3, 1],'XLim',[1 max(t)])
linkObject = linkprop(hAx(:),'XLim','YLim');
