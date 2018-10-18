function [y_pred_test, confM_train, confM_test, predM_trat] = svmTreeBM(samples, areas, features, comb_subj, comb_subj_test, db_EP, labels_EP, db_trat, labels_trat)

% svmTreeBM({[1:12];[1:4];[1:9]}, [1,5], [1,2,4,5], BiomarkerDataBase_train, Labels_BM_train, BiomarkerDataBase_test, Labels_BM_test, BiomarkerDataBase_trat, Labels_BM_trat)
% BiomarkerDataBase_trat = [BiomarkerDataBase_pre;BiomarkerDataBase_on;BiomarkerDataBase_post]
% Labels_BM_trat = [Labels_BM_pre;Labels_BM_on;Labels_BM_post]
%sujetos = [1:12]; % 1:11
%areas = [1,5]; % 1,2 1,5 1:5
%caract = [1,2,4,5]; % 1:4 1,2,3,4 1:5

%{
fprintf('subjects train\n')
disp(samples{1,:})
fprintf('subjects test\n')
disp(samples{2,:})
fprintf('subjects trat\n')
disp(samples{3,:})
fprintf('areas\n')
disp(areas)
fprintf('features\n')
disp(features)
%}


db_train = db_EP(comb_subj,:);
db_test = db_EP(comb_subj_test,:);
labels_train = labels_EP(comb_subj);
labels_test = labels_EP(comb_subj_test);


BiomarkerDataBase_train_temp = [];
BiomarkerDataBase_test_temp = [];
BiomarkerDataBase_trat_temp = [];

%for i = areas
%    for j = features  
%        BiomarkerDataBase_train_temp = [BiomarkerDataBase_train_temp, db_train(samples{1,:},j+5*(i-1))];
%        BiomarkerDataBase_test_temp = [BiomarkerDataBase_test_temp, db_test(samples{2,:},j+5*(i-1))];
%        BiomarkerDataBase_trat_temp = [BiomarkerDataBase_trat_temp, db_trat(samples{3,:},j+5*(i-1))];
%    end
%end

for k = 1:length(areas)
    BiomarkerDataBase_train_temp = [BiomarkerDataBase_train_temp, db_train(samples{1,:},3*(areas(k)-1)+features{k})];
    BiomarkerDataBase_test_temp = [BiomarkerDataBase_test_temp, db_test(samples{2,:},3*(areas(k)-1)+features{k})];
    BiomarkerDataBase_trat_temp = [BiomarkerDataBase_trat_temp, db_trat(samples{3,:},3*(areas(k)-1)+features{k})];
end

BiomarkerDataBase_train = BiomarkerDataBase_train_temp;
BiomarkerDataBase_test = BiomarkerDataBase_test_temp;
BiomarkerDataBase_trat = BiomarkerDataBase_trat_temp;

Labels_BM_train = labels_train(samples{1,:});
Labels_BM_test = labels_test(samples{2,:});
Labels_BM_trat = labels_trat(samples{3,:});


% Desing of clasiffiers
X_train_0 = BiomarkerDataBase_train(:,:); %BiomarkerDataBase_train
Y_train_0 = Labels_BM_train;
Y_train_0(Y_train_0~=2 & Y_train_0~=3) = -10;
Y_train_0(Y_train_0==2 | Y_train_0==3) = 10;
X_test_0 = BiomarkerDataBase_test(:,:); %BiomarkerDataBase_test
Y_test_0 = Labels_BM_test;
Y_test_0(Y_test_0~=2 & Y_test_0~=3) = -10;
Y_test_0(Y_test_0==2 | Y_test_0==3) = 10;
SVMModel_0 = fitcsvm(X_train_0,Y_train_0,'Standardize',true); % Verigud
[y_pred_0,score_0] = predict(SVMModel_0,X_train_0);
% 

% 1 y demas 
X_train_1 = BiomarkerDataBase_train((Labels_BM_train~=2 & Labels_BM_train~=3),:); %BiomarkerDataBase_train
Y_train_1 = Labels_BM_train((Labels_BM_train~=2 & Labels_BM_train~=3));
Y_train_1(Y_train_1~=1) = 0;
X_test_1 = BiomarkerDataBase_test((Labels_BM_test~=2 & Labels_BM_test~=3),:); %BiomarkerDataBase_test
Y_test_1 = Labels_BM_test((Labels_BM_test~=2 & Labels_BM_test~=3));
Y_test_1(Y_test_1~=1) = 0;
SVMModel_1 = fitcsvm(X_train_1,Y_train_1,'Standardize',true); % Verigud
[y_pred_1,score_1] = predict(SVMModel_1,X_train_1);
% 

