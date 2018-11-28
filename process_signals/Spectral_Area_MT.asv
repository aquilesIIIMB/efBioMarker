
canales_eval = find(~[registroLFP.channels.removed]);
[C,ia,ic] = unique({registroLFP.channels(canales_eval).area},'stable');

for m = 1:length(ia) 
    i = ia(m);

    areas_actuales = find(ic == ic(i));

    largo_area_actual = length(areas_actuales);
    data_artifacted_area = [registroLFP.channels(canales_eval(areas_actuales)).spectrogram_ref.mag];
    idx_artifacts_area = [registroLFP.channels(canales_eval(areas_actuales)).idx_artifacts];

    if largo_area_actual > 1 ! Ver que ninguna ventana tenga valor cero !!! es en el espectro, no en la señal        
        average_spect_area = sum(data_artifacted_area.*~idx_artifacts_area,2) ./ sum(~idx_artifacts_area,2);
    else
        average_spect_area = 0;
    end

    for j = 1:largo_area_actual 
        data_ref_artifacted = average_spect_area;

        % Realizar el sacado de artefactos aca y por etapa;
        umbral = registroLFP.amp_threshold * median(sort(abs(data_ref_artifacted)))/0.675;

        % Eliminacion de artefactos % De aqui se obtiene una sennal sin artefactos, recalcular los limites
        Fc = registroLFP.freq_sin_artifacts;      % hertz Freq: 110Hz
        [~, ind_fueraUmbral] = rmArtifacts_threshold(data_ref_artifacted, umbral, Fc);

        % Almacenar los indices de los valores sobre el umbral
        registroLFP.areas(m).idx_artifacts = ind_fueraUmbral; 

        registroLFP.channels(canales_eval(areas_actuales(j))).data_ref = data_ref_artifacted;             
    end
    
    

    %Nombre del area
    registroLFP.areas(m).name = C{m};

    % Datos estandarizados con zscore de los datos bajo el umbral 
    registroLFP.areas(m).spectrogram.mixed.mag = average_spect_area;

    % Almacenar los indices de los valores sobre el umbral
    registroLFP.areas(m).ind_over_threshold = ind_fueraUmbral;  

end





