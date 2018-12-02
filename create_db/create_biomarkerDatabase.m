%%%%% Create Biomarker Database %%%%%%%%%%%

main_path = '/home/controlmotor/Aquiles/Fractales Biomarcador/Database/';

% Control 2
database_cont = {[main_path,'Shiwi (Suj07)/CA_EC03_C15_PreQx__2018-09-21_13-08-56/CA_EC03_C15_PreQx__2018-09-21_13-08-56.mat'],...
    [main_path,'Shiwi (Suj07)/CA_EC03_C15_NS__2018-09-28_14-57-27/CA_EC03_C15_NS__2018-09-28_14-57-27.mat']};

% Inicial 3
database_inic = {{[main_path,'Maravilla (Suj01)/-375/maravilla_2017-06-05_10-47-34/maravailla_2017-06-05_10-47-34.mat'],...
    [main_path,'Maravilla (Suj01)/-375/maravilla_2017-06-05_10-47-34/maravilla_2017-06-05_10-47-34_regAmp.mat']},...
    {[main_path,'Arturo (Suj02)/+375/arturo2_2017-05-29_11-38-35/arturo2_2017-05-29_11-38-35.mat'],...
    [main_path,'Arturo (Suj02)/+375/arturo2_2017-05-29_11-38-35/arturo2_2017-05-29_11-38-35_regAmp.mat']},...
    [main_path,'Charles (Suj03)/300Hz/charles_2017-06-08_13-09-12/charles_2017-06-08_13-09-12.mat']};

% Intermedio 3
database_int = {{[main_path,'Maravilla (Suj01)/+2500_300Hz/maravilla_2017-06-17_16-39-32/maravilla_2017-06-17_16-39-32.mat'],...
    [main_path,'Maravilla (Suj01)/+2500_300Hz/maravilla_2017-06-17_16-39-32/maravilla_2017-06-17_16-39-32_regAmp.mat']},...
    {[main_path,'Arturo (Suj02)/+2500_300Hz/arturo_2017-06-09_15-24-39/arturo_2017-06-09_15-24-39.mat'],...
    [main_path,'Arturo (Suj02)/+2500_300Hz/arturo_2017-06-09_15-24-39/arturo_2017-06-09_15-24-39_regAmp.mat']},...
    {[main_path,'Charles (Suj03)/-2500/charles_2017-06-16_17-07-38/charles_2017-06-16_17-07-38.mat'],...
    [main_path,'Charles (Suj03)/-2500/charles_2017-06-16_17-07-38/charles_2017-06-16_17-07-38_regAmp.mat']}};

% Avanzado 3
database_avan = {{[main_path,'Maravilla (Suj01)/150Hz/maravilla_2017-07-04_15-19-26/maravilla_2017-07-04_15-19-26.mat'],...
    [main_path,'Maravilla (Suj01)/150Hz/maravilla_2017-07-04_15-19-26/maravilla_2017-07-04_15-19-26_regAmp.mat']},...
    {[main_path,'Arturo (Suj02)/-2500_300Hz/arturo3_2017-07-04_15-48-06/arturo3_2017-07-04_15-48-06.mat'],...
    [main_path,'Arturo (Suj02)/-2500_300Hz/arturo3_2017-07-04_15-48-06/arturo3_2017-07-04_15-48-06_regAmp.mat']},...
    [main_path,'Alex (Suj08)/CA_EC03_C14_CS300__2018-09-28_16-38-37/CA_EC03_C14_CS300__2018-09-28_16-38-37.mat']};

% Stim 2 
database_stim = {{[main_path,'Maravilla (Suj01)/+2500_300Hz/maravilla_2017-06-17_16-39-32/maravilla_2017-06-17_16-39-32.mat'],...
    [main_path,'Maravilla (Suj01)/+2500_300Hz/maravilla_2017-06-17_16-39-32/maravilla_2017-06-17_16-39-32_regAmp.mat']},...
    {[main_path,'Arturo (Suj02)/+2500_300Hz/arturo_2017-06-09_15-24-39/arturo_2017-06-09_15-24-39.mat'],...
    [main_path,'Arturo (Suj02)/+2500_300Hz/arturo_2017-06-09_15-24-39/arturo_2017-06-09_15-24-39_regAmp.mat']}};

