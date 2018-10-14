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
        registroLFP.channels(canales_eval(j)).threshold = umbral; 
        
        % Eliminacion de artefactos % De aqui se obtiene una sennal sin artefactos, recalcular los limites
        Fc = registroLFP.freq_sin_artifacts;      % hertz Freq: 110Hz
        [data_ref_noartifacted, ind_fueraUmbral] = rmArtifacts_threshold(data_ref_artifacted, umbral, Fc);

        registroLFP.channels(canales_eval(j)).data_noartifacted = data_ref_noartifacted; %%% Aumenta el numero de datos
        
        % Datos estandarizados con zscore de los datos bajo el umbral 
        registroLFP.channels(canales_eval(j)).data = zscore_noartifacted(data_ref_noartifacted,ind_fueraUmbral);
        %registroLFP.channels(canales_eval(j)).data = zscore(data_referenciado);
    
        % Almacenar los indices de los valores sobre el umbral
        registroLFP.channels(canales_eval(j)).ind_over_threshold = ind_fueraUmbral;              
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
            registroLFP.channels(canales_eval(areas_actuales(j))).data_ref = sign(mean(data_ref_artifacted)).*data_ref_artifacted; 
            
        end
        
        if largo_area_actual > 1
            Data_area = zscore(mean([registroLFP.channels(canales_eval(areas_actuales)).data_ref],2)); % guardar
        else
            Data_area = zscore(registroLFP.channels(canales_eval(areas_actuales)).data_ref); % guardar
        end
        registroLFP.areas(m).data_raw = Data_area;
        
        Data_area_pre = Data_area(registroLFP.times.steps_m<(registroLFP.times.stages_timeRanges_m(1)));
        Data_area_on = Data_area(registroLFP.times.steps_m>(registroLFP.times.stages_timeRanges_m(1)) & registroLFP.times.steps_m<(registroLFP.times.stages_timeRanges_m(1)*2+1));
        Data_area_post = Data_area(registroLFP.times.steps_m>(registroLFP.times.stages_timeRanges_m(1)*2+1));
        
        % Realizar el sacado de artefactos aca y por etapa;
        umbral_pre = registroLFP.amp_threshold(1) * median(sort(abs(Data_area_pre)))/0.675;
        umbral_on = registroLFP.amp_threshold(2) * median(sort(abs(Data_area_on)))/0.675;
        umbral_post = registroLFP.amp_threshold(3) * median(sort(abs(Data_area_post)))/0.675;
        registroLFP.areas(m).threshold = [umbral_pre, umbral_on, umbral_post]; 
        
        % Eliminacion de artefactos % De aqui se obtiene una sennal sin artefactos, recalcular los limites
        Fc = registroLFP.freq_sin_artifacts;      % hertz Freq: 110Hz
        [Data_area_pre_noartifacted, ind_fueraUmbral_pre] = rmArtifacts_threshold(Data_area_pre, umbral_pre, Fc);
        [Data_area_on_noartifacted, ind_fueraUmbral_on] = rmArtifacts_threshold(Data_area_on, umbral_on, Fc);
        [Data_area_post_noartifacted, ind_fueraUmbral_post] = rmArtifacts_threshold(Data_area_post, umbral_post, Fc);
        
        Data_area_noartifacted = [Data_area_pre_noartifacted; Data_area_on_noartifacted; Data_area_post_noartifacted];
        ind_fueraUmbral = [ind_fueraUmbral_pre; ind_fueraUmbral_on; ind_fueraUmbral_post];
        
        %Nombre del area
        registroLFP.areas(m).name = C{m};

        % Datos estandarizados con zscore de los datos bajo el umbral 
        registroLFP.areas(m).data = Data_area_noartifacted; %zscore_noartifacted(Data_area_noartifacted, ind_fueraUmbral);
        
        % Almacenar los indices de los valores sobre el umbral
        registroLFP.areas(m).ind_over_threshold = ind_fueraUmbral;  
        
        % Factor de regulacion
        regLFP.areas(m).name = C{m};
        if largo_area_actual > 1
            regLFP.areas(m).factorReg = median([regLFP.channels(canales_eval(areas_actuales)).ampMax])/max(registroLFP.areas(m).data);
        else
            regLFP.areas(m).factorReg = regLFP.channels(canales_eval(areas_actuales)).ampMax/max(registroLFP.areas(m).data);
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

