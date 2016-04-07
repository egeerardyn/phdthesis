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
