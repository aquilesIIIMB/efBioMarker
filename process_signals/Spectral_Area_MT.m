%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Spectral_Area_MT.m
fprintf('\nAnalisis Espectral por Area\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.analysis_stages.spectral_channel_ref 
    error('Falta el bloque de analisis espectral para cada canal referenciado');
    
end

canales_eval = find(~[registroLFP.channels.removed]);
[C,ia,ic] = unique({registroLFP.channels(canales_eval).area},'stable');

for m = 7%1:length(ia) 
    i = ia(m);

    areas_actuales = find(ic == ic(i));

    largo_area_actual = length(areas_actuales);
    idx_artifacts_signal_area = [registroLFP.channels(canales_eval(areas_actuales)).idx_artifacts];
    time = registroLFP.channels(canales_eval(areas_actuales(1))).spectrogram_ref.time;
    freqs = registroLFP.channels(canales_eval(areas_actuales(1))).spectrogram_ref.frequency;
    
    % Pasar de muestreo de LFP al del espectrgrama 
    idx_artifacts_spect_total = resampletoSpect(~idx_artifacts_signal_area, length(time));
    idx_artifacts_spect_area = min(idx_artifacts_spect_total,[],2); %  si dentro de una ventana hay un artefacto, la ventana se designa como artefacto

    if largo_area_actual > 1  
        data_spect_area = 0;
        for j = 1:largo_area_actual 
            idx_artifact_actual = idx_artifacts_spect_total(:,j);
            data_sepct_actual = registroLFP.channels(canales_eval(areas_actuales(j))).spectrogram_ref.mag;
            data_spect_area = data_spect_area + data_sepct_actual.*repmat(idx_artifact_actual,1,size(data_sepct_actual,2));

        end

        data_spect_area(logical(idx_artifacts_spect_area),:) = data_spect_area(logical(idx_artifacts_spect_area),:) ./ sum(idx_artifacts_spect_total(logical(idx_artifacts_spect_area),:),2); % div 0
    else
        data_spect_area = registroLFP.channels(canales_eval(areas_actuales)).spectrogram_ref.mag;
    end

    mixed = data_spect_area.*0;
    scale_free = data_spect_area.*0;
    
    % FOOOF settings
    settings = struct();  % Use defaults
    f_range = [1, 100]; 
    
    fooof_results = [];
        
    for j = 1: length(time)

        % Run FOOOF
        try 
            fooof_results = fooof(freqs, data_spect_area(j,:), f_range, settings,1);
        catch
            % Se coloca como artefacto
            fooof_results.fooofed_spectrum = zeros(size(data_spect_area(j,:))); % Falla si el primer bin es un artefacto
            fooof_results.bg_fit = zeros(size(data_spect_area(j,:)));
        end
        
        mixed(j,:) = fooof_results.fooofed_spectrum;
        scale_free(j,:) = fooof_results.bg_fit;
        
    end
    
    mixed = 10.^mixed;
    scale_free = 10.^scale_free;
    osci = mixed - scale_free;
    
    disp(C{m})
    
    %Nombre del area
    registroLFP.areas(m).name = C{m};

    % Datos estandarizados con zscore de los datos bajo el umbral 
    registroLFP.areas(m).spectrogram.mixed.mag = mixed;
    registroLFP.areas(m).spectrogram.oscillations.mag = osci;
    registroLFP.areas(m).spectrogram.fractals.mag = scale_free;

    % Almacenar los indices de los valores sobre el umbral
    registroLFP.areas(m).idx_artifacts = idx_artifacts_spect_area;
    registroLFP.areas(m).spectrogram.frequency = registroLFP.channels(canales_eval(areas_actuales(1))).spectrogram_ref.frequency;
    registroLFP.areas(m).spectrogram.time = registroLFP.channels(canales_eval(areas_actuales(1))).spectrogram_ref.time;

end

registroLFP.analysis_stages.spectral_area = 1;

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP regLFP path name_registro foldername inicio_foldername

% Guardar matrices en .mat
path_name_registro = [inicio_foldername,'Images',foldername,name_registro];

% Descomentar para guardar
save(path_name_registro,'-v7.3')

disp(['It was saved in: ',path_name_registro])
disp('Signal processing is ready!!! :D')

