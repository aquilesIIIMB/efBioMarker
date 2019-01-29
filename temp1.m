

[b,bint,r,rint,stats] = regress([0,0,0,20,20,20,30,30,30,50,50,50]',[ones(12,1),features]);
find(b ~= 0)
stats
[1,BiomarkerDataBase_trat(1,:)]*b

mdl = fitglm(features,[0,0,0,20,20,20,30,30,30,50,50,50]);


sort([mappedX,[1:129]'],2,,'descend')

[mappedX, mapping] = pca(features', 1);

mappedX = rica(features, 1);
mappedX = mappedX.TransformWeights;

mat = [mappedX,[1:129]'];
[~,idx] = sort(mat(:,1),'descend'); % sort just the first column
sortedmat = mat(idx,:);   % sort the whole matrix using the sort indices



for i = 1:30
    X = BiomarkerDataBase_train(:,sortedmat([1:i],2));
    Y = [0,0,1,1,2,2,3,3];
    Mdl = fitcknn(X,Y,'NumNeighbors',4);
    flwrClass = predict(Mdl,BiomarkerDataBase_test(:,sortedmat([1:i],2)))
end

