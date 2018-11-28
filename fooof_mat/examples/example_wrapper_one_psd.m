%% FOOOF Matlab Wrapper Example - Single PSD

% Load data
%load('dat/ch_dat_one.mat');

% Calculate a power spectrum with Welch's method
%[psd, freqs] = pwelch(ch_dat_one, 500, [], [], s_rate);

mixed = [];
scale_free = [];
osci = [];

psf = [];
dsf = [];
 
for i = [1:600]
    psd = registroLFP.average_spectrum(9).spectrogram.mixed.mag(i,:)';
    %psd = registroLFP.channels(1).spectrogram.mag(1,:)';
    freqs = registroLFP.average_spectrum(9).spectrogram.frequency;
    %freqs = registroLFP.channels(1).spectrogram.frequency';

    % Transpose, to make FOOOF inputs row vectors
    freqs = freqs';
    psd = psd';


    %{
    for i=1:6
        % FOOOF settings
        settings = struct();  % Use defaults
        f_range = [1+10*(i-1), 50+10*(i-1)]; %[1, 50]

        % Run FOOOF
        fooof_results = fooof(freqs, psd, f_range, settings,1);

        % Print out the FOOOF Results
        %fooof_results

        fooof_plot(fooof_results)
    end
    %}

    % FOOOF settings
    settings = struct();  % Use defaults
    f_range = [1, 100]; %[1, 50]

    % Run FOOOF
    try 
        fooof_results = fooof(freqs, psd, f_range, settings,1);
    catch
        % Se usa el anterior
        fooof_results;
    end

    % Print out the FOOOF Results
    %fooof_results

    % Ya esta con log
    %fooof_plot(fooof_results)

    %%figure;
    %%plot(fooof_results.freqs, fooof_results.power_spectrum)
    %%hold on
    %%plot(fooof_results.freqs, fooof_results.fooofed_spectrum)
    %%figure;
    %%plot(fooof_results.freqs, fooof_results.bg_fit)
    %%figure;
    %%plot(fooof_results.freqs, fooof_results.fooofed_spectrum-fooof_results.bg_fit)
    %%ylim([0,1.2])
    
    %%figure;
    %%plot(fooof_results.freqs, fooof_results.power_spectrum-fooof_results.bg_fit)
    %%ylim([-0.8,1.2])
    
    mixed = [mixed; fooof_results.power_spectrum];
    scale_free = [scale_free; fooof_results.bg_fit];
    osci = [osci; fooof_results.power_spectrum-fooof_results.bg_fit];

    x=fooof_results.freqs;
    y=fooof_results.bg_fit;

    %{
    for i = 1:10
        p = polyfit(log(x(1+10*(i-1):10*i)), y((1+10*(i-1):10*i)), 1); % polyfit(log(1:100), log(real), 1);
        m = -1*p(1);
        b = exp(p(2));

        %modelo_eval = b*x.^-m;

        disp('Freq range')
        disp('    ['+string(1+10*(i-1))+'-'+string(10*i)+']')
        disp('Potencia')
        disp(b)
        disp('Pendiente')
        disp(m)
        disp(' ')
    end
    %}

    p = polyfit(log(x), y, 1); 
    m = -1*p(1);
    b = exp(p(2));

    psf = [psf; b];
    dsf = [dsf; m];
    %{
    disp('Freq range')
    disp('    ['+string(f_range(1))+'-'+string(f_range(end))+']')
    disp('Potencia')
    disp(b)
    disp('Pendiente')
    disp(m)
    disp(' ')
    %}
end
 
% Ver si es correcto 10^ o 20^ u otra !!!!!!!!!!!

freq = registroLFP.average_spectrum(9).spectrogram.frequency;
time = registroLFP.average_spectrum(9).spectrogram.time;

osci_new = 10.^mixed - 10.^scale_free;

fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(osci_new'+1,1,numel(osci_new)),[5 99]);
imagesc(time,freq,osci_new'+1,clim); colormap(parula(80));
axis xy
ylabel('Frequency [Hz]', 'FontSize', 24)
xlabel('Time [s]', 'FontSize', 24)
set(gca,'fontsize',20)
ylim([1 100])
c=colorbar('southoutside');
%caxis([0, 0.15]); %[0, 30] [-10, 10] [-20, 15] [-15, 20]


fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
clim=prctile(reshape(10.^scale_free'+1,1,numel(10.^scale_free)),[5 99]);
imagesc(time,freq,10.^scale_free'+1,clim); colormap(parula(80));
axis xy
ylabel('Frequency [Hz]', 'FontSize', 24)
xlabel('Time [s]', 'FontSize', 24)
set(gca,'fontsize',20)
ylim([1 100])
c=colorbar('southoutside');
%caxis([0, 0.15]); %[0, 30] [-10, 10] [-20, 15] [-15, 20]

figure
% Var Po theta
subplot(3,3,1)
plot(sum(osci_new(:,8:16),2))

% Var Po alpha
subplot(3,3,2)
plot(sum(osci_new(:,16:24),2))

% Var Po beta
subplot(3,3,3)
plot(sum(osci_new(:,24:60),2))

% Var Po gamma
subplot(3,3,5)
plot(sum(osci_new(:,60:120),2))

% Var Psf
subplot(3,3,7)
plot(sum(10.^scale_free,2))

% Var D
subplot(3,3,8)
plot(dsf)

% Freq Dom
subplot(3,3,9)
[~,I] = max(osci_new,[],2);
dom_freq = freq(I);
plot(dom_freq)
median(dom_freq)

