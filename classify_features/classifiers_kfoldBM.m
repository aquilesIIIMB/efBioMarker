% kfold classifiers

subjects = {[1:7];[1:4];[1:6]}; % 
areas = [1,2]; % 
features = {[4],[1]}; %

%{
comb_subj = [1,2,3, 5,6,7, 9,10,11, 13,14,15;...
    1,2,4, 5,6,8, 9,10,12, 13,14,16;...
    1,4,3, 5,8,7, 9,12,11, 13,16,15;...
    4,2,3, 8,6,7, 12,10,11, 16,14,15;];
comb_subj_test = [4,8,12,16;...
    3,7,11,15;...
    2,6,10,14;...
    1,5,9,13];
%}
comb_subj = [1, 3,4, 6,7, 9,10;...
    1, 3,5, 6,8, 9,11;...
    1, 5,4, 8,7, 11,10;...
    2, 3,4, 6,7, 9,10;...
    2, 3,5, 6,8, 9,11;...
    2, 5,4, 8,7, 11,10];
comb_subj_test = [2,5,8,11;...
    2,4,7,10;...
    2,3,6,9;...
    1,5,8,11;...
    1,4,7,10;...
    1,3,6,9];


for i = 1:size(comb_subj,1)
    
    [pred_test, confM_train, confM_test, predM_trat] = svmTreeBM(subjects, areas, features, comb_subj(i,:), comb_subj_test(i,:), BiomarkerDataBase_EP, Labels_BM_EP, BiomarkerDataBase_trat, Labels_BM_trat);

    confM_train_temp(:,:,i) = confM_train;
    confM_test_temp(:,:,i) = confM_test;
    predM_trat_total(:,:,i) = predM_trat;
end

confM_train_total = sum(confM_train_temp, 3);
confM_test_total = sum(confM_test_temp, 3);
%predM_trat_total

%100*sum(diag(confM_train_total))/sum(sum(confM_train_total))
accuracy_Gen = 100*sum(diag(confM_test_total))/sum(sum(confM_test_total));
accuracy_C = 100*confM_test_total(1,1)/sum(confM_test_total(1,:));
accuracy_LI = 100*confM_test_total(2,2)/sum(confM_test_total(2,:));
accuracy_LM = 100*confM_test_total(3,3)/sum(confM_test_total(3,:));
accuracy_LA = 100*confM_test_total(4,4)/sum(confM_test_total(4,:));

disp('Matrix confusion test')
disp(confM_test_total)
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
