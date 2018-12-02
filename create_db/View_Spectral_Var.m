%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% View_Spectral_Var.m
fprintf('\nVisualizacion de las variables espectrales\n')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

len_var = size(mat_variables,2);

% Variables individuales
for i = 1:len_var
    %-------------------Plot---Spectrogram------------------------------------
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    plot(time, mat_variables(:,i))
    title(labels_Var{i}, 'FontSize', 24)
    set(gca,'fontsize',20)
    name_figure_save = [inicio_foldername,'Images',foldername,'SpectralVar',slash_system,[lower(hemisf_actual(idx_hem)),area_actual, ' Feature ',int2str(i),' ',labels_Var{i}]];
    saveas(fig,name_figure_save,'png');
    saveas(fig,name_figure_save,'fig');
    close(fig)
end
    
% Variables agrupadas en 6    
for i = 1:len_var
    if i == 1 || i == 7 || i == 13
        fig = figure('units','normalized','outerposition',[0 0 1 1]);
        j=1;
    end
    subplot(3,2,j)
    plot(time, mat_variables(:,i))
    title(labels_Var{i})
    j = j+1;
    
    if i == 6 || i == 12 || i == 18
        name_figure_save = [inicio_foldername,'Images',foldername,'SpectralVar',slash_system,[lower(hemisf_actual(idx_hem)),area_actual, ' Group ',int2str(round(i/6))]];
        saveas(fig,name_figure_save,'png');
        saveas(fig,name_figure_save,'fig');
        close(fig)
    end
end





