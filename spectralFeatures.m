function [mat_features, labels_features] = spectralFeatures(mat_var, labels_var, time, time_range, idx_spect_artifacts)


%disp('Extracting spectral features')

idx_noArtif = find(idx_spect_artifacts(time > time_range(1) & time < time_range(2)));

mat_features = [];
labels_features = {};


%% Full time

%% Puras
% Pmix beta
idx_feat = find(strcmp(labels_var, 'Pmix beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Pmix_b_m'};

% Po delta
idx_feat = find(strcmp(labels_var, 'Po delta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_d_m'};

% Po tetha
idx_feat = find(strcmp(labels_var, 'Po tetha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_t_m'};

% Po alpha
idx_feat = find(strcmp(labels_var, 'Po alpha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_a_m'};

% Po beta
idx_feat = find(strcmp(labels_var, 'Po beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_b_m'};

% Po gammaL
idx_feat = find(strcmp(labels_var, 'Po gammaL'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_gL_m'};

% Po gammaH 
idx_feat = find(strcmp(labels_var, 'Po gammaH'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_gH_m'};

% Psf widthband
idx_feat = find(strcmp(labels_var, 'Psf widthband'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Psf_wb_m'};

% Dsf widthband
idx_feat = find(strcmp(labels_var, 'Dsf widthband'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Dsf_wb_m'};


% Dominant frequency 
idx_feat = find(strcmp(labels_var, 'Dominant frequency'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Dom_f_m'};

%% Norm gammaL
% Var norm mix
idx_feat = find(strcmp(labels_var, 'Pmix gammaL'));
var_norm_mix = mat_var(time > time_range(1) & time < time_range(2), idx_feat);

% Pmix beta
idx_feat = find(strcmp(labels_var, 'Pmix beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm_mix(idx_noArtif))];
labels_features = {labels_features{:}, 'Pmix_b_m_normL'};

% Var norm osc
idx_feat = find(strcmp(labels_var, 'Po gammaL'));
var_norm = mat_var(time > time_range(1) & time < time_range(2), idx_feat);

% Po delta
idx_feat = find(strcmp(labels_var, 'Po delta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_d_m_normL'};

% Po tetha
idx_feat = find(strcmp(labels_var, 'Po tetha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_t_m_normL'};

% Po alpha
idx_feat = find(strcmp(labels_var, 'Po alpha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_a_m_normL'};

% Po beta
idx_feat = find(strcmp(labels_var, 'Po beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_b_m_normL'};

% Po gammaH 
idx_feat = find(strcmp(labels_var, 'Po gammaH'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_gH_m_normL'};

%% Norm gammaH
% Var norm mix
idx_feat = find(strcmp(labels_var, 'Pmix gammaH'));
var_norm_mix = mat_var(time > time_range(1) & time < time_range(2), idx_feat);

% Pmix beta
idx_feat = find(strcmp(labels_var, 'Pmix beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm_mix(idx_noArtif))];
labels_features = {labels_features{:}, 'Pmix_b_m_normH'};

% Var norm osc
idx_feat = find(strcmp(labels_var, 'Po gammaH'));
var_norm = mat_var(time > time_range(1) & time < time_range(2), idx_feat);

% Po delta
idx_feat = find(strcmp(labels_var, 'Po delta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_d_m_normH'};

% Po tetha
idx_feat = find(strcmp(labels_var, 'Po tetha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_t_m_normH'};

% Po alpha
idx_feat = find(strcmp(labels_var, 'Po alpha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_a_m_normH'};

% Po beta
idx_feat = find(strcmp(labels_var, 'Po beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_b_m_normH'};

% Po gammaL 
idx_feat = find(strcmp(labels_var, 'Po gammaL'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif)) / median(var_norm(idx_noArtif))];
labels_features = {labels_features{:}, 'Po_gL_m_normH'};

%% Alzas %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Puras
% Pmix beta
idx_feat = find(strcmp(labels_var, 'Pmix beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure];
labels_features = {labels_features{:}, 'Pmix_b_a'};


% Po delta
idx_feat = find(strcmp(labels_var, 'Po delta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure];
labels_features = {labels_features{:}, 'Po_d_a'};

% Po tetha
idx_feat = find(strcmp(labels_var, 'Po tetha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure];
labels_features = {labels_features{:}, 'Po_t_a'};

% Po alpha
idx_feat = find(strcmp(labels_var, 'Po alpha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure];
labels_features = {labels_features{:}, 'Po_a_a'};

% Po beta
idx_feat = find(strcmp(labels_var, 'Po beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure];
labels_features = {labels_features{:}, 'Po_b_a'};

% Po gammaL
idx_feat = find(strcmp(labels_var, 'Po gammaL'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure];
labels_features = {labels_features{:}, 'Po_gL_a'};

% Po gammaH
idx_feat = find(strcmp(labels_var, 'Po gammaH'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure];
labels_features = {labels_features{:}, 'Po_gH_a'};

% Psf widthband
idx_feat = find(strcmp(labels_var, 'Psf widthband'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure];
labels_features = {labels_features{:}, 'Psf_wb_a'};

% Dsf widthband
idx_feat = find(strcmp(labels_var, 'Dsf widthband')); % Usar el mismo idx_pk_osci de widthband
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure];
labels_features = {labels_features{:}, 'Dsf_wb_a'};

%% Norm gammaL
% Var norm mix
idx_feat = find(strcmp(labels_var, 'Pmix gammaL'));
var_norm_mix = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_norm_mix(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure_norm_mix = median(var_norm_mix(idx_noArtif(idx_pk_osci)));
if isnan(var_measure_norm_mix)
    var_measure_norm_mix = 0;
end

% Pmix beta
idx_feat = find(strcmp(labels_var, 'Pmix beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm_mix];
labels_features = {labels_features{:}, 'Pmix_b_a_normL'};


% Var norm 
idx_feat = find(strcmp(labels_var, 'Po gammaL'));
var_norm = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_norm(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure_norm = median(var_norm(idx_noArtif(idx_pk_osci)));
if isnan(var_measure_norm)
    var_measure_norm = 0;
end

% Po delta
idx_feat = find(strcmp(labels_var, 'Po delta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm];
labels_features = {labels_features{:}, 'Po_d_a_normL'};

% Po tetha
idx_feat = find(strcmp(labels_var, 'Po tetha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm];
labels_features = {labels_features{:}, 'Po_t_a_normL'};

% Po alpha
idx_feat = find(strcmp(labels_var, 'Po alpha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm];
labels_features = {labels_features{:}, 'Po_a_a_normL'};

% Po beta
idx_feat = find(strcmp(labels_var, 'Po beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm];
labels_features = {labels_features{:}, 'Po_b_a_normL'};

% Po gammaH
idx_feat = find(strcmp(labels_var, 'Po gammaH'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm];
labels_features = {labels_features{:}, 'Po_gH_a_normL'};

%% Norm gammaH
% Var norm mix
idx_feat = find(strcmp(labels_var, 'Pmix gammaH'));
var_norm_mix = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_norm_mix(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure_norm_mix = median(var_norm_mix(idx_noArtif(idx_pk_osci)));
if isnan(var_measure_norm_mix)
    var_measure_norm_mix = 0;
end

% Pmix beta
idx_feat = find(strcmp(labels_var, 'Pmix beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm_mix];
labels_features = {labels_features{:}, 'Pmix_b_a_normH'};


% Var norm 
idx_feat = find(strcmp(labels_var, 'Po gammaH'));
var_norm = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_norm(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure_norm = median(var_norm(idx_noArtif(idx_pk_osci)));
if isnan(var_measure_norm)
    var_measure_norm = 0;
end

% Po delta
idx_feat = find(strcmp(labels_var, 'Po delta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm];
labels_features = {labels_features{:}, 'Po_d_a_normH'};

% Po tetha
idx_feat = find(strcmp(labels_var, 'Po tetha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm];
labels_features = {labels_features{:}, 'Po_t_a_normH'};

% Po alpha
idx_feat = find(strcmp(labels_var, 'Po alpha'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm];
labels_features = {labels_features{:}, 'Po_a_a_normH'};

% Po beta
idx_feat = find(strcmp(labels_var, 'Po beta'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm];
labels_features = {labels_features{:}, 'Po_b_a_normH'};

% Po gammaL
idx_feat = find(strcmp(labels_var, 'Po gammaL'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
try
    [idx_pk_osci,~,~,~,~] = highPowerBetaPkEvent(normalize(var_actual(idx_noArtif)), 0.4);%min_th(i));
catch
    idx_pk_osci = [];
end
var_measure = median(var_actual(idx_noArtif(idx_pk_osci)));
if isnan(var_measure)
    var_measure = 0;
end
mat_features = [mat_features, var_measure / var_measure_norm];
labels_features = {labels_features{:}, 'Po_gL_a_normH'};


end