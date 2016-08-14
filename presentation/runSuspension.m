addpath(fullfile(fileparts(mfilename('full')),'code'));

sim('suspension.slx');
data = sldemo_suspn_output;

h = data.get('h'); h = h.Values;
z = data.get('Z'); z = z.Values;
t = h.Time;
h = h.Data;
z = z.Data;

%% plots
figure;
tocm = @(x) x*100;
hAx(2) = subplot(2,1,2);
plot(t, tocm(h),'Color',tango('purple',3));
xlabel('');
ylabel('h [cm]');
title('')
set(gca,'YTick',[0 1]);
ylim(gca,[-0.1 1.1]);

hAx(1) = subplot(2,1,1);
plot(t, tocm(-z),'Color',tango('red',2));
ylabel('x [cm]');
title('')
set(gca,'YTick',[12 13])
set(get(gca,'YLabel'),'Rotation',90)
ylim(gca,[11.9 round((max(tocm(-z))+0.1)/0.1)*0.1]);

set(hAx,'box','off')

set(findobj(gcf,'type','line'), 'LineWidth', 3)
set(hAx,'Color','none')
xlabel(hAx(2),'Time [s]');


%% export
matlab2tikz('suspn.tex','width','7cm','height','5cm')

%% 
% use Simulink Linearization Tool to export SS model h->z
if ~exist('linsys2','var')
    linsys2 = tf(NaN);
end
f = logspace(-1, 1, 100);
w = 2*pi*f;
FRF = squeeze(freqresp(linsys2, w));

figure;
plot(f, db(FRF),'LineWidth', 3,'Color', tango('blue',2));
set(gca,'XScale','log');
ylabel('|G| [dB]');
xlabel('Frequency [Hz]');
set(gca,'Color','none');

matlab2tikz('bode.tex','width','7cm','height','5cm')

%% plot sine
figure;

idx = find(abs(FRF) == max(abs(FRF)),1);
f0  = f(idx);
k = 2; % extra scaling

hAx(1) = subplot(2,1,1);
plot(t, k*2*real(-(FRF(idx))*sin(2*pi*f0*t)),'Color',tango('red',2));
ylabel('x [cm]');
title('')

hAx(2) = subplot(2,1,2);
plot(t, sin(2*pi*f0*t),'Color',tango('purple',3));
xlabel('');
ylabel('h [cm]');
title('')

set(hAx,'box','off')
set(hAx,'YLim',k*[-1.5 1.5])

set(findobj(gcf,'type','line'), 'LineWidth', 3)
set(hAx,'Color','none')
xlabel(hAx(2),'Time [s]');

matlab2tikz('sines.tex','width','7cm','height','5cm');
