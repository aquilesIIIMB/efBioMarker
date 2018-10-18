% ranking of features

subjects = {[1:7];[1:4];[1:6]}; % 1:11

areas_total_temp = [];
accuracy_Gen_total_temp = [];
accuracy_C_total_temp = [];
accuracy_LI_total_temp = [];
accuracy_LM_total_temp = [];
accuracy_LA_total_temp = [];

for area_eval = 1:3
    for features_eval = 1:5
        %disp(['area: ',int2str(area_eval)])
        %disp(['feature: ',int2str(features_eval)])
        %comb_subj = [1,2,3, 5,6,7, 9,10,11, 13,14,15;...
        %    1,2,4, 5,6,8, 9,10,12, 13,14,16;...
        %    1,4,3, 5,8,7, 9,12,11, 13,16,15;...
        %    4,2,3, 8,6,7, 12,10,11, 16,14,15;];
        %comb_subj_test = [4,8,12,16;...
        %    3,7,11,15;...
        %    2,6,10,14;...
        %    1,5,9,13];
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

            [pred_test, confM_train, confM_test, predM_trat] = svmTreeBM(subjects, area_eval, {features_eval}, comb_subj(i,:), comb_subj_test(i,:), BiomarkerDataBase_EP, Labels_BM_EP, BiomarkerDataBase_trat, Labels_BM_trat);

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

        %disp('Matrix confusion test')
        %disp(confM_test_total)
        %disp('Accuracy general')
        %disp(accuracy_Gen)
        %disp('Accuracy control')
        %disp(accuracy_C)
        %disp('Accuracy lesion-inicial')
        %disp(accuracy_LI)
        %disp('Accuracy lesion-media')
        %disp(accuracy_LM)
        %disp('Accuracy lesion-avanzada')
        %disp(accuracy_LA)
        
        areas_total_temp = [areas_total_temp;area_eval,features_eval];
        accuracy_Gen_total_temp = [accuracy_Gen_total_temp;accuracy_Gen];
        accuracy_C_total_temp = [accuracy_C_total_temp;accuracy_C];
        accuracy_LI_total_temp = [accuracy_LI_total_temp;accuracy_LI];
        accuracy_LM_total_temp = [accuracy_LM_total_temp;accuracy_LM];
        accuracy_LA_total_temp = [accuracy_LA_total_temp;accuracy_LA];
        
    end
end

[accuracy_Gen_total, I] = sort(accuracy_Gen_total_temp,'descend');
areas_total = areas_total_temp(I,:);
accuracy_C_total = accuracy_C_total_temp(I,:);
accuracy_LI_total = accuracy_LI_total_temp(I,:);
accuracy_LM_total = accuracy_LM_total_temp(I,:);
accuracy_LA_total = accuracy_LA_total_temp(I,:);
accuracy_all = [areas_total,accuracy_C_total,accuracy_LI_total,...
    accuracy_LM_total,accuracy_LA_total,accuracy_Gen_total];
%disp(['    Areas   Features','  Accuracy'])
%disp(accuracy_all)

[accuracy_Gen_total, I] = sort(accuracy_Gen_total_temp,'descend');
areas_total = areas_total_temp(I,:);
accuracy_Gen_total = [areas_total,accuracy_Gen_total];
disp(['    Areas   Features','  Accuracy general'])
disp(accuracy_Gen_total)

[accuracy_C_total, I] = sort(accuracy_C_total_temp,'descend');
areas_total = areas_total_temp(I,:);
accuracy_C_total = [areas_total,accuracy_C_total];
disp(['    Areas   Features','  Accuracy control'])
disp(accuracy_C_total)

[accuracy_LI_total, I] = sort(accuracy_LI_total_temp,'descend');
areas_total = areas_total_temp(I,:);
accuracy_LI_total = [areas_total,accuracy_LI_total];
disp(['    Areas   Features','  Accuracy lesion-inicial'])
disp(accuracy_LI_total)

[accuracy_LM_total, I] = sort(accuracy_LM_total_temp,'descend');
areas_total = areas_total_temp(I,:);
accuracy_LM_total = [areas_total,accuracy_LM_total];
disp(['    Areas   Features','  Accuracy lesion-media'])
disp(accuracy_LM_total)

[accuracy_LA_total, I] = sort(accuracy_LA_total_temp,'descend');
areas_total = areas_total_temp(I,:);
accuracy_LA_total = [areas_total,accuracy_LA_total];
disp(['    Areas   Features','  Accuracy lesion-avanzada'])
disp(accuracy_LA_total)


accuracy_STR_total = [mean(accuracy_all((accuracy_all(:,1) == 1),3)),...
    mean(accuracy_all((accuracy_all(:,1) == 1),4)),...
    mean(accuracy_all((accuracy_all(:,1) == 1),5)),...
    mean(accuracy_all((accuracy_all(:,1) == 1),6)),...
    mean(accuracy_all((accuracy_all(:,1) == 1),7))];
