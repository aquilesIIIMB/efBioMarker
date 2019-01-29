rank = [0.07606898, 0.10301852, 0.06453177, 0.08126815, 0.06919647,...
       0.08869201, 0.08274937, 0.07574666, 0.07863266, 0.10381656,...
       0.0424862 , 0.10295816, 0.06593039, 0.0488183 , 0.04177995,...
       0.10945732, 0.07389005, 0.09488635, 0.07346289, 0.05056905,...
       0.07102917, 0.10940495, 0.07080158, 0.05613769, 0.06496244,...
       0.08786786, 0.07158963, 0.08651018, 0.07151955, 0.07351212,...
       0.09036354, 0.06577114, 0.07008276, 0.04738682, 0.06327742,...
       0.06994921, 0.1088038 , 0.10981426, 0.05890556, 0.08176303,...
       0.08429938, 0.07331553, 0.11375488, 0.07025049, 0.06195115,...
       0.04840794, 0.06310858, 0.06467334, 0.09538691, 0.06227498,...
       0.0678209 , 0.04971801, 0.11346628, 0.0432049 , 0.08641088,...
       0.05903439, 0.04597617, 0.04459925, 0.07712931, 0.0570903 ,...
       0.07425839, 0.04221897, 0.05033411, 0.05237877, 0.07562394,...
       0.07348261, 0.07649927, 0.06189301, 0.07054775, 0.07171207,...
       0.0936668 , 0.06592623, 0.08064185, 0.08375781, 0.05265651,...
       0.07733879, 0.05294795, 0.04781083, 0.06065353, 0.06268798,...
       0.05349134, 0.08624022, 0.04282088, 0.05440609, 0.05358929,...
       0.06097881, 0.07581248, 0.04952994, 0.0764838 , 0.09608901,...
       0.07192795, 0.07662007, 0.10574554, 0.07817413, 0.04023406,...
       0.08260162, 0.04659328, 0.07667715, 0.04122272, 0.05108524,...
       0.04689384, 0.05644693, 0.04950186, 0.05667691, 0.0354713 ,...
       0.05146258, 0.04365987, 0.05417798, 0.08381206, 0.07001569,...
       0.08081939, 0.09094981, 0.08727062, 0.07823089, 0.10170484,...
       0.10364127, 0.03887078, 0.06271308, 0.07196821, 0.04723634,...
       0.096405  , 0.0696832 , 0.06938609, 0.06472269, 0.06275002,...
       0.0376723 , 0.07013989, 0.05786711, 0.07240257];
   
rank = [rank',linspace(1,129,129)'];   
   
[~,idx] = sort(rank(:,1),'descend'); % sort just the first column
sortedmat = rank(idx,:);

cm_control = [];
cm_l20 = [];
cm_l30 = [];
cm_l50 = [];

comb_idx_train = [1,2, 4,5, 7,8, 10,11; 1,2, 4,6, 7,9, 10,12; 1,2, 5,6, 8,9, 11,12;...
    1,3, 4,5, 7,8, 10,11;1,3, 4,6, 7,9, 10,12;1,3, 5,6, 8,9, 11,12;...
    2,3, 4,5, 7,8, 10,11; 2,3, 4,6, 7,9, 10,12; 2,3, 5,6, 8,9, 11,12];

comb_idx_test = [3, 6, 9, 12; 3, 5, 8, 11; 3, 4, 7, 10;...
    2, 6, 9, 12; 2, 5, 8, 11;2, 4, 7, 10;...
    1, 6, 9, 12; 1, 5, 8, 11; 1, 4, 7, 10];

totalfeatcv_test = [];

