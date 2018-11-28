%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Spectral_Channel.m
fprintf('\nAnalisis Espectral por Canal\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.analysis_stages.view_lfp 
    error('Falta el bloque de visualizacion');
    
end

canales_eval = find(~[registroLFP.channels.removed]);
largo_canales_eval = size(canales_eval,2);

%% Calculo de la respuesta en frecuencia y espectrograma
for i = 1:largo_canales_eval
    
    % Tomar el LFP del canal que se analizara. Formato samplesxCh\trials
    Data = registroLFP.channels(canales_eval(i)).data_ref;
    
    % Multitaper estimation para el spectrograma
    [Spectrogram,t_Spectrogram,f_Spectrogram]= mtspecgramc(Data,[registroLFP.multitaper_param.spectrogram.movingwin.window registroLFP.multitaper_param.spectrogram.movingwin.winstep],registroLFP.multitaper_param.spectrogram.params); 
    
    % Almacenar datos
    registroLFP.channels(canales_eval(i)).spectrogram_ref.mag = Spectrogram;
    registroLFP.channels(canales_eval(i)).spectrogram_ref.time = t_Spectrogram;
    registroLFP.channels(canales_eval(i)).spectrogram_ref.frequency = f_Spectrogram;
    
end

registroLFP.analysis_stages.spectral_channel = 1;

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP regLFP path name_registro foldername inicio_foldername

