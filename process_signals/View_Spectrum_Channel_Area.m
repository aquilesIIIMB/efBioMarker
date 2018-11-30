%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% View_Spectrum_Channel_Area.m
fprintf('\nVisualizacion del Espectro\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colocar que son se�ales mixtas
if ~registroLFP.analysis_stages.spectral_channel_raw
    error('Falta el bloque de analisis espectral para cada canal en bruto');
    
end

if ~registroLFP.analysis_stages.delete_channel
    fprintf('Visualizacion del espectro de cada canal en bruto\n');
    
canales_eval = find(~[registroLFP.channels.removed]);
slash_system = foldername(length(foldername));
largo_canales_eval = size(canales_eval,2);

%% Graficos de la respuesta en frecuencia y espectrograma
for j = 1:largo_canales_eval 
    
    % Cargar los datos que se mostraran
    Spectrogram = registroLFP.channels(canales_eval(j)).spectrogram_raw.mag;
    freq = registroLFP.channels(canales_eval(j)).spectrogram_raw.frequency;
    time = registroLFP.channels(canales_eval(j)).spectrogram_raw.time;    

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
    caxis([0, 25]);
    hold on
    title(['Spectrogram multitaper of LFP raw ',registroLFP.channels(canales_eval(j)).name,' (',registroLFP.channels(canales_eval(j)).area, ')'], 'FontSize', 24)
    ylabel(c,'Power [dB]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,'Spectrograms',slash_system,'Raw',slash_system,'Area ',registroLFP.channels(canales_eval(j)).area,' Espectrograma Multitaper del LFP raw de ',registroLFP.channels(canales_eval(j)).name];
    saveas(fig_5,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_5)

end

elseif registroLFP.analysis_stages.spectral_channel_ref && ~registroLFP.analysis_stages.spectral_area
    fprintf('Visualizacion del espectro de cada canal referenciado\n');
    
canales_eval = find(~[registroLFP.channels.removed]);
slash_system = foldername(length(foldername));
largo_canales_eval = size(canales_eval,2);

%% Graficos de la respuesta en frecuencia y espectrograma
for j = 1:largo_canales_eval 
    
    % Cargar los datos que se mostraran
    Spectrogram = registroLFP.channels(canales_eval(j)).spectrogram_ref.mag;
    freq = registroLFP.channels(canales_eval(j)).spectrogram_ref.frequency;
    time = registroLFP.channels(canales_eval(j)).spectrogram_ref.time;    

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
    caxis([0, 25]);
    hold on
    title(['Spectrogram multitaper of LFP ref ',registroLFP.channels(canales_eval(j)).name,' (',registroLFP.channels(canales_eval(j)).area, ')'], 'FontSize', 24)
    ylabel(c,'Power [dB]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,'Spectrograms',slash_system,'Ref',slash_system,'Area ',registroLFP.channels(canales_eval(j)).area,' Espectrograma Multitaper del LFP ref de ',registroLFP.channels(canales_eval(j)).name];
    saveas(fig_5,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_5)

end

registroLFP.analysis_stages.view_spectrum_ch = 1;

else
    fprintf('Visualizacion del espectro por area\n');
    
canales_eval = find(~[registroLFP.channels.removed]);
slash_system = foldername(length(foldername));

[C,ia,ic] = unique({registroLFP.channels(canales_eval).area},'stable');

%% Calculos para el analisis del promedio de las Areas
for m = 1:length(ia) 
    i = ia(m);
    
    % Cargar los datos que se mostraran
    Spectrogram_mixed = registroLFP.areas(m).spectrogram.mixed.mag;
    Spectrogram_oscillations = registroLFP.areas(m).spectrogram.oscillations.mag;
    Spectrogram_fractals = registroLFP.areas(m).spectrogram.fractals.mag;
    %beta_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.beta; 
    
    idx_spect_artifacts = registroLFP.areas(m).idx_artifacts;
    freq = registroLFP.areas(m).spectrogram.frequency;
    time = registroLFP.areas(m).spectrogram.time;  

    %% Grafico del promedio de todos los canales   
    
    % Mixto
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_28 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(Spectrogram_mixed',1,numel(Spectrogram_mixed)),[5 99]);
    imagesc(time,freq,Spectrogram_mixed',clim); 
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
    title(['Mixed activity spectrogram of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    ylabel(c,'Power [W/Hz]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Area',slash_system,'Promedio ',C{ic(i)},' Espectrograma de Mixto de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Promedio ',C{ic(i)},' Espectrograma de Mixto de los LFP '];
    saveas(fig_28,name_figure_save,'png');
    saveas(fig_28,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_28)
    
    % Osci
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_10 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(Spectrogram_oscillations',1,numel(Spectrogram_oscillations)),[5 99]);
    imagesc(time,freq,Spectrogram_oscillations',clim); 
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
    title(['Oscillation spectrogram of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    ylabel(c,'Power [W/Hz]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Area',slash_system,'Promedio ',C{ic(i)},' Espectrograma de Oscilaciones de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Promedio ',C{ic(i)},' Espectrograma de Oscilaciones de los LFP '];
    saveas(fig_10,name_figure_save,'png');
    saveas(fig_10,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_10)
    
    % Scale free o fractal
    %-------------------Plot---Mean Spectrogram------------------------------------
    fig_18 = figure('units','normalized','outerposition',[0 0 1 1]);
    clim=prctile(reshape(Spectrogram_fractals',1,numel(Spectrogram_fractals)),[5 99]);
    imagesc(time,freq,Spectrogram_fractals',clim); 
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
    title(['Scale-free activity spectrogram of LFPs in area ',C{ic(i)}], 'FontSize', 24)
    ylabel(c,'Power [W/Hz]', 'FontSize', 17)
    set(c,'fontsize',17)
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'Spectrograms',slash_system,'Area',slash_system,'Promedio ',C{ic(i)},' Espectrograma Arrhythmic activity de los LFP '];
    %name_figure_save = ['/home/cmanalisis/Aquiles/Fractales Biomarcador/Imagenes Tesis',slash_system,'Promedio ',C{ic(i)},' Espectrograma Arrhythmic activity de los LFP '];
    saveas(fig_18,name_figure_save,'png');
    saveas(fig_18,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_18)
    
end

registroLFP.analysis_stages.view_spectrum_area = 1; 
    
end

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP regLFP path name_registro foldername inicio_foldername