database_extras = {['D:\Descargas\Trabajo de titulo\Images\+2500_300Hz\maravilla_2017-06-17_16-39-32\maravilla_2017-06-17_16-39-32.mat']};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% variables to set
database = database_extras;
labels_db = ones(length(database),1).* 2; % C:0 L-I:1 L-M:2 L-A:3
channel_codes = {'flo'}; % flo caro_exp03
hemispher_use = {'par'}; % par: derecho, impar: izquierda

set_type = 'train-test'; % train-test trat
timeRange = [0, 5]*60; %seconds





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
power_osci = [];
power_osci_total = [];
power_frac = [];
power_frac_total = [];
dim_frac_pk_alpha = [];
dim_frac_pk_beta = [];
dim_frac_pk_gammaL = [];
dim_frac_gen_alpha = [];
dim_frac_gen_beta = [];
dim_frac_gen_gammaL = [];


for idx_db = 1:length(database)

    if length(database{idx_db}) == 2
        load(database{idx_db}{1})
        load(database{idx_db}{2})
    else
        load(database{idx_db})
    end
    
    Biomarker = ones(10, length(registroLFP.areas));
    Biomarker_temp = ones(10, 6);

    canales_eval = find(~[registroLFP.channels.removed]);
    slash_system = foldername(length(foldername));

    pre_m = registroLFP.times.pre_m;
    on_inicio_m = registroLFP.times.start_on_m;
    on_final_m = registroLFP.times.end_on_m;
    post_m = registroLFP.times.post_m;
    tiempo_total = registroLFP.times.end_m;

    azul = [0 0.4470 0.7410];
    rojo = [0.85, 0.325, 0.098];
    verde = [0.466, 0.674, 0.188];

    factor = [regLFP.areas(:).factorReg]';
    p_idx = i;

    [C,ia,ic] = unique({registroLFP.channels(canales_eval).area},'stable');
    %% Calculos para el analisis del promedio de las Areas
    for m = 1:length(ia) 
        i = ia(m);

        % Cargar los datos que se mostraran
        Spectrogram_osci_mean = registroLFP.average_spectrum(m).spectrogram.oscillations.mag.*factor(m);
        Mean_Spectrogram_osci_pre_mean = registroLFP.average_spectrum(m).spectrogram.oscillations.mean_mag_pre; 
        Desv_Spectrogram_osci_pre_mean = registroLFP.average_spectrum(m).spectrogram.oscillations.std_mag_pre; 

        Spectrogram_frac_mean = registroLFP.average_spectrum(m).spectrogram.fractals.mag.*factor(m);
        Mean_Spectrogram_frac_pre_mean = registroLFP.average_spectrum(m).spectrogram.fractals.mean_mag_pre; 
        Desv_Spectrogram_frac_pre_mean = registroLFP.average_spectrum(m).spectrogram.fractals.std_mag_pre; 

        beta_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.beta; 
        t_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.time;
        f_Spectrogram_mean = registroLFP.average_spectrum(m).spectrogram.frequency;  
        idx_spect_artifacts = registroLFP.average_spectrum(m).spectrogram.ind_artifacts; 

        %% Grafico del promedio de todos los canales    
        disp(C{ic(i)})

        % Perodo de tiempo usado 
        t_pre = find((t_Spectrogram_mean>=timeRange(1) & t_Spectrogram_mean<=timeRange(2)));

        % Oscilaciones
        osci = sum(Spectrogram_osci_mean(t_pre(~ismember(t_pre,idx_spect_artifacts)),(f_Spectrogram_mean>=8 & f_Spectrogram_mean<=30)),2);
        osci = osci+30; %Para subir los valores negativos en todos los psd por igual debido a IRASA

        [idx_pk_osci,idx_Npk_osci,idx_ptos_osci,mean_range_osci,n_events_osci] = highPowerBetaPkEvent(osci, 20);
        osci_measure = mean(osci(idx_pk_osci));%sum or mean
        mean_osci_Npk = mean(osci(idx_Npk_osci));
        if isnan(osci_measure)
            osci_measure = 0;
            mean_osci_Npk = 0;
        end

        % Potencia fractal
        frac = sum(Spectrogram_frac_mean(t_pre(~ismember(t_pre,idx_spect_artifacts)),:),2);
        [idx_pk_frac,idx_Npk_frac,idx_ptos_frac,mean_range_frac,n_events_frac] = highPowerBetaPkEvent(frac, 70);
        frac_measure = mean(frac(idx_pk_frac));%sum or mean
        mean_frac_Npk = mean(frac(idx_Npk_frac));
        if isnan(frac_measure)
            frac_measure = 0;
            mean_frac_Npk = 0;
        end
        
        % Dim fractal
        frac_temp = Spectrogram_frac_mean(t_pre(~ismember(t_pre,idx_spect_artifacts)),:);

        dimListFt = fractal_dim(f_Spectrogram_mean, frac_temp, 10, [2,3,4]);
        dimListFt = dimListFt([2,3,4],:);
        if idx_pk_frac
            dim_pk = dimListFt(:,idx_pk_frac); % Promedio del registro en el tiempo
            dim_pk_alpha = mean(dim_pk(1,:)); % Promedio de los intervalos escogidos
            dim_pk_beta = mean(dim_pk(2,:)); % Promedio de los intervalos escogidos
            dim_pk_gammaL = mean( dim_pk(3,:)); % Promedio de los intervalos escogidos
        else
            dim_pk_alpha = 0; % Promedio de los intervalos escogidos
            dim_pk_beta = 0; % Promedio de los intervalos escogidos
            dim_pk_gammaL = 0; % Promedio de los intervalos escogidos
        end
        dim_gen = dimListFt; % Promedio del registro en el tiempo
        dim_gen_alpha = mean(dim_gen(1,:));
        dim_gen_beta = mean(dim_gen(2,:));
        dim_gen_gammaL = mean(dim_gen(3,:));
        
        % BM Izquierda primero y despues derecha, DLS, S1, SMA, M1, VPL
        Biomarker(1,m) = osci_measure;
        Biomarker(2,m) = sum(osci);
        Biomarker(3,m) = frac_measure;
        Biomarker(4,m) = sum(frac);
        
        Biomarker(5,m) = dim_pk_alpha;
        Biomarker(6,m) = dim_pk_beta;
        Biomarker(7,m) = dim_pk_gammaL;
        Biomarker(8,m) = dim_gen_alpha;
        Biomarker(9,m) = dim_gen_beta;
        Biomarker(10,m) = dim_gen_gammaL;
        
        
        %{
        figure('units','normalized','outerposition',[0 0 0.5 0.5])
        plot(t_Spectrogram_mean(t_pre),osci,'LineWidth',3.0)
        set(gca,'fontsize',20)
        %xlabel('Tiempo [s]', 'FontSize', 24); ylabel('Potencia', 'FontSize', 24)
        title(['Magnitud oscilatoria ',C{ic(i)}], 'FontSize', 24)
        xlim([0,300]);ylim([0,1000]);
        
        figure('units','normalized','outerposition',[0 0 0.5 0.5])
        plot(t_Spectrogram_mean(t_pre),frac,'LineWidth',3.0)
        set(gca,'fontsize',20)
        %xlabel('Tiempo [s]', 'FontSize', 24); ylabel('Potencia', 'FontSize', 24)
        title(['Magnitud scale-free ',C{ic(i)}], 'FontSize', 24)
        xlim([0,300]);ylim([0,1000]);
        
        figure('units','normalized','outerposition',[0 0 0.5 0.5])
        plot(t_Spectrogram_mean(t_pre),dim_gen(1,:),'LineWidth',3.0)
        set(gca,'fontsize',20)
        %xlabel('Tiempo [s]', 'FontSize', 24); ylabel('Pendiente', 'FontSize', 24)
        title(['Pendiente scale-free D2 ',C{ic(i)}], 'FontSize', 24)
        xlim([0,300]);ylim([-3,5]);
        
        figure('units','normalized','outerposition',[0 0 0.5 0.5])
        plot(t_Spectrogram_mean(t_pre),dim_gen(2,:),'LineWidth',3.0)
        set(gca,'fontsize',20)
        %xlabel('Tiempo [s]', 'FontSize', 24); ylabel('Pendiente', 'FontSize', 24)
        title(['Pendiente scale-free D3 ',C{ic(i)}], 'FontSize', 24)
        xlim([0,300]);ylim([-3,5]);
        
        figure('units','normalized','outerposition',[0 0 0.5 0.5])
        plot(t_Spectrogram_mean(t_pre),dim_gen(3,:),'LineWidth',3.0)
        set(gca,'fontsize',20)
        %xlabel('Tiempo [s]', 'FontSize', 24); ylabel('Pendiente', 'FontSize', 24)
        title(['Pendiente scale-free D4 ',C{ic(i)}], 'FontSize', 24)
        xlim([0,300]);ylim([-3,5]);
        
        %}
        
        
        %{
        % PSD from Spect
        n = 400;
        a = get(gca,'Children');
        spect = a(5).CData;% + 30;
        figure('units','normalized','outerposition',[0 0 0.5 0.5])
        plot(f_Spectrogram_mean, spect(:,n),'LineWidth',3.0)
        set(gca,'fontsize',20)
        
        %}
        
        

    end
    disp(' ')
    disp(' ')

    %%% Ordenar izquierda impar, derecha par
    if strcmp(channel_codes{idx_db},'flo') 
        % Primeros 5 izqueirda y siguiente derecha
        Biomarker_temp(:,1:2:end) = Biomarker(:,[4,1,5]); % 1,2,3,4,5 DLS, S1, SMA, M1, VPL
        Biomarker_temp(:,2:2:end) = Biomarker(:,[9,6,10]); % 6,7,8,9,10 DLS, S1, SMA, M1, VPL
    elseif strcmp(channel_codes{idx_db},'caro_exp03') 
        % Orden de expC03 
        Biomarker_temp(:,1:2:end) = Biomarker(:,[1,2,7]); % 1,2,6,7 lCFA, lSTR, lPf, lVPL
        Biomarker_temp(:,2:2:end) = Biomarker(:,[3,4,8]); % 3,4,5,8 rCFA, rSTR, rPf, rVPL
    end


    power_osci = [power_osci; Biomarker_temp(1,:)];
    power_osci_total = [power_osci_total; Biomarker_temp(2,:)];
    power_frac = [power_frac; Biomarker_temp(3,:)];
    power_frac_total = [power_frac_total; Biomarker_temp(4,:)];
    dim_frac_pk_alpha = [dim_frac_pk_alpha; Biomarker_temp(5,:)];
    dim_frac_pk_beta = [dim_frac_pk_beta; Biomarker_temp(6,:)];
    dim_frac_pk_gammaL = [dim_frac_pk_gammaL; Biomarker_temp(7,:)];
    dim_frac_gen_alpha = [dim_frac_gen_alpha; Biomarker_temp(8,:)];
    dim_frac_gen_beta = [dim_frac_gen_beta; Biomarker_temp(9,:)];
    dim_frac_gen_gammaL = [dim_frac_gen_gammaL; Biomarker_temp(10,:)];


