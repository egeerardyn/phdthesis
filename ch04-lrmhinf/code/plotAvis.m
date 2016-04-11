% This file loads and displays the AVIS setup
% from MAT file. Note, it is advised to use
% the `avisSetup.m` file from `LPMHinf/Code/Measurement/avis`
% (private repository) instead for:
%  - backwards compatibility
%  - better understanding of the variables

close all;
clear variables;
clc;

addpath(fullfile('..','..','code'));
load(fullfile('..','data','avis-setup','avis.mat'));

Cexp  = avis.controller;
Crot  = tf(Cexp(6,6));
Ctran = tf(Cexp(1,1));

filterSensor = avis.sensor.filter.z_trans;
F            = tf(filterSensor.Numerator, filterSensor.Denominator);

[~,~,Ts] = tfdata(Cexp);
fNyquist = 2*pi*1/Ts/2;
nPoints  = 100;
w = logspace(log10(0.001), log10(fNyquist), nPoints);

%% static transformations
Kact  = avis.actuator.polarity * avis.actuator.matrix;
Ksens = avis.sensor.matrix * avis.sensor.polarity;
tabOpts = {'floatFormat', '%g', 'col', ' & ', 'row', '\\\\\n'};
printMatrix(Kact, tabOpts{:} )
printMatrix(Ksens, tabOpts{:} )
%% plots
figure('name','Bode plots AVIS setup');

filters = {Ctran, Crot, F};
names   = {'Translation', 'Rotation','F'};
yfuns   = {@(y) db(y);
           @(y) angle(y)};
xfun    =  @(w) w/2/pi;
ylabels = {'Amplitude [dB]', 'Phase [rad]'};
xlabels = {'Frequency \omega [Hz]'};
plotStyle = {'Color','k','LineWidth',1.5};

nFilters = numel(filters);
nPlots   = numel(yfuns);

hAx = repmat(gca, nFilters, nPlots);
for iFilter = 1:nFilters;
    FRF = squeeze(freqresp(filters{iFilter},w));
    for jPlot = 1:nPlots
        yfun = yfuns{jPlot};
        
        idx = (jPlot-1)*nFilters + iFilter;
        hAx(idx) = subplot(nPlots, nFilters, idx);
        
        plot(xfun(w), yfun(FRF), plotStyle{:});
        if iFilter == 1
            ylabel(ylabels{jPlot})
        end
        if jPlot == 1
            title(names{iFilter});
        end
        if jPlot == nPlots
            xlabel(xlabels{1});
        end
    end
end

set(hAx([1,2],1), 'YLim', [-80 -20], 'YTick',[-80:20:-20]);
set(hAx([3],1), 'YLim', [-20 +20],'YTick',[-20:20:20]);

set(hAx, 'XScale','log', 'XLim',xfun([min(w) max(w)]), ...
    'XTick',10.^(-4:2:2));
set(hAx(:,2), 'YLim', [-pi pi],...
    'YTick',    [-pi -pi/2 0 pi/2 pi], ...
    'YTickLabels', {'-\pi','-\pi/2','0','\pi/2','\pi'} )