for i=1:1 %[1:14]
    totalcv_test = [];

    for k = 1:9
        BiomarkerDataBase_train = features(comb_idx_train(k,:),:);
        BiomarkerDataBase_test = features(comb_idx_test(k,:),:);
        BiomarkerDataBase_trat = features_trat;

        Labels_BM_train = [0,0,1,1,2,2,3,3];
        Labels_BM_test = [0,1,2,3];
        Labels_BM_trat = [3,3,3,3,3,3,3,3,3,3];

        %feature_select = sortedmat([18,6],2); ! best
        %feature_select = sortedmat([1:5],2);
        feature_select = sortedmat([37,43],2);

        %feature_select = sortedmat([1:i],2);
        %feature_select = sortedmat([i],2);

        % Desing of clasiffiers
        X_train_0 = BiomarkerDataBase_train(:,feature_select); %BiomarkerDataBase_train
        Y_train_0 = Labels_BM_train;
        Y_train_0(Y_train_0~=2 & Y_train_0~=3) = -10;
        Y_train_0(Y_train_0==2 | Y_train_0==3) = 10;
        X_test_0 = BiomarkerDataBase_test(:,feature_select); %BiomarkerDataBase_test
        Y_test_0 = Labels_BM_test;
        Y_test_0(Y_test_0~=2 & Y_test_0~=3) = -10;
        Y_test_0(Y_test_0==2 | Y_test_0==3) = 10;
        SVMModel_0 = fitcsvm(X_train_0,Y_train_0,'Standardize',true); % Verigud
        [y_pred_0,score_0] = predict(SVMModel_0,X_train_0);
        % 

        % 1 y demas 
        X_train_1 = BiomarkerDataBase_train((Labels_BM_train~=2 & Labels_BM_train~=3),feature_select); %BiomarkerDataBase_train
        Y_train_1 = Labels_BM_train((Labels_BM_train~=2 & Labels_BM_train~=3));
        Y_train_1(Y_train_1~=1) = 0;
        X_test_1 = BiomarkerDataBase_test((Labels_BM_test~=2 & Labels_BM_test~=3),feature_select); %BiomarkerDataBase_test
        Y_test_1 = Labels_BM_test((Labels_BM_test~=2 & Labels_BM_test~=3));
        Y_test_1(Y_test_1~=1) = 0;
        SVMModel_1 = fitcsvm(X_train_1,Y_train_1,'Standardize',true); % Verigud
        [y_pred_1,score_1] = predict(SVMModel_1,X_train_1);
        % 

        % 2 y demas  
        X_train_2 = BiomarkerDataBase_train((Labels_BM_train~=0 & Labels_BM_train~=1),feature_select); %BiomarkerDataBase_train
        Y_train_2 = Labels_BM_train(Labels_BM_train~=0 & Labels_BM_train~=1);
        %Y_train_2(Y_train_2~=3) = 10;
        X_test_2 = BiomarkerDataBase_test((Labels_BM_test~=0 & Labels_BM_test~=1),feature_select); %BiomarkerDataBase_test
        Y_test_2 = Labels_BM_test(Labels_BM_test~=0 & Labels_BM_test~=1);
        %Y_test_2(Y_test_2~=3) = 10;
        SVMModel_2 = fitcsvm(X_train_2,Y_train_2,'Standardize',true); % Verigud
        [y_pred_2,score_2] = predict(SVMModel_2,X_train_2);
        % 'linear', 'gaussian' (or 'rbf'), 'polynomial'

        % Clasifications
        % Train
        % 0 y demas 
        X_test_0 = BiomarkerDataBase_train(:,feature_select); %BiomarkerDataBase_test
        [y_pred_0,~] = predict(SVMModel_0,X_test_0);
        % Union de clasificacion
        y_pred_train = y_pred_0;
        if find(y_pred_train==-10)
            X_test_1 = BiomarkerDataBase_train(y_pred_train==-10,feature_select); %BiomarkerDataBase_test
            [y_pred_1,~] = predict(SVMModel_1,X_test_1);
            y_pred_train(y_pred_train==-10,:) = y_pred_1;
        end
        if find(y_pred_train==10)
            X_test_2 = BiomarkerDataBase_train(y_pred_train==10,feature_select); %BiomarkerDataBase_test
            [y_pred_2,~] = predict(SVMModel_2,X_test_2);
            y_pred_train(y_pred_train==10,:) = y_pred_2;
        end
        %y_pred_train

        % Test
        % 0 y demas 
        X_test_0 = BiomarkerDataBase_test(:,feature_select); %BiomarkerDataBase_test
        [y_pred_0,~] = predict(SVMModel_0,X_test_0);
        % Union de clasificacion
        y_pred_test = y_pred_0;
        if find(y_pred_test==-10)
            X_test_1 = BiomarkerDataBase_test(y_pred_test==-10,feature_select); %BiomarkerDataBase_test
            [y_pred_1,~] = predict(SVMModel_1,X_test_1);
            y_pred_test(y_pred_test==-10,:) = y_pred_1;
        end
        if find(y_pred_test==10)
            X_test_2 = BiomarkerDataBase_test(y_pred_test==10,feature_select); %BiomarkerDataBase_test
            [y_pred_2,~] = predict(SVMModel_2,X_test_2);
            y_pred_test(y_pred_test==10,:) = y_pred_2;
        end
        %y_pred_test

        % Treatments
        % 0 y demas 
        X_test_0 = BiomarkerDataBase_trat(:,feature_select); %BiomarkerDataBase_test
        [y_pred_0,~] = predict(SVMModel_0,X_test_0);
        % Union de clasificacion
        y_pred_trat = y_pred_0;
        if find(y_pred_trat==-10)
            X_test_1 = BiomarkerDataBase_trat(y_pred_trat==-10,feature_select); %BiomarkerDataBase_test
            [y_pred_1,~] = predict(SVMModel_1,X_test_1);
            y_pred_trat(y_pred_trat==-10,:) = y_pred_1;
        end
        if find(y_pred_trat==10)
            X_test_2 = BiomarkerDataBase_trat(y_pred_trat==10,feature_select); %BiomarkerDataBase_test
            [y_pred_2,~] = predict(SVMModel_2,X_test_2);
            y_pred_trat(y_pred_trat==10,:) = y_pred_2;
        end
        %y_pred_trat

        totalcv_test = [totalcv_test, y_pred_test];
    end

    totalfeatcv_test(:,:,i) = totalcv_test;

