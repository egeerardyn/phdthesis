w = unique(round(logspace(log10(1),log10(1000),50)));
w = w(mod(w,2)~=0);

makeNLinCombo = @(w, ord) unique(sum(combnk(unique([w(:); -w(:)].'), ord),2));
plotStems = @(w,ord,varargin) stem(w(w>0), 1/ord*ones(size(w(w>0))), 'DisplayName',num2str(ord), varargin{:});

w1 = makeNLinCombo(w, 1);
w2 = makeNLinCombo(w, 2);
w3 = makeNLinCombo(w, 3);
w4 = makeNLinCombo(w, 4);

%%
figure; hold all;
plotStems(w1, 1);
plotStems(w2, 2);
plotStems(w3, 3);
plotStems(w4, 4);
set(gca,'XScale','log')