end



%%% Creacion de base de datos Raw
if strcmp(set_type,'train-test')
    if ~exist('BiomarkerDataBase_EP','var')
        BiomarkerDataBase_EP = []; 
        Labels_BM_EP = [];
    end

    % pensado para 5 caract
    for subj = 1:size(power_osci,1) % sujeto

        features = [];
        for areas_eval = 1:size(power_osci,2)/2
            if strcmp(hemispher_use{subj},'par')
                feature_osci = power_osci(subj,2*areas_eval);        
                feature_frac = power_frac(subj,2*areas_eval);        
                feature_dim2 = dim_frac_pk_alpha(subj,2*areas_eval);        
                feature_dim3 = dim_frac_pk_beta(subj,2*areas_eval);        
                feature_dim4 = dim_frac_pk_gammaL(subj,2*areas_eval);
            elseif strcmp(hemispher_use{subj},'impar')
                feature_osci = power_osci(subj,2*areas_eval-1);        
                feature_frac = power_frac(subj,2*areas_eval-1);        
                feature_dim2 = dim_frac_pk_alpha(subj,2*areas_eval-1);        
                feature_dim3 = dim_frac_pk_beta(subj,2*areas_eval-1);        
                feature_dim4 = dim_frac_pk_gammaL(subj,2*areas_eval-1);
            end

            features = [features, feature_osci, feature_frac, feature_dim2, feature_dim3, feature_dim4];

        end

        BiomarkerDataBase_EP = [BiomarkerDataBase_EP; features];

    end

    Labels_BM_EP = [Labels_BM_EP; labels_db];
    
