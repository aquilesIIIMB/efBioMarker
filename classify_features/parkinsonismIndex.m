function [idxPk_test, idxPk_trat, idxPk_train, limAreasClasses, cm_train] = parkinsonismIndex(samples, areas, features, comb_subj, comb_subj_test, db_EP, labels_EP, db_trat, labels_trat, method)
% indice de parkinsonismo


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

db_train = BiomarkerDataBase_train_temp;
db_test = BiomarkerDataBase_test_temp;
db_trat = BiomarkerDataBase_trat_temp;

labels_train = labels_train(samples{1,:});
labels_test = labels_test(samples{2,:});
labels_trat = labels_trat(samples{3,:});


classes = unique(labels_train);

cm_train = [];
for i = 1:length(classes)
    if sum((classes(i) == labels_train)) == 1
        cm_train = [cm_train; db_train((classes(i) == labels_train),:)];
    else
        cm_train = [cm_train; mean(db_train((classes(i) == labels_train),:))];
    end
end


if strcmp(method,'origine')% norm manual 
    idxPk_train = [];
    DB_test = db_train;
    for j = 1:size(DB_test,1)
        if max(cm_train) == 0
            dist = 0;
        else
            dist = norm(DB_test(j,:)./max(cm_train));
        end
        idxPk_train = [idxPk_train; dist];
    end

    idxPk_test = [];
    DB_test = db_test;
    for j = 1:size(DB_test,1)
        if max(cm_train) == 0
            dist = 0;
        else
            dist = norm(DB_test(j,:)./max(cm_train));
        end
        idxPk_test = [idxPk_test; dist];
    end
    
    idxPk_trat = [];
    DB_test = db_trat;
    for j = 1:size(DB_test,1)
        if max(cm_train) == 0
            dist = 0;
        else
            dist = norm(DB_test(j,:)./max(cm_train));
        end
        idxPk_trat = [idxPk_trat; dist];
    end

    %i=0;
    %for j=[1,5,9,13, 2,6,10,14, 3,7,11,15, 4,8,12,16, 17,18,19, 20,21,22, 23,24,25]
    %    i = i + 1;
    %    plot(i, data_cont(j),'*','MarkerSize',15,'LineWidth',6);
    %    hold on
    %end
elseif strcmp(method,'projected')
    % con distancia projectada 
    idxPk_train = [];
    DB_test = db_train;
    for j = 1:size(DB_test,1)
        if sum(sum(DB_test(j,:)./max(cm_train),2)==0) == 1
            dist = 0;
        else
            dist = distanciaProyectada(cm_train./max(cm_train), DB_test(j,:)./max(cm_train));
        end
        idxPk_train = [idxPk_train; dist];
    end
    
    idxPk_test = [];
    DB_test = db_test;
    for j = 1:size(DB_test,1)
        if sum(sum(DB_test(j,:)./max(cm_train),2)==0) == 1
            dist = 0;
        else
            dist = distanciaProyectada(cm_train./max(cm_train), DB_test(j,:)./max(cm_train));
        end
        idxPk_test = [idxPk_test; dist];
    end
    
    idxPk_trat = [];
    DB_test = db_trat;
    for j = 1:size(DB_test,1)
        if sum(sum(DB_test(j,:)./max(cm_train),2)==0) == 1
            dist = 0;
        else
            dist = distanciaProyectada(cm_train./max(cm_train), DB_test(j,:)./max(cm_train));
        end
        idxPk_trat = [idxPk_trat; dist];
    end
end


idxPk_trat = [reshape(idxPk_trat,[],3)'];

limAreasClasses = [];
for i = 1:length(classes)
    limAreasClasses = [limAreasClasses; min(idxPk_train((classes(i) == labels_train),:)), max(idxPk_train((classes(i) == labels_train),:))];
end



%{
figure;
%for j=[1,5,9,13,17,21,25, 2,6,10,14,18,22,26, 3,7,11,15,19,23,27, 4,8,12,16,20,24,28, 29,30,31, 32,33,34, 35,36,37]
% PUC
clases = [0,0,0,0, 1,1,1,1, 2,2,2,2, 3,3,3,2, 2,2,2, 0,1,1, 0,2,2];
data = data_cont([1,5,9,13, 2,6,10,14, 3,7,11,15, 4,8,12,16, 17,18,19, 20,21,22, 23,24,25]);
%full
%clases = [0,0,0,0,0,0, 1,1,1,1,1,1,1,1, 2,2,2,2,2,2,2, 3,3,3,2,3,3,3, 2,2,2, 0,1,1, 0,2,2];
%data = data_cont([1,5,9,18,19,25, 2,6,10,14,17,21,22,26, 3,7,11,15,23,27,28, 4,8,12,13,16,20,24, 29,30,31, 32,33,34, 35,36,37]);
for j=1:length(data)
    plot(clases(j), data(j),'*','MarkerSize',15,'LineWidth',6);
    hold on
end

figure;
pre = boxplot(data(1:end-9), clases(1:end-9));
h_pre=findobj(pre,'tag','Box');
set(h_pre,'LineWidth',4)
h_pre=findobj(pre,'tag','Upper Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(pre,'tag','Lower Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(pre,'tag','Median'); 
set(h_pre,'LineWidth',4);
h_pre=findobj(pre,'tag','Outliers');
set(h_pre,'LineWidth',10);
set(h_pre,'MarkerSize',3);
hold on
plot(clases(end-8:end-6)+0.9, data(end-8:end-6),'p','Color',verde,'MarkerSize',12,'LineWidth',4);
hold on
plot(clases(end-5:end-3)+1, data(end-5:end-3),'p','Color',amarillo,'MarkerSize',12,'LineWidth',4);
hold on
plot(clases(end-2:end)+1.1, data(end-2:end),'p','Color',gris,'MarkerSize',12,'LineWidth',4);


%}

end















