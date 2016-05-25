function [ str ] = processTikzFile( filename , isInteractive)
    %PROCESSTIKZFILE Summary of this function goes here
    %   Detailed explanation goes here
    
    if ~exist('isInteractive','var')
        isInteractive = true;
    end
    
    str = fileread(filename);
    [pathPart, namePart, ext] = fileparts(filename);
    basename ='';
    str = coordinatesToTable(str);
    
    str = externalizeTables(str, @dataFile, @relativeDataPath);
    
    % write out file
    fid = fopen(filename,'w');
    fprintf(fid,'%s',str);
    fclose(fid);
    
    %% subfunctions
    function str = dataFile(idx, prevPart)
        if isInteractive
            fprintf(2,'%s\n',prevPart);
            basename = input('What filename do you want for this data? ','s');
        else
            basename = sprintf('dat%03d.tsv',idx);
        end
        str= fullfile(pathPart,'..','data',namePart,basename);
    end
    function str = relativeDataPath(idx, prevPart)
        str =  sprintf('\\thisDir/data/%s/%s',namePart, basename);
    end
end