elseif strcmp(set_type,'trat')
    if ~exist('BiomarkerDataBase_trat','var')
        BiomarkerDataBase_trat = []; 
        Labels_BM_trat = [];
    end

    % pensado para 5 caract
    for subj = 1:size(power_osci,1) % sujeto

        features = [];
        for areas_eval = 1:size(power_osci,2)/2
            if strcmp(hemispher_use{subj},'par')
                feature_osci = power_osci(subj,2*areas_eval);        
                feature_frac = power_frac(subj,2*areas_eval);        
                feature_dim2 = dim_frac_pk_alpha(subj,2*areas_eval);        
                feature_dim3 = dim_frac_pk_beta(subj,2*areas_eval);        
                feature_dim4 = dim_frac_pk_gammaL(subj,2*areas_eval);
            elseif strcmp(hemispher_use{subj},'impar')
                feature_osci = power_osci(subj,2*areas_eval-1);        
                feature_frac = power_frac(subj,2*areas_eval-1);        
                feature_dim2 = dim_frac_pk_alpha(subj,2*areas_eval-1);        
                feature_dim3 = dim_frac_pk_beta(subj,2*areas_eval-1);        
                feature_dim4 = dim_frac_pk_gammaL(subj,2*areas_eval-1);
            end

            features = [features, feature_osci, feature_frac, feature_dim2, feature_dim3, feature_dim4];

        end

        BiomarkerDataBase_trat = [BiomarkerDataBase_trat; features];

    end

    Labels_BM_trat = [Labels_BM_trat; labels_db];
    
