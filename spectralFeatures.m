function [mat_features, labels_features] = spectralFeatures(mat_var, labels_var, time, time_range, idx_spect_artifacts)


%disp('Extracting spectral features')

%{
min_th = [600; 100; 600; 600; 200; 50;...
    10; 100; 0.3; 1; 1; 1;...
    1; 20; 20; 20; 20; 2];
%}

idx_noArtif = find(idx_spect_artifacts(time > time_range(1) & time < time_range(2)));

mat_features = [];
labels_features = {};

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

%{
% Rate delta/gammaL
idx_feat = find(strcmp(labels_var, 'Rate delta-gammaL'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Rate_d-gL_m'};

% Rate tetha/gammaL
idx_feat = find(strcmp(labels_var, 'Rate tetha-gammaL'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Rate_t-gL_m'};

% Rate alpha/gammaL
idx_feat = find(strcmp(labels_var, 'Rate alpha-gammaL'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Rate_a-gL_m'};

% Rate beta/gammaL
idx_feat = find(strcmp(labels_var, 'Rate beta-gammaL'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Rate_b-gL_m'};

% Rate delta/gammaH
idx_feat = find(strcmp(labels_var, 'Rate delta-gammaH'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Rate_d-gH_m'};

% Rate tetha/gammaH
idx_feat = find(strcmp(labels_var, 'Rate tetha-gammaH'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Rate_t-gH_m'};

% Rate alpha/gammaH
idx_feat = find(strcmp(labels_var, 'Rate alpha-gammaH'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Rate_a-gH_m'};

% Rate beta/gammaH
idx_feat = find(strcmp(labels_var, 'Rate beta-gammaH'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Rate_b-gH_m'};
%}

% Dominant frequency 
idx_feat = find(strcmp(labels_var, 'Dominant frequency'));
var_actual = mat_var(time > time_range(1) & time < time_range(2), idx_feat);
mat_features = [mat_features, median(var_actual(idx_noArtif))];
labels_features = {labels_features{:}, 'Dom_f_m'};


%%% Alzas
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

%{
% 
idx_feat = find(strcmp(labels_var, 'Rate delta-gammaL'));
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
labels_features = {labels_features{:}, 'Rate_d-gL_a'};

% 
idx_feat = find(strcmp(labels_var, 'Rate tetha-gammaL'));
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
labels_features = {labels_features{:}, 'Rate_t-gL_a'};

% 
idx_feat = find(strcmp(labels_var, 'Rate alpha-gammaL'));
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
labels_features = {labels_features{:}, 'Rate_a-gL_a'};

% 
idx_feat = find(strcmp(labels_var, 'Rate beta-gammaL'));
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
labels_features = {labels_features{:}, 'Rate_b-gL_a'};

% 
idx_feat = find(strcmp(labels_var, 'Rate delta-gammaH'));
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
labels_features = {labels_features{:}, 'Rate_d-gH_a'};

% 
idx_feat = find(strcmp(labels_var, 'Rate tetha-gammaH'));
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
labels_features = {labels_features{:}, 'Rate_t-gH_a'};

% 
idx_feat = find(strcmp(labels_var, 'Rate alpha-gammaH'));
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
labels_features = {labels_features{:}, 'Rate_a-gH_a'};

% 
idx_feat = find(strcmp(labels_var, 'Rate beta-gammaH'));
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
labels_features = {labels_features{:}, 'Rate_b-gH_a'};
%}


end