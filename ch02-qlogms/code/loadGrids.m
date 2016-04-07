ccc;

asCell = {'UniformOutput', false};

directory = fullfile('..','data','freqGrid');
output    = @(v) strrep(v, 'freqGrid','gridProps');

files     = dir(fullfile(directory,'*.tsv'));
files     = arrayfun(@(fn) fullfile(directory, fn.name), files, asCell{:});
data      = cellfun(@loadFile, files, asCell{:});

dataFunc = @(f) (@(data) feval(f, data.X, data.Y));

doSave = false;

%% compute power per signal
P = NaN(size(files));
N = NaN(size(files));
scale = NaN(size(files));
for iFile = 1:numel(files)
    D = data{iFile};
    region = D.X <= 1016;
    power = @(Ak) sum(Ak.^2)/numel(Ak);
    
    P(iFile) = power(D.Y(region));
    N(iFile) = numel(D.Y(region));
    scale(iFile) = sqrt(150)./sqrt(P(iFile));
    Ysc = D.Y * scale(iFile);
    Psc = power(Ysc(region));
%     fprintf('%30s\t N = %g \t P = %g \t (scale = %g, Psc = %g)\n', ...
%            files{iFile}, N(iFile), P(iFile), scale(iFile), Psc);
end

%% compute frequency spacing and ratio
computeDelta = @(f) reshape(diff([f(1);f(:)]), size(f));
computeAlpha = @(f) 10.^(computeDelta(log10(f)));

for iFile = 1:numel(files)
    D = data{iFile};
    D.deltaF = computeDelta(D.X);
    D.alphaF = computeAlpha(D.X);
    data{iFile} = D;
end

%% amplitude plot
figure;
hold all;
for iFile = 1:numel(files)
    D = data{iFile};
    region = D.X <= 1016;
    stem(D.X(region), D.Y(region)*scale(iFile)/sqrt(nnz(region)), 'DisplayName', files{iFile})
end

legend('show','Location','NorthEast')
set(gca,'XScale','log');

%% 
figure('Name','Grid properties');
for iFile = 1:numel(files)
    D = data{iFile};
    hAx(1) = subplot(1,2,1); hold all; xlabel('Frequency'); ylabel('\Delta_k f');
    plot(D.X, D.deltaF, '.-', 'DisplayName', files{iFile});
    
    hAx(2) = subplot(1,2,2); hold all; xlabel('Frequency'); ylabel('\Alpha_k - 1');
    plot(D.X, D.alphaF-1,'.-', 'DisplayName', files{iFile});
end

set(hAx,'XScale','log','YScale','log')

%% save tables
if doSave
    for iFile = 1:numel(files)
        D = data{iFile};
        fn = output(files{iFile})
        M = [D.X(:) D.Y(:) D.deltaF(:) D.alphaF(:)-1];
        fid = fopen(fn,'w');
        fprintf(fid, printMatrix(M));
        fclose(fid);
    end
end
