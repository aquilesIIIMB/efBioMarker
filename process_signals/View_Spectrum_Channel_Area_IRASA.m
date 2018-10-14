%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% View_Spectrum_Channel_Area.m
fprintf('\nVisualizacion del Espectro\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colocar que son se�ales mixtas
if ~registroLFP.analysis_stages.spectral_channel 
    error('Falta el bloque de analisis espectral para cada canal');
    
end

if ~registroLFP.analysis_stages.spectral_area
    fprintf('Visualizacion del espectro de cada canal\n');
    
canales_eval = find(~[registroLFP.channels.removed]);
slash_system = foldername(length(foldername));
largo_canales_eval = size(canales_eval,2);

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

azul = [0 0.4470 0.7410];
rojo = [0.85, 0.325, 0.098];
verde = [0.466, 0.674, 0.188];

%% Graficos de la respuesta en frecuencia y espectrograma
for j = 1:largo_canales_eval 
    
    % Cargar los datos que se mostraran
    Spectrogram = registroLFP.channels(canales_eval(j)).spectrogram.mag;
    freq = registroLFP.channels(canales_eval(j)).spectrogram.frequency;
    time = registroLFP.channels(canales_eval(j)).spectrogram.time;
    
    Spectral_pre = registroLFP.channels(canales_eval(j)).psd.pre;
    Spectral_on = registroLFP.channels(canales_eval(j)).psd.on;
    Spectral_post = registroLFP.channels(canales_eval(j)).psd.post;    
    
    %-------------------Plot---Sectral Frequency---------------------------
    fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
    p1 = plot(freq, db(Spectral_pre, 'power'), 'Color', azul,'LineWidth',3);
    hold on
    p2 = plot(freq, db(Spectral_on, 'power'),'Color', rojo,'LineWidth',3);
    hold on
    p3 = plot(freq, db(Spectral_post, 'power'),'Color', verde,'LineWidth',3);
    xlim([1 100])
    lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('Power [dB]', 'FontSize', 24);
    title(['Power spectral density of LFP ',registroLFP.channels(canales_eval(j)).name,' (',registroLFP.channels(canales_eval(j)).area, ')'], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channels(canales_eval(j)).area,' de ',registroLFP.channels(canales_eval(j)).name,' PSD del LFP'];
    saveas(fig_1,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_1)
    
    %-------------------Plot---Sectral Frequency in Beta [8-20]Hz---------------------------
    fig_3 = figure('units','points','position',[0,0,300,600]);
    quantil_pre = quantile(Spectrogram((time<(pre_m*60.0-30)),:),[.025 .25 .50 .75 .975]);
    quantil_on = quantile(Spectrogram(time>(on_inicio_m*60.0+30) & time<(on_final_m*60.0-30),:),[.025 .25 .50 .75 .975]);
    quantil_post = quantile(Spectrogram(time>(post_m*60.0+30) & time<(tiempo_total*60),:),[.025 .25 .50 .75 .975]);
    plot(freq, db(Spectral_pre, 'power'), 'Color', azul,'LineWidth',3)
    hold on
    plot(freq, db(quantil_pre(1,:), 'power'), ':', 'Color', azul,'LineWidth',1.7);
    hold on
    plot(freq, db(quantil_pre(5,:), 'power'), ':', 'Color', azul,'LineWidth',1.7);
    hold on
    plot(freq, db(Spectral_on, 'power'), 'Color', rojo,'LineWidth',3)
    hold on
    plot(freq, db(quantil_on(1,:), 'power'), ':', 'Color', rojo,'LineWidth',1.7);
    hold on
    plot(freq, db(quantil_on(5,:), 'power'), ':', 'Color', rojo,'LineWidth',1.7);
    hold on
    plot(freq, db(Spectral_post, 'power'), 'Color', verde,'LineWidth',3)
    hold on
    plot(freq, db(quantil_post(1,:), 'power'), ':', 'Color', verde,'LineWidth',1.7);
    hold on
    plot(freq, db(quantil_post(5,:), 'power'), ':', 'Color', verde,'LineWidth',1.7);
    xlim([5 25])
    set(gca,'fontsize',15)
    xlabel('Frequency [Hz]', 'FontSize', 20); %ylabel('Amplitud (dB)', 'FontSize', 24);
    title(['Power spectral density in beta ',registroLFP.channels(canales_eval(j)).name,' (',registroLFP.channels(canales_eval(j)).area, ')'], 'FontSize', 12)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channels(canales_eval(j)).area,' de ',registroLFP.channels(canales_eval(j)).name,' PSD en beta del LFP'];
    saveas(fig_3,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_3)

    %-------------------Plot---Spectrogram------------------------------------
    fig_5 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(db(Spectrogram'+1,'power'),1,numel(Spectrogram)),[5 99]);
    imagesc(time,freq,db(Spectrogram'+1,'power'),clim); colormap(parula(80));
    axis xy
    ylabel('Frequency [Hz]', 'FontSize', 24)
    xlabel('Time [s]', 'FontSize', 24)
    set(gca,'fontsize',20)
    ylim([1 100])
    c=colorbar('southoutside');
    caxis([0, 0.15]); %[0, 30] [-10, 10] [-20, 15] [-15, 20]
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    title(['Spectrogram multitaper of LFP ',registroLFP.channels(canales_eval(j)).name,' (',registroLFP.channels(canales_eval(j)).area, ')'], 'FontSize', 24)
    ylabel(c,'Power [dB]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Area ',registroLFP.channels(canales_eval(j)).area,' Espectrograma Multitaper del LFP de ',registroLFP.channels(canales_eval(j)).name];
    saveas(fig_5,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_5)

end

else
    fprintf('Visualizacion del espectro por area\n');
    
canales_eval = find(~[registroLFP.channels.removed]);
slash_system = foldername(length(foldername));

pre_m = registroLFP.times.pre_m;
on_inicio_m = registroLFP.times.start_on_m;
on_final_m = registroLFP.times.end_on_m;
post_m = registroLFP.times.post_m;
tiempo_total = registroLFP.times.end_m;

azul = [0 0.4470 0.7410];
rojo = [0.85, 0.325, 0.098];
verde = [0.466, 0.674, 0.188];

%factor = [factor_reg_total.FactorReg_NoLesion(5,:),factor_reg_total.FactorReg_Lesion(5,:)];
%factor = [regLFP.areas(:).factorReg]'.*0+1;
factor = [regLFP.areas(:).factorReg]';

[C,ia,ic] = unique({registroLFP.channels(canales_eval).area},'stable');

%% Calculos para el analisis del promedio de las Areas
for m = 1:length(ia) 
    i = ia(m);
    
    % Cargar los datos que se mostraran
    Spectrogram_mixed_mean = registroLFP.average_spectrum(m).spectrogram.mixed.mag.*factor(m);
    Mean_Spectrogram_mixed_pre_mean = registroLFP.average_spectrum(m).spectrogram.mixed.mean_mag_pre; 
    Desv_Spectrogram_mixed_pre_mean = registroLFP.average_spectrum(m).spectrogram.mixed.std_mag_pre; 
    
    Spectrogram_osci_mean = registroLFP.average_spectrum(m).spectrogram.oscillations.mag.*factor(m);
    Mean_Spectrogram_osci_pre_mean = registroLFP.average_spectrum(m).spectrogram.oscillations.mean_mag_pre; 
    Desv_Spectrogram_osci_pre_mean = registroLFP.average_spectrum(m).spectrogram.oscillations.std_mag_pre; 
    
    Spectrogram_frac_mean = registroLFP.average_spectrum(m).spectrogram.fractals.mag.*factor(m);
    Mean_Spectrogram_frac_pre_mean = registroLFP.average_spectrum(m).spectrogram.fractals.mean_mag_pre; 
    Desv_Spectrogram_frac_pre_mean = registroLFP.average_spectrum(m).spectrogram.fractals.std_mag_pre; 
    
    beta_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.beta; 
    t_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.time;
    f_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.frequency;  
    idx_spect_artifacts = registroLFP.average_spectrum(m).spectrogram.ind_artifacts; 

    % Datos de los PSD promedio
    Spectral_mixed_pre_mean = registroLFP.average_spectrum(m).psd.mixed.pre.*factor(m);
    Spectral_mixed_on_mean = registroLFP.average_spectrum(m).psd.mixed.on.*factor(m);
    Spectral_mixed_post_mean = registroLFP.average_spectrum(m).psd.mixed.post.*factor(m);
    
    Spectral_osci_pre_mean = registroLFP.average_spectrum(m).psd.oscillations.pre.*factor(m);
    Spectral_osci_on_mean = registroLFP.average_spectrum(m).psd.oscillations.on.*factor(m);
    Spectral_osci_post_mean = registroLFP.average_spectrum(m).psd.oscillations.post.*factor(m);
    
    Spectral_frac_pre_mean = registroLFP.average_spectrum(m).psd.fractals.pre.*factor(m);
    Spectral_frac_on_mean = registroLFP.average_spectrum(m).psd.fractals.on.*factor(m);
    Spectral_frac_post_mean = registroLFP.average_spectrum(m).psd.fractals.post.*factor(m);
    
    % Spectrogramas normalizados
    Spectrogram_mixed_mean_norm = (Spectrogram_mixed_mean-ones(size(Spectrogram_mixed_mean))*diag(Mean_Spectrogram_mixed_pre_mean))./(ones(size(Spectrogram_mixed_mean))*diag(Desv_Spectrogram_mixed_pre_mean));
    Spectrogram_osci_mean_norm = (Spectrogram_osci_mean-ones(size(Spectrogram_osci_mean))*diag(Mean_Spectrogram_osci_pre_mean))./(ones(size(Spectrogram_osci_mean))*diag(Desv_Spectrogram_osci_pre_mean));
    Spectrogram_frac_mean_norm = (Spectrogram_frac_mean-ones(size(Spectrogram_frac_mean))*diag(Mean_Spectrogram_frac_pre_mean))./(ones(size(Spectrogram_frac_mean))*diag(Desv_Spectrogram_frac_pre_mean));
            
    % Indices de cada etapa
    idx_pre = find(t_Spectrogram_mean<(pre_m*60.0-5));
    idx_on = find(t_Spectrogram_mean>(on_inicio_m*60.0+5) & t_Spectrogram_mean<(on_final_m*60.0-5));
    idx_post = find(t_Spectrogram_mean>(post_m*60.0+5) & t_Spectrogram_mean<(tiempo_total*60));
    
    % Separacion por etapas el espectrograma  
    Spectrogram_mixed_pre_mean = Spectrogram_mixed_mean(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
    Spectrogram_mixed_on_mean = Spectrogram_mixed_mean(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
    Spectrogram_mixed_post_mean = Spectrogram_mixed_mean(idx_post(~ismember(idx_post, idx_spect_artifacts)),:);
    
    Spectrogram_osci_pre_mean = Spectrogram_osci_mean(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
    Spectrogram_osci_on_mean = Spectrogram_osci_mean(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
    Spectrogram_osci_post_mean = Spectrogram_osci_mean(idx_post(~ismember(idx_post, idx_spect_artifacts)),:);
    
    Spectrogram_frac_pre_mean = Spectrogram_frac_mean(idx_pre(~ismember(idx_pre, idx_spect_artifacts)),:);
    Spectrogram_frac_on_mean = Spectrogram_frac_mean(idx_on(~ismember(idx_on, idx_spect_artifacts)),:);
    Spectrogram_frac_post_mean = Spectrogram_frac_mean(idx_post(~ismember(idx_post, idx_spect_artifacts)),:);
    %% Grafico del promedio de todos los canales    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
    p1 = plot(f_Spectrogram_mean, Spectral_osci_pre_mean, 'Color', azul,'LineWidth',6);
    hold on
    p2 = plot(f_Spectrogram_mean, Spectral_osci_on_mean,'Color', rojo,'LineWidth',6);
    hold on
    p3 = plot(f_Spectrogram_mean, Spectral_osci_post_mean,'Color', verde,'LineWidth',6);
    xlim([0 40])
    ylim([-5 50])
    lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim','Location','southoutside','Orientation','horizontal');
    lgd.FontSize = 35;
    set(gca,'fontsize',35)
    xlabel('Frequency [Hz]', 'FontSize', 35); ylabel('Power [W/Hz]', 'FontSize', 35)
    title(['Oscillation PSD of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Oscilacion PSD de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Registros',slash_system,'Promedio ',C{ic(i)},' Oscilacion PSD de los LFP '];
    saveas(fig_2,name_figure_save,'png');
    saveas(fig_2,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_2)
    
   
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_10 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(Spectrogram_osci_mean',1,numel(Spectrogram_osci_mean)),[5 99]);
    imagesc(t_Spectrogram_mean,f_Spectrogram_mean,Spectrogram_osci_mean',clim); 
    cmap = colormap(parula(80));
    axis xy
    ylabel('Frequency [Hz]', 'FontSize', 24)
    xlabel('Time [s]', 'FontSize', 24)
    set(gca,'fontsize',20)
    ylim([0 100])
    %xlim([0 300])
    c=colorbar('southoutside');
    caxis([0 70])
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    title(['Oscillation spectrogram of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    ylabel(c,'Power [W/Hz]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Espectrograma de Oscilaciones de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Promedio ',C{ic(i)},' Espectrograma de Oscilaciones de los LFP '];
    saveas(fig_10,name_figure_save,'png');
    saveas(fig_10,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_10)
        
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
    p1 = plot(t_Spectrogram_mean, sum(Spectrogram_osci_mean(:,(f_Spectrogram_mean>=8 & f_Spectrogram_mean<=30)),2), 'Color', azul,'LineWidth',3);
    %hold on
    %p2 = plot(f_Spectrogram_mean, Spectral_osci_on_mean,'Color', rojo,'LineWidth',3);
    %hold on
    %p3 = plot(f_Spectrogram_mean, Spectral_osci_post_mean,'Color', verde,'LineWidth',3);
    xlim([0 max(registroLFP.times.steps_m)*60])
    ylim([-100 1500])
    %lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    %lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Time [s]', 'FontSize', 24); ylabel('Power [W/Hz]', 'FontSize', 24)
    title(['Oscillatory Power in PK beta band of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio Acumulativo ',C{ic(i)},' Oscilacion PSD de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Acumulativo Promedio ',C{ic(i)},' Oscilacion PSD de los LFP '];
    saveas(fig_2,name_figure_save,'png');
    saveas(fig_2,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_2)
    
    
    % Mixto
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_28 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(Spectrogram_mixed_mean',1,numel(Spectrogram_mixed_mean)),[5 99]);
    imagesc(t_Spectrogram_mean,f_Spectrogram_mean,Spectrogram_mixed_mean',clim); 
    cmap = colormap(parula(80));
    axis xy
    ylabel('Frequency [Hz]', 'FontSize', 24)
    xlabel('Time [s]', 'FontSize', 24)
    set(gca,'fontsize',20)
    ylim([0 100])
    %xlim([0 300])
    c=colorbar('southoutside');
    caxis([0 70])
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    title(['Mixed activity spectrogram of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    ylabel(c,'Power [W/Hz]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Espectrograma de Mixto de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Promedio ',C{ic(i)},' Espectrograma de Mixto de los LFP '];
    saveas(fig_28,name_figure_save,'png');
    saveas(fig_28,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_28)
    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
    p1 = plot(t_Spectrogram_mean, sum(Spectrogram_mixed_mean(:,(f_Spectrogram_mean>=8 & f_Spectrogram_mean<=30)),2), 'Color', azul,'LineWidth',3);
    %hold on
    %p2 = plot(f_Spectrogram_mean, Spectral_osci_on_mean,'Color', rojo,'LineWidth',3);
    %hold on
    %p3 = plot(f_Spectrogram_mean, Spectral_osci_post_mean,'Color', verde,'LineWidth',3);
    xlim([0 max(registroLFP.times.steps_m)*60])
    ylim([-100 4000])
    %lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    %lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('Power [W/Hz]', 'FontSize', 24)
    title(['Mixed Power in PK beta band of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio Acumulativo ',C{ic(i)},' Mixto PSD de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Acumulativo Promedio ',C{ic(i)},' Mixto PSD de los LFP '];
    saveas(fig_2,name_figure_save,'png');
    saveas(fig_2,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_2)
    
    % Scale free o arrhythmic signals
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_12 = figure('units','normalized','outerposition',[0 0 1 1]);
    p1 = plot(f_Spectrogram_mean, Spectral_frac_pre_mean, 'Color', azul,'LineWidth',3);
    %hold on
    %p2 = plot(f_Spectrogram_mean, Spectral_frac_on_mean,'Color', rojo,'LineWidth',3);
    %hold on
    %p3 = plot(f_Spectrogram_mean, Spectral_frac_post_mean,'Color', verde,'LineWidth',3);
    xlim([0 60])
    ylim([0 70])
    %lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    %lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('Power [W/Hz]', 'FontSize', 24)
    title(['Scale-free activity PSD of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Arrhythmic activity PSD de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Promedio ',C{ic(i)},' Arrhythmic activity PSD de los LFP '];
    saveas(fig_12,name_figure_save,'png');
    saveas(fig_12,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_12)
 
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_18 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(Spectrogram_frac_mean',1,numel(Spectrogram_frac_mean)),[5 99]);
    imagesc(t_Spectrogram_mean,f_Spectrogram_mean,Spectrogram_frac_mean',clim); 
    cmap = colormap(parula(80));
    axis xy
    ylabel('Frequency [Hz]', 'FontSize', 24)
    xlabel('Time [s]', 'FontSize', 24)
    set(gca,'fontsize',20)
    ylim([0 100])
    %xlim([0 300])
    c=colorbar('southoutside');
    caxis([0 70])
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','white','LineWidth',3.5,'Marker','.','LineStyle','-');
    title(['Scale-free activity spectrogram of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    ylabel(c,'Power [W/Hz]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Espectrograma Arrhythmic activity de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Promedio ',C{ic(i)},' Espectrograma Arrhythmic activity de los LFP '];
    saveas(fig_18,name_figure_save,'png');
    saveas(fig_18,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_18)
    
    %-------------------Plot---Mean Sectral Frequency---------------------------
    fig_2 = figure('units','normalized','outerposition',[0 0 1 1]);
    p1 = plot(t_Spectrogram_mean, sum(Spectrogram_frac_mean(:,(f_Spectrogram_mean>=8 & f_Spectrogram_mean<=30)),2), 'Color', azul,'LineWidth',3);
    %hold on
    %p2 = plot(f_Spectrogram_mean, Spectral_osci_on_mean,'Color', rojo,'LineWidth',3);
    %hold on
    %p3 = plot(f_Spectrogram_mean, Spectral_osci_post_mean,'Color', verde,'LineWidth',3);
    xlim([0 max(registroLFP.times.steps_m)*60])
    ylim([-100 4000])
    %lgd = legend([p1 p2 p3], 'pre-stim', 'on-stim', 'post-stim');
    %lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('Power [W/Hz]', 'FontSize', 24)
    title(['Scale-free activity Power in PK beta band of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio Acumulativo ',C{ic(i)},' Arrhythmic PSD de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Acumulativo Promedio ',C{ic(i)},' Arrhythmic PSD de los LFP '];
    saveas(fig_2,name_figure_save,'png');
    saveas(fig_2,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_2)
    
    % Contraste entre sennal mixta y sennal fractal
    fig_20 = figure('units','normalized','outerposition',[0 0 1 1]);
    semilogy(f_Spectrogram_mean, Spectral_mixed_pre_mean,'Color', azul,'LineWidth',3);  
    hold on
    semilogy(f_Spectrogram_mean, Spectral_frac_pre_mean,'k','LineWidth',3); 
    xlim([0 100])
    ylim([10^-5.5 10^-0.1].*factor(m))
    lgd = legend('mixed', 'scale-free activity');
    lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('Log PSD [W/Hz]', 'FontSize', 24)
    title(['Mixed and Scale-free activity PSD of Pre-stim LFPs in area ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Mixto y Arrhythmic activity (1)pre-stim de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Promedio ',C{ic(i)},' Mixto y Arrhythmic activity (1)pre-stim de los LFP '];
    saveas(fig_20,name_figure_save,'png');
    saveas(fig_20,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_20)
    
    fig_22 = figure('units','normalized','outerposition',[0 0 1 1]);
    semilogy(f_Spectrogram_mean, Spectral_mixed_on_mean,'Color', rojo,'LineWidth',3); 
    hold on
    semilogy(f_Spectrogram_mean, Spectral_frac_on_mean,'k','LineWidth',3);    
    xlim([0 100])
    ylim([10^-5.5 10^-0.1].*factor(m))
    lgd = legend('mixed', 'scale-free activity');
    lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('Log PSD [W/Hz]', 'FontSize', 24)
    title(['Mixed and Scale-free activity PSD of On-stim LFPs in area ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Mixto y Arrhythmic activity (2)on-stim de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Promedio ',C{ic(i)},' Mixto y Arrhythmic activity (2)on-stim de los LFP '];
    saveas(fig_22,name_figure_save,'png');
    saveas(fig_22,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_22)
    
    fig_24 = figure('units','normalized','outerposition',[0 0 1 1]);
    semilogy(f_Spectrogram_mean, Spectral_mixed_post_mean,'Color', verde,'LineWidth',3);
    hold on
    semilogy(f_Spectrogram_mean, Spectral_frac_post_mean,'k','LineWidth',3);   
    xlim([0 100])
    ylim([10^-5.5 10^-0.1].*factor(m))
    lgd = legend('mixed', 'scale-free activity');
    lgd.FontSize = 20;
    set(gca,'fontsize',20)
    xlabel('Frequency [Hz]', 'FontSize', 24); ylabel('Log PSD [W/Hz]', 'FontSize', 24)
    title(['Mixed and Scale-free activity PSD of Post-stim LFPs in area ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Mixto y Arrhythmic activity (3)post-stim de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Promedio ',C{ic(i)},' Mixto y Arrhythmic activity (3)post-stim de los LFP '];
    saveas(fig_24,name_figure_save,'png');
    saveas(fig_24,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_24)
    
    fig_26 = figure('units','normalized','outerposition',[0 0 1 1]);
    plot(t_Spectrogram_mean, smooth(t_Spectrogram_mean, beta_Spectrogram_mean,0.01, 'rloess'),'Color', azul,'LineWidth',3);
    hold on
    line([pre_m*60.0 pre_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_inicio_m*60.0 on_inicio_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([on_final_m*60.0 on_final_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');
    line([post_m*60.0 post_m*60.0], get(gca, 'ylim'),'Color','black','LineWidth',3.5,'Marker','.','LineStyle','-');    
    xlim([0 registroLFP.times.end_m*60])
    ylim([-1 3])
    xlim([0 max(registroLFP.times.steps_m)*60])
    set(gca,'fontsize',20)
    xlabel('Time [s]', 'FontSize', 24); ylabel('Scale-free activity exponent', 'FontSize', 24)
    title(['Scale-free activity exponent of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Promedio ',C{ic(i)},' Exponente de Arrhythmic activity de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Promedio ',C{ic(i)},' Exponente de Arrhythmic activity de los LFP '];
    saveas(fig_26,name_figure_save,'png');
    saveas(fig_26,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_26)
end
    
end

registroLFP.analysis_stages.view_spectrum = 1;

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP regLFP path name_registro foldername inicio_foldername

