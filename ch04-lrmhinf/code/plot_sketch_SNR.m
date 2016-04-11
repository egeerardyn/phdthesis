addpath(fullfile(pwd, '..','..','code'));
ccc;

doSave = false;

G0 = tf([1],[1 0.5 1]);
scale = norm(G0,Inf);
G0 = G0/scale;
SP = SamplingProp('N',512,'Ts',1);

U     = ones(size(SP.w));
Y     = squeeze(freqresp(G0,SP.w));

noise = randn(size(SP.t))*0.001/scale;
Noise = fft(noise);

figure;
hold all;
plot(SP.w_pos, db(Y(SP.sel_pos)), '.-',...
     'DisplayName' ,'System', 'LineWidth',2,'Color','k');
plot(SP.w_pos, db(Noise(SP.sel_pos)),...
     '.:','DisplayName','Noise','MarkerSize',8,...
     'Color',[0.5 0.5 0.5]);

if doSave
    dataPath = fullfile('..','data','sketch-SNR');
    if ~exist(dataPath, 'dir')
        mkdir(dataPath);
    end
    matlab2tikz(fullfile('..','figs','sketch-SNR.tikz'), ...
                'width','\figurewidth',...
                'height','\figureheight',...
                'standalone',false,...
                'externalData',true,...
                'dataPath', dataPath,...
                'relativeDataPath', strrep(dataPath, '..','\thisDir'));
end
    
