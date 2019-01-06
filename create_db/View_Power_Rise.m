
len_var = size(mat_variables,2);
limit_rang = [0 25*10^3; 0 4*10^3; 0 12*10^3; 0 12*10^3; 0 12*10^3; 0 1.4*10^3;...
    0 250; 0 35*10^3; 0.4 2.2; 0 60; 0 200; 0 200;...
    0 200; 0 6*10^3; 0 6*10^3; 0 6*10^3; 0 6*10^3; 0 70];
%{
min_th = [600; 100; 600; 600; 200; 50;...
    10; 100; 0.3; 1; 1; 1;...
    1; 20; 20; 20; 20; 2];
%}
time_range = [0, 5]*60;

% Variables agrupadas en 6    
for i = 1:len_var
    if i == 1 || i == 7 || i == 13
        fig = figure('units','normalized','outerposition',[0 0 1 1]);
        j=1;
    end
    idx_noArtif = find(idx_spect_artifacts(time > time_range(1) & time < time_range(2)));
    var_actual = mat_variables(time > time_range(1) & time < time_range(2), i);
    time_actual = time(time > time_range(1) & time < time_range(2));
    try
        %[idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(var_actual, min_th(i));
        %[idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual)-min(normalize(var_actual)), 0.4);%min_th(i));
        [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
    catch
        idx_pk_osci = [];
    end

    subplot(3,2,j)
    plot(time_actual, var_actual)
    hold on
    plot(time_actual(idx_noArtif(idx_pk_osci)), var_actual(idx_noArtif(idx_pk_osci)),'*')
    title(labels_Var{i})
    ylim([limit_rang(i,1) limit_rang(i,2)])
    j = j+1;
    
    %{
    if i == 6 || i == 12 || i == 18
        name_figure_save = [inicio_foldername,'Images',foldername,'SpectralVar',slash_system,[lower(hemisf_actual(idx_hem)),area_actual, ' Group ',int2str(round(i/6))]];
        saveas(fig,name_figure_save,'png');
        saveas(fig,name_figure_save,'fig');
        close(fig)
    end
    %}
end



