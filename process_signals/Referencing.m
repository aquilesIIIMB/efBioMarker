%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Referencing.m
fprintf('\nReferencing\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Referenciacion de cada canal
%registroLFP.stage.referencing = 0; % temporal test

if ~registroLFP.analysis_stages.extract_lfp 
    error('Falta el bloque de extraccion de LFP');
    
else
    if ~registroLFP.analysis_stages.delete_channel && registroLFP.analysis_stages.referencing
        error('Falta el bloque de eliminacion de canal');
    end
end

canales_eval = find(~[registroLFP.channels.removed]);

if strcmp(registroLFP.reference_type, 'none') %% Sin referencia

    
elseif strcmp(registroLFP.reference_type, 'general') %% Referencia al promedio general
    largo_canales_eval = size(canales_eval,2);
    average = mean([registroLFP.channels.data_raw],2);
    
    for j = 1:largo_canales_eval 

        % Referenciacion
        data_ref_artifacted = registroLFP.channels(canales_eval(j)).data_raw - average;
        registroLFP.channels(canales_eval(j)).data_ref = data_ref_artifacted; 
        
        % Calcular el umbral
        % Tal vez hacer umbral por fase
        umbral = registroLFP.amp_threshold(1) * median(sort(abs(data_ref_artifacted)))/0.675;
        
        % Eliminacion de artefactos % De aqui se obtiene una sennal sin artefactos, recalcular los limites
        Fc = registroLFP.freq_sin_artifacts;      % hertz Freq: 110Hz
        [~, ind_fueraUmbral] = rmArtifacts_threshold(data_ref_artifacted, umbral, Fc);
        
        % Datos estandarizados con zscore de los datos bajo el umbral 
        registroLFP.channels(canales_eval(j)).data_ref = data_ref_artifacted;
    
        % Almacenar los indices de los valores sobre el umbral
        registroLFP.channels(canales_eval(j)).idx_artifacts = ind_fueraUmbral;              
    end
    

elseif strcmp(registroLFP.reference_type, 'area') %% Referencia al promedio de cada area (ex M1L)
    % indices de las mismas areas
    [C,ia,ic] = unique({registroLFP.channels(canales_eval).area},'stable');
    
    for m = 1:length(ia) 
        i = ia(m);

        areas_actuales = find(ic == ic(i));

        largo_area_actual = length(areas_actuales);
        data_artifacted_area = [registroLFP.channels(canales_eval(areas_actuales)).data_raw];
        
        if largo_area_actual > 1
            average_area = mean(data_artifacted_area,2);
        else
            average_area = 0;
        end
        
        for j = 1:largo_area_actual 
            data_ref_artifacted = registroLFP.channels(canales_eval(areas_actuales(j))).data_raw - average_area;
            
            % Realizar el sacado de artefactos aca y por etapa;
            umbral = registroLFP.amp_threshold * median(sort(abs(data_ref_artifacted)))/0.675;

            % Eliminacion de artefactos % De aqui se obtiene una sennal sin artefactos, recalcular los limites
            Fc = registroLFP.freq_sin_artifacts;      % hertz Freq: 110Hz
            [~, ind_fueraUmbral] = rmArtifacts_threshold(data_ref_artifacted, umbral, Fc);
            
            % Almacenar los indices de los valores sobre el umbral
            registroLFP.channels(canales_eval(areas_actuales(j))).idx_artifacts = ind_fueraUmbral; 
            
            registroLFP.channels(canales_eval(areas_actuales(j))).data_ref = data_ref_artifacted;             
        end
                

    end


elseif strcmp(registroLFP.reference_type, 'sector') %% Referencia al promedio de los "sectores" (ex M1)
    
    disp('Not available')
    
elseif strcmp(registroLFP.reference_type, 'hemisphere') %% Referencia al promedio del hemisferio 
    
    disp('Not available')
    
elseif strcmp(registroLFP.reference_type, 'bi-channel') %% Referencia entre par de canales de la misma area
    
    disp('Not available')

end  

registroLFP.analysis_stages.referencing = 1;

% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP regLFP path name_registro foldername inicio_foldername

