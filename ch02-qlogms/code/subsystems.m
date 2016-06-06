
w  = logspace(-1.5,1.5,200);
FRF = @(sys) squeeze(freqresp(sys, w));

G1 = tf(1,[1 1]);
G2 = tf(1,[1 0.05 1]);

%%
figure;
hAx(1) = subplot(1,2,1);
plot(w, db(FRF(G1)), 'LineWidth', 2,'Color', tango('blue',3))
set(gca,'XScale','log')


hAx(2) = subplot(1,2,2);
plot(w, db(FRF(G2)), 'LineWidth', 2,'Color', tango('blue',3))
set(gca,'XScale','log')

set(hAx,'YLim',[-30,30],'XLim',[min(w) max(w)],'Visible','off','Color','none')

