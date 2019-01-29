function [mat_features, labels_features] = spectralFeatures(mat_var, labels_var, time, time_range, idx_spect_artifacts)


%disp('Extracting spectral features')

idx_noArtif = find(idx_spect_artifacts(time > time_range(1) & time < time_range(2)));

mat_features = [];
labels_features = {};


%% Full time

['Pmix_b_m',
'Po_d_m',
'Po_t_m',
'Po_a_m',
'Po_b_m',
'Po_gL_m',
'Po_gH_m',
'Psf_wb_m',
'Dsf_wb_m',
'Dom_f_m',
'Pmix_b_m_normL',
'Po_d_m_normL',
'Po_t_m_normL',
'Po_a_m_normL',
'Po_b_m_normL',
'Po_gH_m_normL',
'Pmix_b_m_normH',
'Po_d_m_normH',
'Po_t_m_normH',
'Po_a_m_normH',
'Po_b_m_normH',
'Po_gL_m_normH',    
'Pmix_b_a',
'Po_d_a',
'Po_t_a',
'Po_a_a',
'Po_b_a',
'Po_gL_a',
'Po_gH_a',
'Psf_wb_a',
'Dsf_wb_a',
'Pmix_b_a_normL',
'Po_d_a_normL',
'Po_t_a_normL',
'Po_a_a_normL',
'Po_b_a_normL',
'Po_gH_a_normL',
'Pmix_b_a_normH',
'Po_d_a_normH',
'Po_t_a_normH',
'Po_a_a_normH',
'Po_b_a_normH',
'Po_gL_a_normH',


end