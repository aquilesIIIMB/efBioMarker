%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% main_creating.m
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all

db(1).param_ext.rec = {'D:\Descargas\Trabajo de titulo\Images\+2500_300Hz\maravilla_2017-06-17_16-39-32\maravilla_2017-06-17_16-39-32.mat'};
db(1).param_ext.seg = {[1,6]};
db(1).param_ext.dbType = {'bm'}; % bm o trat
db(1).param_ext.hem = {'R'}; % L, R o LR
db(1).param_ext.area = {{'M1','DLS','VPL'}};

db(2).param_ext.rec = {'D:\Descargas\Trabajo de titulo\Images\+2500_300Hz\maravilla_2017-06-17_16-39-32\maravilla_2017-06-17_16-39-32.mat'};
db(2).param_ext.seg = {[1,6], [7,12]};
db(2).param_ext.dbType = {'bm','trat'};
db(2).param_ext.hem = {'L', 'R'};
db(2).param_ext.area = {{'M1','DLS','VPL'}, {'M1','DLS'}};


databaseMeta = db;

for idx_rec = 1:length(db)
    %disp(param_ext(idx_rec).rec)
    disp(['Loading ',db(idx_rec).param_ext.rec{:}])
    load(db(idx_rec).param_ext.rec{:})
    clearvars mat_variables_seg
    clearvars labels_Var_seg
    
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

                [mat_variables, labels_Var] = spectralVariables(osciSpect, fractalSpect, freq);

                View_Spectral_Var;
                
                mat_variables_areaHem(:,:,idx_area+(idx_hem-1)*length(db(idx_rec).param_ext.area{idx_seg})) = mat_variables;
                labels_Var_areaHem(:,idx_area+(idx_hem-1)*length(db(idx_rec).param_ext.area{idx_seg})) = labels_Var;
                
                % Extraer caractersiticas, ver seg y metrica
                % Almacenar en base de datos adecuada
                
            end
        end
        mat_variables_seg{idx_seg} = mat_variables_areaHem;
        labels_Var_seg{idx_seg} = labels_Var_areaHem;
        disp('Seg finished')
    end
    databaseMeta(idx_rec).mat_variables = mat_variables_seg;
    databaseMeta(idx_rec).labels_Var = labels_Var_seg;
    disp('Rec finished')
end











