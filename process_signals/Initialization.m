%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Initialization.m
fprintf('\nInicializacion\n')
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear registroLFP % Se elimina el registro cargado en el workspace

% Tipo de referenciacion
reference_type = 'area'; % 'none', 'general', 'area'
% Amplitud del umbral para remover artefactos
threshold_amplitudes = 14; % 

% Verificacion de los Parametros
fprintf('\n***Evaluation of parameters *** \n');
fprintf('__Chosen Parameters:\n\n');
fprintf('Path:\n\t%s\n', path);
pause(1)
fprintf('Coding of each channel:\n\t%s\n', channel_codes);
pause(1)
% Se carga la codficiacion del canal
T = readtable(channel_codes);
fprintf('Available Channels:\n');
fprintf('\tChannel\t\tArea\n');
for k = 1:length(eval_channels)
    fprintf('\t %s\t\t %s\n',T.Channel{(eval_channels(k))},T.Area{(eval_channels(k))});
end
pause(2)
fprintf('Reference type:\n\t%s\n', upper(reference_type));
pause(1)
fprintf('Threshold amplitudes to reject artifacts:\n\t%d \n', threshold_amplitudes);
pause(1)

% Confirma que los parametros estan correctos
try
    confirmation = input('Are the parameters Ok?[Press Enter]:  ','s');
catch
    error('Check the parameters');
end
if ~isempty(confirmation)    
    error('Check the parameters');
else
    fprintf('\nEVERYTHING READY TO BEGIN THE ANALYSIS :D\n\n');
end

%% Inicializacion de la estructura
clear registroLFP
% Datos base
registroLFP.name = [];
registroLFP.open_ephys = [];
registroLFP.channel_codes = channel_codes;
registroLFP.reference_type = reference_type;
registroLFP.sampleRate = []; % Tasa de muestreo de los registros
registroLFP.desired_fs = 1000;
registroLFP.freq_sin_artifacts = 110; % Frecuencia de la sinusoide que reemplaza a los artefactos
registroLFP.amp_threshold = threshold_amplitudes;

% Datos del filtro
registroLFP.filter_param(1).type = 'lowpassiir';
registroLFP.filter_param(1).design_method = 'butter'; 
registroLFP.filter_param(1).n = 15; % grado del filtro
registroLFP.filter_param(1).fc = 150; 
registroLFP.filter_param(1).fs = registroLFP.sampleRate;  
registroLFP.filter_param(2).type = 'highpassiir';
registroLFP.filter_param(2).design_method = 'butter';
registroLFP.filter_param(2).n = 15; % grado del filtro
registroLFP.filter_param(2).fc = 1; 
registroLFP.filter_param(2).fs = registroLFP.desired_fs; 

% Datos para el tiempo 
dir_pulse = dir([path,'10*_ADC8.continuous']);

% Si existe el ADC8 con los pulsos de estimulacion
if exist(strcat(path, dir_pulse.name),'file') && ~isempty(dir_pulse)
    [data, timestamps, info] = load_open_ephys_data_faster(strcat(path, dir_pulse.name));
    time_max_reg_seg = length(data) / info.header.sampleRate;
    time_step_s = linspace(0,time_max_reg_seg,length(data)); % minutos
        
    pulse_rect = data>0;
    deriv_pulse = diff(pulse_rect);
    idx_change_pulse = find(deriv_pulse~=0)+1;
    
    % Si los pulsos de estimulacion estan correctos
    if ~isempty(idx_change_pulse)
        
        fin_pre = idx_change_pulse(1);
        inicio_post = idx_change_pulse(end)-1;
        inicio_stim = idx_change_pulse(2)-1;
        fin_stim = idx_change_pulse(end-1);

        tinicial = time_step_s(fin_pre);
 
        if length(idx_change_pulse) > 10
            fprintf('STIMULATION FREQUENCY!!!: %.2fHz\n\n', 1/median(diff(time_step_s(deriv_pulse>0))))
        else
            fprintf('STIMULATION FREQUENCY!!!: Inf (DC)\n\n')
        end
        
    else
        while 1
            try
                stimOnset_time = input('Stimulation onset time?(s):  ');
            catch
                continue;
            end

            if isnumeric(stimOnset_time)
                tinicial = stimOnset_time;               
                break
                
            end
        end
        
    end
    
else 
    while 1
        try
            stimOnset_time = input('Stimulation onset time?(s):  ');
        catch
            continue;
        end

        if isnumeric(stimOnset_time)
            tinicial = stimOnset_time;
            break
            
        end
    end
end
    

% Definiciones de tiempo y sus rangos de las fases
registroLFP.times.extra_time_s = tinicial;
registroLFP.times.total_recorded_m = []; % tiempo de duracion del registro
registroLFP.times.steps_m = [];

% Datos de los parametros usados para calcular los multitapers (Chronux)
registroLFP.multitaper_param.spectrogram.params.tapers = ([3 5]); % [TW K], (K <= to 2TW-1)
registroLFP.multitaper_param.spectrogram.params.pad = 2; % Cantidad de puntos multiplos de dos sobre el largo de la sennal
registroLFP.multitaper_param.spectrogram.params.Fs = registroLFP.desired_fs; % Frecuencia de muestreo
registroLFP.multitaper_param.spectrogram.params.fpass = [1 100]; % Rango de frecuencias
registroLFP.multitaper_param.spectrogram.params.err = 0; % Error considerado
registroLFP.multitaper_param.spectrogram.params.trialave = 0; % Se calcula el promedio de todos los canales o intentos dentro del archivo de entrada

