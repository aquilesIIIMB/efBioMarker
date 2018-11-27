% list_perm = [15,22,14,21,11,23,35,13]; % control 25-30min
list_perm = [14,21,15,22,11,23,24,12]; % control 0-5min
accuracy_Gen_max = 0;

for j=1:length(list_perm)
    combin_fetures = combnk(list_perm,j);
    [ii,jj]=unique(sort(combin_fetures,2),'rows','stable');
    combin_fetures=combin_fetures(jj,:);
    d = 10;
    features_list = mod(combin_fetures, d);
    areas_list = (combin_fetures - features_list)/d;

    for i=1:size(combin_fetures,1)
        disp('Areas')
        disp(areas_list(i,:))
        disp('Caract')
        disp(features_list(i,:))
        

        areas = areas_list(i,:);
        features = num2cell(features_list(i,:));
        classifiers_kfoldBM;
        if accuracy_Gen_max < accuracy_Gen
            accuracy_Gen_max = accuracy_Gen;
            comb_max = {areas_list(i,:),features_list(i,:)};
            disp('betterrrrrrrrrrrrrrrr')
            disp(' ')
        end
    end
end
