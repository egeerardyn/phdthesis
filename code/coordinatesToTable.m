function [ str ] = coordinatesToTable( str )
    % Converts Tikz coordinates to table
    
    BEGINTOKEN = 'coordinates{';
    ENDTOKEN   = '}';
    
    parts = extractDataSegments(str, BEGINTOKEN, ENDTOKEN);
    
    %% replace data segments with tables
    nDataSegments = size(parts,1)-1;

    for iData = 1:nDataSegments
        dataStr = parts{iData,2};
        
        EOL = sprintf('\n');
        dataStr = regexprep(dataStr,'\s|\n','');
        dataStr = strrep(dataStr,sprintf(','),sprintf('\t'));
        dataStr = strrep(dataStr,'(','');
        dataStr = strrep(dataStr,')',['\\' EOL]);
        dataStr = strrep(dataStr, BEGINTOKEN, ['table[row sep=crcr]{' EOL]);
        
        parts{iData,2} = dataStr;
    end
    
    str = strjoin(parts','');
end

