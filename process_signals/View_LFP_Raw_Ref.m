%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% View_LFP_Raw_Ref.m
fprintf('\nVisualizacion LFP\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graficar los LFP e Histogramas para evluar cual eliminar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~registroLFP.analysis_stages.extract_lfp 
    error('Falta el bloque de extraccion de LFP');
    
end

if ~registroLFP.analysis_stages.referencing
    fprintf('Visualizacion SIN referenciacion\n');

canales_eval = find(~[registroLFP.channels.removed]);
slash_system = foldername(length(foldername));

% indices de las mismas areas
[C,ia,ic] = unique({registroLFP.channels(canales_eval).area},'stable');

for m = 1:length(ia)  
    i = ia(m);

    areas_actuales = find(ic == ic(i));
    largo_areasActuales = length(areas_actuales);
    
    % Crear legend
    str_num = int2str(canales_eval(areas_actuales)');
    
    % Separacion entre canales
    delta = 1000;
    
    fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
    for q = 1:largo_areasActuales        
        % Se grafica cada LFP de un area en un mismo grafico
        plot(registroLFP.times.steps_m, -(delta*q)+registroLFP.channels(canales_eval(areas_actuales(q))).data_raw);
        hold on;       
                
    end
    
    set(gca,'fontsize',20)
    xlim([0 registroLFP.times.steps_m(end)]);ylim([-(delta*largo_areasActuales)+min(registroLFP.channels(canales_eval(areas_actuales(largo_areasActuales))).data_raw)  -delta+max(registroLFP.channels(canales_eval(areas_actuales(1))).data_raw)])
    xlabel('Time [min]', 'FontSize', 24); ylabel('Channels', 'FontSize', 24)
    title(['(', C{ic(i)},') Raw LFP'], 'FontSize', 24)
    yticks(flip(1:size(str_num,1))*-delta)
    yticklabels(flip(str_num,1))
        
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,'LFPs',slash_system,'Raw',slash_system,C{ic(i)},' LFP en bruto en el tiempo'];
    saveas(fig_1,name_figure_save,'png');
    %saveas(fig_1,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_1)
    
    
    fig_3 = figure('units','normalized','outerposition',[0 0 1 1]);
    for q = 1:length(areas_actuales)
        
        subplot(2,round(length(areas_actuales)/2),q);
        histo_diff = histogram(diff(registroLFP.channels(canales_eval(areas_actuales(q))).data_raw),1000); 
        grid on
        xlim([histo_diff.BinLimits]); ylim([0 3*10^4]);
        xlabel('Derivative Amplitude [u.a.]'); ylabel('Number of elements');
        title(['(', C{ic(i)}, ') Derivative of the LFP CH',int2str(canales_eval(areas_actuales(q)))])
    end
    name_figure_save = [inicio_foldername,'Images',foldername,'LFPs',slash_system,'Raw',slash_system,C{ic(i)},' Histograma de la derivada del LFP estandarizado en el tiempo'];
    saveas(fig_3,name_figure_save,'png');
    %waitforbuttonpress;
    close(fig_3)
    
end 
   
else
    fprintf('Visualizacion CON referenciacion\n');
   
canales_eval = find(~[registroLFP.channels.removed]);
slash_system = foldername(length(foldername));

% indices de las mismas areas
[C,ia,ic] = unique({registroLFP.channels(canales_eval).area},'stable');

for m = 1:length(ia)  
    i = ia(m);

    areas_actuales = find(ic == ic(i));
    largo_areasActuales = length(areas_actuales);
       
    % Crear legend
    str_num = int2str(canales_eval(areas_actuales)');
    
    % Separacion entre canales
    delta = 500;
    
    fig_1 = figure('units','normalized','outerposition',[0 0 1 1]);
    for q = 1:largo_areasActuales        
        
        % Se grafica cada LFP de un area en un mismo grafico
        plot(registroLFP.times.steps_m, -(delta*q)+registroLFP.channels(canales_eval(areas_actuales(q))).data_ref);
        hold on;   
        
        umbral = registroLFP.amp_threshold * median(sort(abs(registroLFP.channels(canales_eval(areas_actuales(q))).data_ref)))/0.675;
        
        plot([0 registroLFP.times.steps_m(end)], [-(delta*q)+umbral -(delta*q)+umbral],'r--','LineWidth',1.0);
        hold on;
        plot([0 registroLFP.times.steps_m(end)], [-(delta*q)-umbral -(delta*q)-umbral],'r--','LineWidth',1.0); 
        hold on;
                
    end
    
    set(gca,'fontsize',20)
    xlim([0 registroLFP.times.steps_m(end)]);ylim([-(delta*largo_areasActuales)+min(registroLFP.channels(canales_eval(areas_actuales(largo_areasActuales))).data_raw)  -delta+max(registroLFP.channels(canales_eval(areas_actuales(1))).data_raw)])
    xlabel('Time [min]', 'FontSize', 24); ylabel('Channels', 'FontSize', 24)
    title(['(', C{ic(i)},') LFP referenced without artifacts'], 'FontSize', 24)
    yticks(flip(1:size(str_num,1))*-delta)
    yticklabels(flip(str_num,1))
        
    % Guardar imagen de la figura
    name_figure_save = [inicio_foldername,'Images',foldername,slash_system,'LFPs',slash_system,'Ref',slash_system,C{ic(i)},' LFP ref en el tiempo sin artefactos '];
    saveas(fig_1,name_figure_save,'png');
    saveas(fig_1,name_figure_save,'fig');
    %waitforbuttonpress;
    close(fig_1)
    

    registroLFP.analysis_stages.view_lfp = 1;    
end
    
end


% Eliminacion de variables que no se van a guardar
clearvars -except registroLFP regLFP path name_registro foldername inicio_foldername
