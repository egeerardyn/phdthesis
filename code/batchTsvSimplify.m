close all;
clear variables;
clc;

files     = dir('*.tsv');
filenames = arrayfun(@(d) d.name, files, 'UniformOutput', false);
doSave    = false;

for iFile = 1:numel(filenames);
    file = filenames{iFile};
    
    simplifyTsv(file, doSave);
end

