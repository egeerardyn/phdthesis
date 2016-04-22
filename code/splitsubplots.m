function [hFig] = splitsubplots(hFigWithSubplots)

if ~exist('hFigWithSubplots','var')
    hFigWithSubplots = findall(groot,'type','figure');
end

hProto = figure;
hAx = axes;
defaultPos   = get(hAx,'Position');
defaultUnits = get(hAx,'Units');
delete(hProto)
    
hAxes = findall(hFigWithSubplots, 'type', 'axes');
hFig  = repmat(groot, size(hAxes));

for iAx = 1:numel(hAxes);
    hFig(iAx) = figure();
    set(hAxes(iAx),'Parent',hFig(iAx),'Units',defaultUnits, 'Position',defaultPos);
end
