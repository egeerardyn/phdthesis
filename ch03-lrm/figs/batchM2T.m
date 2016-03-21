function batchM2T(files, m2tOptions)
% BATCHM2T batch conversion of FIG figures to TIKZ
%
% Converts all FIG files in the current directory to TikZ using
% matlab2tikz.
%
% Usage:
%
%    BATCHM2T()
%
% See also: matlab2tikz

    %% Default options
    if ~exist('files','var') || isempty(files)
        files = dir('*.fig');
    end
    if ~exist('m2tOptions','var')
        m2tOptions = {'width', '\figurewidth', ...
                      'height', '\figureheight', ...
                      'standalone', false, ...
                      'externalData', true, ...
                      'relativeDataPath', '\thisDir/figs/', ...
                      'showInfo', false};
    end

    asTikz = @(file) strrep(file.name, '.fig','.tikz');

    %% Conversion
    for file = files(:)'
        fprintf(' %s \t -> \t %s \n', file.name, asTikz(file));
        
        hFig = open(file.name);
        finallyCloseFigure = onCleanup(@() close(hFig));

        try
            matlab2tikz(asTikz(file), 'figurehandle', hFig, m2tOptions{:});
        catch ME
            fprintf(2,'Error "%s" during conversion of %s\n%s\n\n', ...
                    ME.identifier, file.name, getReport(ME));
        end
    end

end