end


length_features = size(totalfeatcv_test(1,:,:),3);

% Control
cm_control = [sum(reshape(totalfeatcv_test(1,:,:), [9,length_features])' == 0, 2), ...
    sum(reshape(totalfeatcv_test(1,:,:), [9,length_features])' == 1, 2),... 
    sum(reshape(totalfeatcv_test(1,:,:), [9,length_features])' == 2, 2),... 
    sum(reshape(totalfeatcv_test(1,:,:), [9,length_features])' == 3, 2)]; % confusion con 3

% L20
cm_l20 = [sum(reshape(totalfeatcv_test(2,:,:), [9,length_features])' == 0, 2), ...
    sum(reshape(totalfeatcv_test(2,:,:), [9,length_features])' == 1, 2),... 
    sum(reshape(totalfeatcv_test(2,:,:), [9,length_features])' == 2, 2),... 
    sum(reshape(totalfeatcv_test(2,:,:), [9,length_features])' == 3, 2),]; % confusion con 3

% L30 
cm_l30 = [sum(reshape(totalfeatcv_test(3,:,:), [9,length_features])' == 0, 2), ...
    sum(reshape(totalfeatcv_test(3,:,:), [9,length_features])' == 1, 2),... 
    sum(reshape(totalfeatcv_test(3,:,:), [9,length_features])' == 2, 2),... 
    sum(reshape(totalfeatcv_test(3,:,:), [9,length_features])' == 3, 2),]; % confusion con 3

% L50 
cm_l50 = [sum(reshape(totalfeatcv_test(4,:,:), [9,length_features])' == 0, 2), ...
    sum(reshape(totalfeatcv_test(4,:,:), [9,length_features])' == 1, 2),... 
    sum(reshape(totalfeatcv_test(4,:,:), [9,length_features])' == 2, 2),... 
    sum(reshape(totalfeatcv_test(4,:,:), [9,length_features])' == 3, 2),]; 

%cm_control
%cm_l20
%cm_l30
%cm_l50
precision = [100.*cm_control(:,1)./9, 100.*cm_l20(:,2)./9, ...
    100.*cm_l30(:,3)./9, 100.*cm_l50(:,4)./9];
disp([precision, mean(precision,2)])