end

% Eliminacion de variables que no se van a guardar
clearvars -except BiomarkerDataBase_EP Labels_BM_EP BiomarkerDataBase_trat Labels_BM_trat main_path

% Guardar matrices en .mat
path_name_registro = [main_path,main_path(1),'biomarkerDB'];

% Descomentar para guardar
save(path_name_registro,'-v7.3')

disp(['It was saved in: ',path_name_registro])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
main_path = '/home/controlmotor/Aquiles/Fractales Biomarcador/Database/';

param_ext(1).rec = {main_path};
param_ext(1).seg = {[0,5]};
param_ext(1).dbType = {'bm'};
param_ext(1).hem = {'L'};
param_ext(1).area = {{'M1','STR','VPL'}};

param_ext(2).rec = {main_path};
param_ext(2).seg = {[1,6], [7,12]};
param_ext(2).dbType = {'bm','trat'};
param_ext(2).hem = {'L', 'R'};
param_ext(2).area = {{'M1','STR','VPL'}, {'M1','STR'}};


for idx_rec = 1:length(param_ext)
    %disp(param_ext(idx_rec).rec)
    load(param_ext(idx_rec).rec)
    for idx_seg = 1:length(param_ext(idx_rec).seg)
        disp(param_ext(idx_rec).seg{idx_seg})
        disp(param_ext(idx_rec).dbType(idx_seg))
        disp(param_ext(idx_rec).hem(idx_seg))
        disp(param_ext(idx_rec).area{idx_seg})
    end
    disp('Next Rec')
end

