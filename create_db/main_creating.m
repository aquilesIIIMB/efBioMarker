%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% main_creating.m
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all

db(1).param_ext.rec = {'/home/controlmotor/Aquiles/Fractales Biomarcador/Database/1. Control/Shiwi (Suj04)/CA_EC03_C15_NS__2018-09-28_14-57-27/CA_EC03_C15_NS__2018-09-28_14-57-27.mat'};
db(1).param_ext.seg = {[25,30]};
db(1).param_ext.dbType = {'bm'}; % bm o trat
db(1).param_ext.hem = {'L'}; % L, R o LR
db(1).param_ext.area = {{'CFA','STR','VPL'}};
db(1).param_ext.class = {'C'};

db(2).param_ext.rec = {'/home/controlmotor/Aquiles/Fractales Biomarcador/Database/1. Control/Panda (Suj06)/CA_EC03_C18_NS__2018-11-06_16-58-18/CA_EC03_C18_NS__2018-11-06_16-58-18.mat'};
db(2).param_ext.seg = {[30,35]};
db(2).param_ext.dbType = {'bm'}; % bm o trat
db(2).param_ext.hem = {'L'}; % L, R o LR
db(2).param_ext.area = {{'CFA','STR','VPL'}};
db(2).param_ext.class = {'C'};

db(3).param_ext.rec = {'/home/controlmotor/Aquiles/Fractales Biomarcador/Database/2. Lesion Temprana/Maravilla (Suj01)/maravilla_2017-06-05_10-47-34/maravilla_2017-06-05_10-47-34.mat'};
db(3).param_ext.seg = {[0,5]};
db(3).param_ext.dbType = {'bm'};
db(3).param_ext.hem = {'R'};
db(3).param_ext.area = {{'M1','DLS','VPL'}};
db(3).param_ext.class = {'L20'};

db(4).param_ext.rec = {'/home/controlmotor/Aquiles/Fractales Biomarcador/Database/2. Lesion Temprana/Arturo (Suj02)/arturo2_2017-05-29_11-38-35/arturo2_2017-05-29_11-38-35.mat'};
db(4).param_ext.seg = {[0,5]}; % 0,5
db(4).param_ext.dbType = {'bm'}; % bm o trat
db(4).param_ext.hem = {'R'}; % L, R o LR
db(4).param_ext.area = {{'M1','DLS','VPL'}};
db(4).param_ext.class = {'L20'};

db(5).param_ext.rec = {'/home/controlmotor/Aquiles/Fractales Biomarcador/Database/2. Lesion Temprana/Charles (Suj03)/charles_2017-06-05_10-26-26/charles_2017-06-05_10-26-26.mat'};
db(5).param_ext.seg = {[0,5]}; % 0,5
db(5).param_ext.dbType = {'bm'}; % bm o trat
db(5).param_ext.hem = {'R'}; % L, R o LR
db(5).param_ext.area = {{'M1','DLS','VPL'}};
db(5).param_ext.class = {'L20'};

db(6).param_ext.rec = {'/home/controlmotor/Aquiles/Fractales Biomarcador/Database/3. Lesion Intermedia/Maravilla (Suj01)/maravilla_2017-06-17_16-39-32/maravilla_2017-06-17_16-39-32.mat'};
db(6).param_ext.seg = {[1,6]};
db(6).param_ext.dbType = {'bm'}; % bm o trat
db(6).param_ext.hem = {'R'}; % L, R o LR
db(6).param_ext.area = {{'M1','DLS','VPL'}};
db(6).param_ext.class = {'L30'};

db(7).param_ext.rec = {'/home/controlmotor/Aquiles/Fractales Biomarcador/Database/3. Lesion Intermedia/Arturo (Suj02)/arturo_2017-06-09_15-24-39/arturo_2017-06-09_15-24-39.mat'};
db(7).param_ext.seg = {[1,6]};
db(7).param_ext.dbType = {'bm'}; % bm o trat
db(7).param_ext.hem = {'R'}; % L, R o LR
db(7).param_ext.area = {{'M1','DLS','VPL'}};
db(7).param_ext.class = {'L30'};

db(8).param_ext.rec = {'/home/controlmotor/Aquiles/Fractales Biomarcador/Database/3. Lesion Intermedia/Charles (Suj03)/charles_2017-06-16_17-07-38/charles_2017-06-16_17-07-38.mat'};
db(8).param_ext.seg = {[1,6]};
db(8).param_ext.dbType = {'bm'}; % bm o trat
db(8).param_ext.hem = {'R'}; % L, R o LR
db(8).param_ext.area = {{'M1','DLS','VPL'}};
db(8).param_ext.class = {'L30'};

db(9).param_ext.rec = {'/home/controlmotor/Aquiles/Fractales Biomarcador/Database/4. Lesion Tardia/Maravilla (Suj01)/maravilla_2017-07-04_15-19-26/maravilla_2017-07-04_15-19-26.mat'};
db(9).param_ext.seg = {[0,5]};
db(9).param_ext.dbType = {'bm'}; % bm o trat
db(9).param_ext.hem = {'R'}; % L, R o LR
db(9).param_ext.area = {{'M1','DLS','VPL'}};
db(9).param_ext.class = {'L50'};

