% This script iterates over all TSV files in the current directory
% and uses `simplifyTsv` to reduce their size.
%
close all;
clear variables;
clc;

file     = dir('*.tsv');
doSave   = true;
oneByOne = true;

for iFile = 1:numel(file);
    simplifyTsv(file(iFile).name, doSave);
    
    if oneByOne
        pause(1);
        close(gcf)
    end
end

