% Comportamiento del biomarcador en el set de exemplo
%%% Codigo para agregar un exemplo para probar el BM
%%% Testeo y tratado


subjects = {[1:7];[1:4];[1:6]}; % 1:11
areas = [1,2]; % 1,2 Best para este conjunt 1,2 Best 6-fold
features = {[4],[1]}; % [1,2,4,5],[1] Best para este conjunt [4],[1] Best 6-fold

comb_subj = [1, 3,4, 6,7, 9,10];
comb_subj_test = [2,5,8,11];

[pred_test, confM_train, confM_test, predM_trat] = svmTreeBM(subjects, areas, features, comb_subj, comb_subj_test, BiomarkerDataBase_EP, Labels_BM_EP, BiomarkerDataBase_trat, Labels_BM_trat);

accuracy_Gen = 100*sum(diag(confM_test))/sum(sum(confM_test));
accuracy_C = 100*confM_test(1,1)/sum(confM_test(1,:));
accuracy_LI = 100*confM_test(2,2)/sum(confM_test(2,:));
accuracy_LM = 100*confM_test(3,3)/sum(confM_test(3,:));
accuracy_LA = 100*confM_test(4,4)/sum(confM_test(4,:));

disp('Matrix confusion train')
disp(confM_train)
disp('Matrix confusion test')
disp(confM_test)
disp('Classification treated')
disp(predM_trat)
disp('Accuracy general')
disp(accuracy_Gen)
disp('Accuracy control')
disp(accuracy_C)
disp('Accuracy lesion-inicial')
disp(accuracy_LI)
disp('Accuracy lesion-media')
disp(accuracy_LM)
disp('Accuracy lesion-avanzada')
disp(accuracy_LA)



[idxPk_test, idxPk_trat, idxPk_train, limAreasClasses, cm_train] = parkinsonismIndex(subjects, areas, features, comb_subj, comb_subj_test, BiomarkerDataBase_EP, Labels_BM_EP, BiomarkerDataBase_trat, Labels_BM_trat, 'origine');

disp('Areas limits of Parkinsonism Index')
disp(limAreasClasses)
disp('Parkinsonism Index of train')
disp(idxPk_train)
disp('Parkinsonism Index of test')
disp(idxPk_test)
disp('Parkinsonism Index of treated')
disp(idxPk_trat)

