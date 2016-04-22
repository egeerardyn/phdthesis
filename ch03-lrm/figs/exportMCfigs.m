basePath = dropbox('VUB','PhD','thesis','ch03-lrm');
makeFileName = @(SNR) fullfile(basePath ,'figs', sprintf('MC-SNR-%d', SNR));
makeDataPath = @(SNR) fullfile(basePath ,'data', sprintf('MC-SNR-%d', SNR));


relativeDataPath = @(SNR) sprintf('\\thisDir/data/MC-SNR-%d', SNR);
allfigs = findall(groot,'type','figure');

titleOfFigAxes = @(h) get(get(findall(h,'type','axes'),'Title'), 'String');
arrayfun(@(h) set(h, 'name', titleOfFigAxes(h)), allfigs);

for iFile = 1:numel(allfigs)
    fig = allfigs(iFile);
    
    SNR = textscan(titleOfFigAxes(fig),'SNR = %f dB');
    SNR = SNR{1};
    
    filename = makeFileName(SNR);
    dataPath = makeDataPath(SNR);
    if ~exist(dataPath,'dir')
        mkdir(dataPath);
    end
    
    saveas(fig, [filename '.fig']);
    matlab2tikz([filename '.tikz'], 'figurehandle', fig, ...
                'width', '\figurewidth', ...
                'height', '\figureheight', ...
                'externalData', true, ...
                'dataPath', dataPath, ...
                'relativeDataPath', relativeDataPath(SNR));
end