% 2 y demas  
X_train_2 = BiomarkerDataBase_train((Labels_BM_train~=0 & Labels_BM_train~=1),:); %BiomarkerDataBase_train
Y_train_2 = Labels_BM_train(Labels_BM_train~=0 & Labels_BM_train~=1);
%Y_train_2(Y_train_2~=3) = 10;
X_test_2 = BiomarkerDataBase_test((Labels_BM_test~=0 & Labels_BM_test~=1),:); %BiomarkerDataBase_test
Y_test_2 = Labels_BM_test(Labels_BM_test~=0 & Labels_BM_test~=1);
%Y_test_2(Y_test_2~=3) = 10;
SVMModel_2 = fitcsvm(X_train_2,Y_train_2,'Standardize',true); % Verigud
[y_pred_2,score_2] = predict(SVMModel_2,X_train_2);
% 'linear', 'gaussian' (or 'rbf'), 'polynomial'

% Clasifications
% Train
% 0 y demas 
X_test_0 = BiomarkerDataBase_train; %BiomarkerDataBase_test
[y_pred_0,~] = predict(SVMModel_0,X_test_0);
% Union de clasificacion
y_pred_train = y_pred_0;
if find(y_pred_train==-10)
    X_test_1 = BiomarkerDataBase_train(y_pred_train==-10,:); %BiomarkerDataBase_test
    [y_pred_1,~] = predict(SVMModel_1,X_test_1);
    y_pred_train(y_pred_train==-10,:) = y_pred_1;
end
if find(y_pred_train==10)
    X_test_2 = BiomarkerDataBase_train(y_pred_train==10,:); %BiomarkerDataBase_test
    [y_pred_2,~] = predict(SVMModel_2,X_test_2);
    y_pred_train(y_pred_train==10,:) = y_pred_2;
end
%y_pred_train

% Test
% 0 y demas 
X_test_0 = BiomarkerDataBase_test; %BiomarkerDataBase_test
[y_pred_0,~] = predict(SVMModel_0,X_test_0);
% Union de clasificacion
y_pred_test = y_pred_0;
if find(y_pred_test==-10)
    X_test_1 = BiomarkerDataBase_test(y_pred_test==-10,:); %BiomarkerDataBase_test
    [y_pred_1,~] = predict(SVMModel_1,X_test_1);
    y_pred_test(y_pred_test==-10,:) = y_pred_1;
end
if find(y_pred_test==10)
    X_test_2 = BiomarkerDataBase_test(y_pred_test==10,:); %BiomarkerDataBase_test
    [y_pred_2,~] = predict(SVMModel_2,X_test_2);
    y_pred_test(y_pred_test==10,:) = y_pred_2;
end
%y_pred_test

% Treatments
% 0 y demas 
X_test_0 = BiomarkerDataBase_trat; %BiomarkerDataBase_test
[y_pred_0,~] = predict(SVMModel_0,X_test_0);
% Union de clasificacion
y_pred_trat = y_pred_0;
if find(y_pred_trat==-10)
    X_test_1 = BiomarkerDataBase_trat(y_pred_trat==-10,:); %BiomarkerDataBase_test
    [y_pred_1,~] = predict(SVMModel_1,X_test_1);
    y_pred_trat(y_pred_trat==-10,:) = y_pred_1;
end
if find(y_pred_trat==10)
    X_test_2 = BiomarkerDataBase_trat(y_pred_trat==10,:); %BiomarkerDataBase_test
    [y_pred_2,~] = predict(SVMModel_2,X_test_2);
    y_pred_trat(y_pred_trat==10,:) = y_pred_2;
end
%y_pred_trat