db(10).param_ext.rec = {'/home/controlmotor/Aquiles/Fractales Biomarcador/Database/4. Lesion Tardia/Arturo (Suj02)/arturo3_2017-07-04_15-48-06/arturo3_2017-07-04_15-48-06.mat'};
db(10).param_ext.seg = {[0,5]};
db(10).param_ext.dbType = {'bm'}; % bm o trat
db(10).param_ext.hem = {'R'}; % L, R o LR
db(10).param_ext.area = {{'M1','DLS','VPL'}};
db(10).param_ext.class = {'L50'};

db(11).param_ext.rec = {'/home/controlmotor/Aquiles/Fractales Biomarcador/Database/4. Lesion Tardia/Alex (Suj05)/CA_EC03_C14_CS300__2018-09-28_16-38-37/CA_EC03_C14_CS300__2018-09-28_16-38-37.mat'};
db(11).param_ext.seg = {[0,5]};
db(11).param_ext.dbType = {'bm'}; % bm o trat
db(11).param_ext.hem = {'R'}; % L, R o LR
db(11).param_ext.area = {{'CFA','STR','VPL'}};
db(11).param_ext.class = {'L50'};


databaseMeta = db;

for idx_rec = 1:length(db)
    %disp(param_ext(idx_rec).rec)
    disp(['Loading ',db(idx_rec).param_ext.rec{:}])
    load(db(idx_rec).param_ext.rec{:})
    clearvars mat_variables_seg
    clearvars labels_Var_seg
    
    path_actual = fileparts(db(idx_rec).param_ext.rec{:});
    
    canales_eval = find(~[registroLFP.channels.removed]);
    slash_system = foldername(length(foldername));

    [C,ia,ic] = unique({registroLFP.channels(canales_eval).area},'stable');

    for idx_seg = 1:length(db(idx_rec).param_ext.seg)
        hemisf_actual = db(idx_rec).param_ext.hem{idx_seg};
        clearvars mat_variables_areaHem
        clearvars labels_Var_areaHem
        
        for idx_hem = 1:length(hemisf_actual)
            for idx_area = 1:length(db(idx_rec).param_ext.area{idx_seg})
                %disp(param_ext(idx_rec).seg{idx_seg})
                %disp(param_ext(idx_rec).dbType(idx_seg))
                %disp(param_ext(idx_rec).hem{idx_seg})
                %disp(param_ext(idx_rec).area{idx_seg}{idx_area})
                
                area_actual = db(idx_rec).param_ext.area{idx_seg}{idx_area};

                m = find(strcmp(C,[lower(hemisf_actual(idx_hem)),area_actual]));

                osciSpect = registroLFP.areas(m).spectrogram.oscillations.mag;
                fractalSpect = registroLFP.areas(m).spectrogram.fractals.mag;

                idx_spect_artifacts = registroLFP.areas(m).idx_artifacts;
                freq = registroLFP.areas(m).spectrogram.frequency;
                time = registroLFP.areas(m).spectrogram.time;   
                
                time_range = db(idx_rec).param_ext.seg{idx_seg}*60;

                % Extraer variables
                [mat_variables, labels_Var] = spectralVariables(osciSpect, fractalSpect, freq);
                
                % Extraer caractersiticas
                [mat_features, labels_features] = spectralFeatures(mat_variables, labels_Var, time, time_range, idx_spect_artifacts);

                View_Spectral_Var;
                
                % Almacenar en base de datos adecuada
                mat_variables_areaHem(:,:,idx_area+(idx_hem-1)*length(db(idx_rec).param_ext.area{idx_seg})) = mat_variables;
                labels_Var_areaHem(:,idx_area+(idx_hem-1)*length(db(idx_rec).param_ext.area{idx_seg})) = labels_Var;
                
                mat_features_areaHem(idx_area+(idx_hem-1)*length(db(idx_rec).param_ext.area{idx_seg}),:) = mat_features;
                labels_features_areaHem(idx_area+(idx_hem-1)*length(db(idx_rec).param_ext.area{idx_seg}),:) = labels_features;                
                         
            end
        end
        mat_variables_seg{idx_seg} = mat_variables_areaHem;
        labels_Var_seg{idx_seg} = labels_Var_areaHem;
        
        mat_features_seg{idx_seg} = mat_features_areaHem;
        labels_features_seg{idx_seg} = labels_features_areaHem;
        disp('Seg finished')
    end
    databaseMeta(idx_rec).mat_variables = mat_variables_seg;
    databaseMeta(idx_rec).labels_variables = labels_Var_seg;
    
    databaseMeta(idx_rec).mat_features = mat_features_seg;
    databaseMeta(idx_rec).labels_features = labels_features_seg;
    disp('Rec finished')
end



for i = 1:3
    features = [features; databaseMeta(i).mat_features{1,1}(1,:), databaseMeta(i).mat_features{1,1}(2,:), databaseMeta(i).mat_features{1,1}(3,:)];
end







