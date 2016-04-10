function [ parts ] = extractDataSegments( str , BEGINTOKEN, ENDTOKEN)
    %EXTRACTDATASEGMENTS splits a string into segments separated by TOKENS
    %
    % The second column are the data segments (in-between the tokens)
    % The first column is everything else
    
    idxStart   = strfind(str,BEGINTOKEN);
    idxStopAll = strfind(str,ENDTOKEN);
    
    
    [idxStart, idxStop] = findDataSegments(idxStart, idxStopAll);
    idx = makeIndexRanges(idxStart, idxStop, numel(ENDTOKEN), numel(str));
    
    parts = cellfun(@(idx) str(idx), idx, 'Un', false);
end


function [idxStart, idxStop] = findDataSegments(idxStart, idxStopAll)
    % find first occurrence of END token after each BEGIN token
    idxStop = idxStart;
    for iPart = 1:numel(idxStart);
        idxStop(iPart) = idxStopAll(find(idxStopAll>idxStart(iPart), 1));
    end
end
function idx = makeIndexRanges(idxStart, idxStop, nEnd, totalLength)
    nDataSegments = numel(idxStart);
    idx = cell(nDataSegments+1,2);
    
    idx1Start = [1 idxStop+nEnd+1];
    idx1Stop  = [idxStart-1 totalLength];
    
    EMPTY     = totalLength;
    idx2Start = [idxStart EMPTY+1];
    idx2Stop  = [idxStop+nEnd EMPTY];
    
    idx(:,1) = arrayfun(@(a,b) a:b, idx1Start, idx1Stop, 'UniformOutput', false)';
    idx(:,2) = arrayfun(@(a,b) a:b, idx2Start, idx2Stop, 'UniformOutput', false)';
end