% Datos para definir el ventaneo y avance de las ventanas en multitaper
registroLFP.multitaper_param.spectrogram.movingwin.window = 2; % Ventanas (En segundos)
registroLFP.multitaper_param.spectrogram.movingwin.winstep = registroLFP.multitaper_param.spectrogram.movingwin.window/2; % Pasos de ventanas (segundos)

% Identificadores de las etapas que se han hecho y las que quedan
registroLFP.analysis_stages.initialization = 0;
registroLFP.analysis_stages.extract_lfp = 0;
registroLFP.analysis_stages.spectral_channel_raw = 0;
registroLFP.analysis_stages.delete_channel = 0;
registroLFP.analysis_stages.referencing = 0;
registroLFP.analysis_stages.spectral_channel_ref = 0;
registroLFP.analysis_stages.view_lfp_ch = 0;
registroLFP.analysis_stages.view_spectrum_ch = 0;
registroLFP.analysis_stages.spectral_area = 0;
registroLFP.analysis_stages.view_spectrum_area = 0; 

% Datos de los canales
registroLFP.channels.name = [];
registroLFP.channels.area = [];
registroLFP.channels.data_ref = [];
registroLFP.channels.data_raw = [];
registroLFP.channels.spectrogram_ref = [];
registroLFP.channels.spectrogram_raw = [];
registroLFP.channels.removed = [];
registroLFP.channels.idx_artifacts = [];

% Datos de cada espectrograma de los canales 
registroLFP.channels.spectrogram_ref.mag = [];
registroLFP.channels.spectrogram_ref.time = [];
registroLFP.channels.spectrogram_ref.frequency = [];  
registroLFP.channels.spectrogram_raw.mag = [];
registroLFP.channels.spectrogram_raw.time = [];
registroLFP.channels.spectrogram_raw.frequency = []; 

% Datos de las areas 
registroLFP.areas.name = [];
registroLFP.areas.spectrogram = [];
registroLFP.areas.idx_artifacts = [];

% Datos de los espectrogramas de las areas
registroLFP.areas.spectrogram.mixed.mag = [];
registroLFP.areas.spectrogram.oscillations.mag = [];
registroLFP.areas.spectrogram.fractals.mag = [];
registroLFP.areas.spectrogram.time = [];
registroLFP.areas.spectrogram.frequency = [];  

% Asignacion de los canales y areas que se usaran
[registroLFP.channels(1:64).name] = T.Channel{:}; % Cargar los numeros de los canales
[registroLFP.channels(1:64).area] = T.Area{:}; % Carga los nombres de las areas
[registroLFP.channels(1:64).removed] = deal(1);
[registroLFP.channels(eval_channels).removed] = deal(0);

% Crear carpeta para guardar las imagnes 35:end
slash_backslash = find(path=='\' | path=='/');
inicio_new_dir1 = slash_backslash(length(slash_backslash)-3);
inicio_new_dir2 = slash_backslash(length(slash_backslash)-2);
foldername = path(inicio_new_dir2:length(path)); % /+375/arturo2_2017-06-02_12-58-57/
inicio_foldername = path(1:inicio_new_dir1); % /home/cmanalisis/Aquiles/Registros/
slash_system = foldername(length(foldername));
if ~exist(foldername, 'dir')
    mkdir(inicio_foldername,'Images');
    mkdir([inicio_foldername,'Images'],foldername);
    mkdir([inicio_foldername,'Images', foldername],'LFPs');
    mkdir([inicio_foldername,'Images', foldername],'Spectrograms');
    mkdir([inicio_foldername,'Images', foldername,'LFPs'],'Raw');
    mkdir([inicio_foldername,'Images', foldername,'LFPs'],'Ref');
    mkdir([inicio_foldername,'Images', foldername,'Spectrograms'],'Raw');
    mkdir([inicio_foldername,'Images', foldername,'Spectrograms'],'Ref');
    mkdir([inicio_foldername,'Images', foldername,'Spectrograms'],'Area');
    mkdir([inicio_foldername,'Images', foldername],'SpectralVar');
end

% Definir nombre del archivo .m donde iran las matrices guardadas
inicio_name_registro = slash_backslash(length(slash_backslash)-1);
name_registro = path(inicio_name_registro+1:length(path)-1);
registroLFP.name = name_registro;

% Almacenar imagen del protocolo visto en el ADC8
if exist(strcat(path, dir_pulse.name),'file') && ~isempty(dir_pulse)
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    plot(time_step_s/60, pulse_rect);
    set(gca,'fontsize',20)
    xlim([0 time_step_s(end)/60]);
    xlabel('Time [min]', 'FontSize', 24); ylabel('Amplitude [a.u.]', 'FontSize', 24)
    title(['Signal of ADC8 input'], 'FontSize', 24)

        % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'LFPs',slash_system,'Signal of ADC8 input'];
    saveas(fig,name_figure_save,'png');
    saveas(fig,name_figure_save,'fig');
    close(fig)
end

registroLFP.analysis_stages.initialization = 1;

% Eliminacion de variables que no se guardaran
clearvars -except registroLFP path name_registro foldername inicio_foldername eval_channels

