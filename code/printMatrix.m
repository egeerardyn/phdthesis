function str = printMatrix(mat, varargin)
    args = parseInputs(mat, varargin{:});
    %% 
    [nCols] = size(mat, 2);
    fmt = makeFormat(nCols, args);
    
    str = sprintf(fmt, mat.');
    
    %% display output
    if nargout == 0
        disp(str);
        clear str;
    end
end

function fmt = makeFormat(nColumns, args)
    builder              = cell(2,nColumns);
    [builder{1,:}]       = deal(args.floatFormat);
    [builder{2,1:end-1}] = deal(args.columnSeparator);
    builder{2,end}       = args.rowSeparator;
    
    fmt = [builder{:}];
end

function args = parseInputs(varargin)
    persistent ipp
    if isempty(ipp)
        ipp = inputParser();
        ipp.FunctionName    = mfilename;
        ipp.CaseSensitive   = false;
        ipp.StructExpand    = true;
        ipp.KeepUnmatched   = true;
        ipp.PartialMatching = true;

        ipp.addRequired('mat');
        ipp.addParameter('floatFormat', '%15g');
        ipp.addParameter('columnSeparator', '\t');
        ipp.addParameter('rowSeparator', '\n');
    end
    
    ipp.parse(varargin{:});
    args = ipp.Results;
end
    
