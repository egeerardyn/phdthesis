function new = simplifyTsv(filename, doSave, cleanfigureArgs)
    % SIMPLIFYTSV
    
    %% default arguments
    if ~exist('doSave','var') || isempty(doSave)
        doSave = nargout > 0;  % only save valid data by default
    end
    if ~exist('plotOptions','var') || isempty(plotOptions)
        plotOptions = {'LineWidth', 1.5};
    end
    if ~exist('cleanfigureArgs', 'var') || isempty(cleanfigureArgs)
        cleanfigureArgs = {};
    end
    
    styleBefore = {'LineStyle', '-', 'DisplayName', 'Before'};
    styleAfter  = {'LineStyle', '--', 'DisplayName', 'After'};
    
    
    %% load file
    [old] = loadFile(filename);
    
    %% show data 
    hFig = figure('name',filename);
    hData = plot(old.X, old.Y, styleAfter{:}, plotOptions{:});
    
    %% simplify data: clean last figure
    cleanfigure('handle',hFig, cleanfigureArgs{:});
    drawnow;
    
    %% extract data again from plot
    new = struct();
    new.old = old;
    new.X = get(hData, 'XData');
    new.Y = get(hData, 'YData');
    new.nPoints = numel(new.X);
    
    %% plot old data again
    hold all;
    hOld = plot(old.X, old.Y, styleBefore{:}, plotOptions{:});
    
    message = sprintf('%d -> %d points (%02g%% compression)', ...
                      nPoints(old), nPoints(new), ...
                      (nPoints(new)/nPoints(old))*100);
    disp([filename ' :  ' message]);
    title(gca, message);
    
    uistack(hOld,'bottom');
    legend('show','Location','Best');
    
    %% write out data to file
    if doSave
        data = [new.X(:), new.Y(:)];
        fid = fopen(filename, 'w');
        closeFileAfterwards = onCleanup(@() fclose(fid));
        
        FF     = '%g';
        COLSEP = '\t';
        ROWSEP = '\n';
        fprintf(fid, [FF COLSEP FF ROWSEP], data(:));
    end
    
end

function N = nPoints(data)
    N = numel(data.X);
end

function [data]  = loadFile(filename)
    data = importdata(filename);
    data = struct('data', data);
    data.X = data.data(:,1);
    data.Y = data.data(:,2);
    
    data.nPoints = numel(data.X);
    if size(data.data, 2) >= 3
        sz = size(data.data);
        warning('simplifyTsv:TooManyDimensions', ...
                'File has dimensions %d x %d. Only 2D is handled!', sz(1), sz(2));
    end
end