accuracy_S1_total = [mean(accuracy_all((accuracy_all(:,1) == 2),3)),...
    mean(accuracy_all((accuracy_all(:,1) == 2),4)),...
    mean(accuracy_all((accuracy_all(:,1) == 2),5)),...
    mean(accuracy_all((accuracy_all(:,1) == 2),6)),...
    mean(accuracy_all((accuracy_all(:,1) == 2),7))];
accuracy_SMA_total = [mean(accuracy_all((accuracy_all(:,1) == 3),3)),...
    mean(accuracy_all((accuracy_all(:,1) == 3),4)),...
    mean(accuracy_all((accuracy_all(:,1) == 3),5)),...
    mean(accuracy_all((accuracy_all(:,1) == 3),6)),...
    mean(accuracy_all((accuracy_all(:,1) == 3),7))];
accuracy_M1_total = [mean(accuracy_all((accuracy_all(:,1) == 4),3)),...
    mean(accuracy_all((accuracy_all(:,1) == 4),4)),...
    mean(accuracy_all((accuracy_all(:,1) == 4),5)),...
    mean(accuracy_all((accuracy_all(:,1) == 4),6)),...
    mean(accuracy_all((accuracy_all(:,1) == 4),7))];
accuracy_VPL_total = [mean(accuracy_all((accuracy_all(:,1) == 5),3)),...
    mean(accuracy_all((accuracy_all(:,1) == 5),4)),...
    mean(accuracy_all((accuracy_all(:,1) == 5),5)),...
    mean(accuracy_all((accuracy_all(:,1) == 5),6)),...
    mean(accuracy_all((accuracy_all(:,1) == 5),7))];
%{
disp('Accuracy of STR')
disp(accuracy_STR_total)
disp('Accuracy of S1')
disp(accuracy_S1_total)
disp('Accuracy of SMA')
disp(accuracy_SMA_total)
disp('Accuracy of M1')
disp(accuracy_M1_total)
disp('Accuracy of VPL')
disp(accuracy_VPL_total)
%}
disp('Accuracy of M1')
disp(accuracy_STR_total)
disp('Accuracy of STR')
disp(accuracy_S1_total)
disp('Accuracy of VPL')
disp(accuracy_SMA_total)
disp(' ')

accuracy_Po_total = [mean(accuracy_all((accuracy_all(:,2) == 1),3)),...
    mean(accuracy_all((accuracy_all(:,2) == 1),4)),...
    mean(accuracy_all((accuracy_all(:,2) == 1),5)),...
    mean(accuracy_all((accuracy_all(:,2) == 1),6)),...
    mean(accuracy_all((accuracy_all(:,2) == 1),7))];
accuracy_Psf_total = [mean(accuracy_all((accuracy_all(:,2) == 2),3)),...
    mean(accuracy_all((accuracy_all(:,2) == 2),4)),...
    mean(accuracy_all((accuracy_all(:,2) == 2),5)),...
    mean(accuracy_all((accuracy_all(:,2) == 2),6)),...
    mean(accuracy_all((accuracy_all(:,2) == 2),7))];
accuracy_D2_total = [mean(accuracy_all((accuracy_all(:,2) == 3),3)),...
    mean(accuracy_all((accuracy_all(:,2) == 3),4)),...
    mean(accuracy_all((accuracy_all(:,2) == 3),5)),...
    mean(accuracy_all((accuracy_all(:,2) == 3),6)),...
    mean(accuracy_all((accuracy_all(:,2) == 3),7))];
accuracy_D3_total = [mean(accuracy_all((accuracy_all(:,2) == 4),3)),...
    mean(accuracy_all((accuracy_all(:,2) == 4),4)),...
    mean(accuracy_all((accuracy_all(:,2) == 4),5)),...
    mean(accuracy_all((accuracy_all(:,2) == 4),6)),...
    mean(accuracy_all((accuracy_all(:,2) == 4),7))];
accuracy_D4_total = [mean(accuracy_all((accuracy_all(:,2) == 5),3)),...
    mean(accuracy_all((accuracy_all(:,2) == 5),4)),...
    mean(accuracy_all((accuracy_all(:,2) == 5),5)),...
    mean(accuracy_all((accuracy_all(:,2) == 5),6)),...
    mean(accuracy_all((accuracy_all(:,2) == 5),7))];

disp('General accuracy of Po')
disp(accuracy_Po_total)
disp('General accuracy of Psf')
disp(accuracy_Psf_total)
disp('General accuracy of D2')
disp(accuracy_D2_total)
disp('General accuracy of D3')
disp(accuracy_D3_total)
disp('General accuracy of D4')
disp(accuracy_D4_total)



