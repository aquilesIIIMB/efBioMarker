% main
clear
%{
load('BM_train.mat') % Normalizacion
load('BM_test.mat')
load('BM_valid.mat')

load('BM_train_raw.mat')
load('BM_test_raw.mat')
load('BM_valid_raw.mat')

BiomarkerDataBase_train(12,:) = BiomarkerDataBase_train(8,:);

BiomarkerDataBase_EP = [BiomarkerDataBase_train(1:12,:);BiomarkerDataBase_test];
Labels_BM_EP = [Labels_BM_train(1:12);Labels_BM_test];

[Labels_BM_EP,I] = sort(Labels_BM_EP);
BiomarkerDataBase_EP = BiomarkerDataBase_EP(I,:);

BiomarkerDataBase_trat = [BiomarkerDataBase_pre;BiomarkerDataBase_on;BiomarkerDataBase_post];
Labels_BM_trat = [Labels_BM_pre;Labels_BM_on;Labels_BM_post];
%}
load('biomarkerDB3AreasMeanPotentials_raw.mat')

rankingFeatures;

classifiers_kfoldBM;

parkinsonismIdx_kfoldBM;

tryBMsetExample;

plotFiguresBM;






