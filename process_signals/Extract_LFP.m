%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Extract_LFP.m
fprintf('\nExtraerLFP\n')
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extraer lfp de los registros de cada canal
if ~registroLFP.analysis_stages.initialization
   error('Falta el bloque de inicializacion') 
end

% Prefijo de los archivos dentro de la ruta, obtiene todos los canales, los
% que se quieren evaluar y los que no
dir_signals = dir([path,'10*_CH*.continuous']);

% Listado de los nombre de los archivos de los LFP
dir_signals = char(natsortfiles({dir_signals.name})); % Ordena los nombres de los archivos correctamente

% Nombre del archivo donde esta el registro de los canales que se desean
ruta_regEval = dir_signals(eval_channels(1),:);
disp(ruta_regEval)

% Obtener la informacion del primer archivo
[data, registroLFP.open_ephys.timestamps, registroLFP.open_ephys.info] = load_open_ephys_data_faster(strtrim([path,ruta_regEval]));

% Tasa de muestreo de los registros
registroLFP.sampleRate = registroLFP.open_ephys.info.header.sampleRate; 
registroLFP.filter_param(1).fs = registroLFP.sampleRate; 

% Disenno del filtro pasa banda
Hd_low = designfilt(registroLFP.filter_param(1).type,'FilterOrder',registroLFP.filter_param(1).n, ...
'HalfPowerFrequency',registroLFP.filter_param(1).fc,'DesignMethod',registroLFP.filter_param(1).design_method,'SampleRate',registroLFP.filter_param(1).fs);

% Filtrado del primer LFP
data_filt = filtfilt(Hd_low, data);

% Downsamplear el primer LFP para llevar los registros a la tasa de muestro requerida
data_downS = downsample(data_filt,registroLFP.sampleRate/registroLFP.desired_fs);

% Filtro pasa alto despues de downsamplin debido a la baja Fc
Hd_high = designfilt(registroLFP.filter_param(2).type,'FilterOrder',registroLFP.filter_param(2).n, ...
'HalfPowerFrequency',registroLFP.filter_param(2).fc,'DesignMethod',registroLFP.filter_param(2).design_method,'SampleRate',registroLFP.filter_param(2).fs);

data_downS_filtHigh = filtfilt(Hd_high, data_downS);

% Tiempo maximo de registro
time_max_reg_seg = length(data)/registroLFP.sampleRate;
registroLFP.times.total_recorded_m = time_max_reg_seg/60.0;

% Tiempo total en minutos de lo registrado
time_step_m = linspace(0,time_max_reg_seg/60,length(data_downS_filtHigh)); % minutos

% Intervalo de tiempo total del protocolo
registroLFP.times.steps_m = time_step_m;
  
% Almacenamiento de los LFP en la estructura
registroLFP.channels(eval_channels(1)).data_raw = data_downS_filtHigh;

tic;
for i = 2:length(eval_channels) 

    % Nombre del archivo donde esta el registro
    ruta_regEval = dir_signals(eval_channels(i),:);
    disp(ruta_regEval)
    
    % Obtener la informacion del archivo "i"
    [data, ~, ~] = load_open_ephys_data_faster(strtrim([path,ruta_regEval]));
    
    % Filtrado del LFP "i"
    %data_filt = filter(Hd,data);
    data_filt = filtfilt(Hd_low, data);
    
    % Downsamplear el LFP "i" para llevar los registros a la tasa de muestro requerida
    data_downS = downsample(data_filt,registroLFP.sampleRate/registroLFP.desired_fs);
    
    % Filtro pasa alto despues de downsamplin debido a la baja Fc
    data_downS_filtHigh = filtfilt(Hd_high, data_downS);

    % Almacenamiento de los LFP en la estructura
    registroLFP.channels(eval_channels(i)).data_raw = data_downS_filtHigh;

        
end
toc;

registroLFP.analysis_stages.extract_lfp = 1;

% Eliminacion de variables que no se guardaran
clearvars -except registroLFP path name_registro foldername inicio_foldername regLFP path_analizado

%Hd = designfilt('lowpassiir','FilterOrder',40, ...
%'HalfPowerFrequency',150,'DesignMethod','butter','SampleRate',sampleRate);
%fvtool(Hd)

%bpFilt = designfilt('bandpassiir','FilterOrder',40, ...
%         'HalfPowerFrequency1',1,'HalfPowerFrequency2',150, ...
%         'SampleRate',30000);
%fvtool(bpFilt)

