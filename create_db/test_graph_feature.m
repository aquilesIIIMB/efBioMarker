


classes = [1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
ranking = spider_wrapper(features,classes',129,'fisher')

classes_c = [1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
ranking_c = spider_wrapper(features,classes',129,'fisher');

classes_l20 = [-1,-1,1,1,1,-1,-1,-1,-1,-1,-1];
ranking_l20 = spider_wrapper(features,classes_l20',129,'fisher');

classes_l30 = [-1,-1,-1,-1,-1,1,1,1,-1,-1,-1];
ranking_l30 = spider_wrapper(features,classes_l30',129,'fisher');

classes_l50 = [-1,-1,-1,-1,-1,-1,-1,-1,1,1,1];
ranking_l50 = spider_wrapper(features,classes_l50',129,'fisher');



for i=1:54
        
    ranking_gen(i,:) = [(3/6)*find(ranking_c==i) + (1/6)*find(ranking_l20==i) + (1/6)*find(ranking_l30==i) + (1/6)*find(ranking_l50==i), i];

end


[~,idx] = sort(ranking_gen(:,1)); % sort just the first column
sortedmat = ranking_gen(idx,:);
sortedmat(1:18,:);

figure
for i=1:18
    
    k = ranking_c(i);%sortedmat(i,2);
    disp(k)
    
    plot([0.9,1,1.1], features(1:3,[k]),'*')
    hold on
    plot([1.9,2,2.1], features(4:6,[k]),'*')
    plot([2.9,3,3.1], features(7:9,[k]),'*')
    plot([3.9,4,4.1], features(10:12,[k]),'*')
    hold off
    
    waitforbuttonpress;
    
end 
    
    
figure    
k = 15;

plot([0.9,1,1.1], features(1:3,[k]),'*')
hold on
plot([1.9,2,2.1], features(4:6,[k]),'*')
plot([2.9,3,3.1], features(7:9,[k]),'*')
plot([3.9,4,4.1], features(10:12,[k]),'*')
hold off

figure
k_1 = 15;
k_2 = 16;

plot([0.9,1,1.1], features(1:3,[k_1])./features(1:3,[k_2]),'*')
hold on
plot([1.9,2,2.1], features(4:6,[k_1])./features(4:6,[k_2]),'*')
plot([2.9,3,3.1], features(7:9,[k_1])./features(7:9,[k_2]),'*')
plot([3.9,4,4.1], features(10:12,[k_1])./features(10:12,[k_2]),'*')




f1 = features(:,15)./max(features(:,15));
f2 = features(:,49)./max(features(:,49));
f3 = features(:,50)./max(features(:,50));
f4 = (features(:,15)./features(:,16))./max(features(:,15)./features(:,16));

plot(sqrt(sum([f1,f2,f3].^2,2)),'*')
plot(f4,'*')

% Ranking areas
rank_areas = mean(reshape(ranking_gen(:,1),18,3));

% Ranking caract
rank_feat(:,1) = mean(reshape(ranking_gen(:,1),18,3),2);
rank_feat(:,2) = 1:18;
[~,idx] = sort(rank_feat(:,1)); % sort just the first column
sortedmat = rank_feat(idx,:)

% Best metrica
figure
f1 = features(:,15)./max(features(:,15));
f2 = features(:,49)./max(features(:,49));
f3 = features(:,50)./max(features(:,50));
f4 = (features(:,15)./features(:,16))./max(features(:,15)./features(:,16));
disp(sqrt(sum([f4,f2,f3].^2,2)))
plot(sqrt(sum([f4,f2,f3].^2,2)),'*')
f1 = features_trat(:,15)./max(features_trat(:,15));
f2 = features_trat(:,49)./max(features_trat(:,49));
f3 = features_trat(:,50)./max(features_trat(:,50));
f4 = (features_trat(:,15)./features_trat(:,16))./max(features_trat(:,15)./features_trat(:,16));
disp(sqrt(sum([f4,f2,f3].^2,2)))
hold on
plot(sqrt(sum([f4,f2,f3].^2,2)),'*')

f1 = features(:,15);
f2 = features(:,49);
f3 = features(:,50);
f4 = (features(:,15)./features(:,16));
disp([f4,f2,f3])
f1 = features_trat(:,15);
f2 = features_trat(:,49);
f3 = features_trat(:,50);
f4 = (features_trat(:,15)./features_trat(:,16));
disp([f4,f2,f3])



figure
f1 = features(:,15)./max(features(:,15));
f2 = features(:,49)./max(features(:,49));
f3 = features(:,50)./max(features(:,50));
f4 = (features(:,15)./features(:,16))./max(features(:,15)./features(:,16));
plot(f4,'*')
f1 = features_trat(:,15)./max(features_trat(:,15));
f2 = features_trat(:,49)./max(features_trat(:,49));
f3 = features_trat(:,50)./max(features_trat(:,50));
f4 = (features_trat(:,15)./features_trat(:,16))./max(features_trat(:,15)./features_trat(:,16));
hold on
plot(f4,'*')
