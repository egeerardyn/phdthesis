function str = externalizeTables(str, datafile, datapath, flag)
    if ~exist('flag','var')
        flag = '';
    end
    dryrun = strcmpi(flag, 'dryrun');
    
    BEGINTOKEN = 'table[';
    ENDTOKEN   = '}';
    
    parts = extractDataSegments(str, BEGINTOKEN, ENDTOKEN);
    
    nSegments = size(parts,1)-1;
    cntExternalFiles = 0;
    for iSegment = 1:nSegments
        origDataStr = parts{iSegment,2};
        if ~isInline(origDataStr)
            continue; % don't externalize when the data is already external
        end
                
        dataStr = strrep(origDataStr,'\\','');
        dataStr = regexprep(dataStr,'row sep\s*=\s*crcr\s*','');
        dataStr = strrep(dataStr,',,',','); % remove superfluous commas
        dataStr = strrep(dataStr,'[,','[');
        
        %% make file names
        cntExternalFiles = cntExternalFiles + 1;
        fname = datafile(cntExternalFiles, parts{iSegment,1});
        fpath = datapath(cntExternalFiles, parts{iSegment,1});
        
        %% extract data/spec part
        idxDataStart = strfind(dataStr,'{')+1;
        idxDataStop  = strfind(dataStr,'}')-1;
        
        data = dataStr(idxDataStart:idxDataStop);
        spec = [ dataStr(1:idxDataStart) fpath dataStr((idxDataStop+1):end) ];
        
        %% clean up data further
        data = regexprep(data, '^\s+', ''); % remove heading spaces
        
        %% clean up spec further
        EOL = sprintf('\n');
        spec = strrep(spec,EOL,'');
        spec = strrep(spec,'%','');
        
        %% save output
        outputFile(fname, data, dryrun)
        
        parts{iSegment,2} = spec;
    end
    
    str = strjoin(parts','');    
end
function bool = isInline(data)
    bool = ~isempty(strfind(data, '\\'));
end
function outputFile(filename, data, dryrun)
    switch dryrun
        case true
            msg = '(not really)';
        case false
            msg = '';
    end
    fprintf('Writing to data file "%s"...%s\n', filename, msg)
    
    if ~dryrun
        dataDir = fileparts(filename);
        if ~exist(dataDir,'dir')
            fprintf('Making directory "%s"...',dataDir);
            mkdir(dataDir);
        end
        fid = fopen(filename,'w');
        fprintf(fid,'%s',data);
        fclose(fid);
    end
end