%{
disp('Train set')
disp([sum(Labels_BM_train( y_pred_train == 0 ) == 0), ...
    sum(Labels_BM_train( y_pred_train == 1 ) == 0),...
    sum(Labels_BM_train( y_pred_train == 2 ) == 0),...
    sum(Labels_BM_train( y_pred_train == 3 ) == 0)])
disp([sum(Labels_BM_train( y_pred_train == 0 ) == 1), ...
    sum(Labels_BM_train( y_pred_train == 1 ) == 1),...
    sum(Labels_BM_train( y_pred_train == 2 ) == 1),...
    sum(Labels_BM_train( y_pred_train == 3 ) == 1)])
disp([sum(Labels_BM_train( y_pred_train == 0 ) == 2), ...
    sum(Labels_BM_train( y_pred_train == 1 ) == 2),...
    sum(Labels_BM_train( y_pred_train == 2 ) == 2),...
    sum(Labels_BM_train( y_pred_train == 3 ) == 2)])
disp([sum(Labels_BM_train( y_pred_train == 0 ) == 3), ...
    sum(Labels_BM_train( y_pred_train == 1 ) == 3),...
    sum(Labels_BM_train( y_pred_train == 2 ) == 3),...
    sum(Labels_BM_train( y_pred_train == 3 ) == 3)])

disp('Test set')
disp([sum(Labels_BM_test( y_pred_test == 0 ) == 0), ...
    sum(Labels_BM_test( y_pred_test == 1 ) == 0),...
    sum(Labels_BM_test( y_pred_test == 2 ) == 0),...
    sum(Labels_BM_test( y_pred_test == 3 ) == 0)])
disp([sum(Labels_BM_test( y_pred_test == 0 ) == 1), ...
    sum(Labels_BM_test( y_pred_test == 1 ) == 1),...
    sum(Labels_BM_test( y_pred_test == 2 ) == 1),...
    sum(Labels_BM_test( y_pred_test == 3 ) == 1)])
disp([sum(Labels_BM_test( y_pred_test == 0 ) == 2), ...
    sum(Labels_BM_test( y_pred_test == 1 ) == 2),...
    sum(Labels_BM_test( y_pred_test == 2 ) == 2),...
    sum(Labels_BM_test( y_pred_test == 3 ) == 2)])
disp([sum(Labels_BM_test( y_pred_test == 0 ) == 3), ...
    sum(Labels_BM_test( y_pred_test == 1 ) == 3),...
    sum(Labels_BM_test( y_pred_test == 2 ) == 3),...
    sum(Labels_BM_test( y_pred_test == 3 ) == 3)])

disp('Treated set')
disp(y_pred_trat)
%}

confM_train = [[sum(Labels_BM_train( y_pred_train == 0 ) == 0), ...
    sum(Labels_BM_train( y_pred_train == 1 ) == 0),...
    sum(Labels_BM_train( y_pred_train == 2 ) == 0),...
    sum(Labels_BM_train( y_pred_train == 3 ) == 0)];...
    [sum(Labels_BM_train( y_pred_train == 0 ) == 1), ...
    sum(Labels_BM_train( y_pred_train == 1 ) == 1),...
    sum(Labels_BM_train( y_pred_train == 2 ) == 1),...
    sum(Labels_BM_train( y_pred_train == 3 ) == 1)];...
    [sum(Labels_BM_train( y_pred_train == 0 ) == 2), ...
    sum(Labels_BM_train( y_pred_train == 1 ) == 2),...
    sum(Labels_BM_train( y_pred_train == 2 ) == 2),...
    sum(Labels_BM_train( y_pred_train == 3 ) == 2)];...
    [sum(Labels_BM_train( y_pred_train == 0 ) == 3), ...
    sum(Labels_BM_train( y_pred_train == 1 ) == 3),...
    sum(Labels_BM_train( y_pred_train == 2 ) == 3),...
    sum(Labels_BM_train( y_pred_train == 3 ) == 3)]];

confM_test = [[sum(Labels_BM_test( y_pred_test == 0 ) == 0), ...
    sum(Labels_BM_test( y_pred_test == 1 ) == 0),...
    sum(Labels_BM_test( y_pred_test == 2 ) == 0),...
    sum(Labels_BM_test( y_pred_test == 3 ) == 0)];...
    [sum(Labels_BM_test( y_pred_test == 0 ) == 1), ...
    sum(Labels_BM_test( y_pred_test == 1 ) == 1),...
    sum(Labels_BM_test( y_pred_test == 2 ) == 1),...
    sum(Labels_BM_test( y_pred_test == 3 ) == 1)];...
    [sum(Labels_BM_test( y_pred_test == 0 ) == 2), ...
    sum(Labels_BM_test( y_pred_test == 1 ) == 2),...
    sum(Labels_BM_test( y_pred_test == 2 ) == 2),...
    sum(Labels_BM_test( y_pred_test == 3 ) == 2)];...
    [sum(Labels_BM_test( y_pred_test == 0 ) == 3), ...
    sum(Labels_BM_test( y_pred_test == 1 ) == 3),...
    sum(Labels_BM_test( y_pred_test == 2 ) == 3),...
    sum(Labels_BM_test( y_pred_test == 3 ) == 3)]];

predM_trat = [reshape(y_pred_trat,[],3)'];

end