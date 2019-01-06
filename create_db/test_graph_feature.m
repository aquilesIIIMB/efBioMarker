

for i=1:54
        
    ranking_gen(i,:) = [(3/6)*find(ranking_c==i) + (1/6)*find(ranking_l20==i) + (1/6)*find(ranking_l30==i) + (1/6)*find(ranking_l50==i), i];

end


[~,idx] = sort(ranking_gen(:,1)); % sort just the first column
sortedmat = ranking_gen(idx,:);
sortedmat(1:18,:);

figure
for i=1:10
    
    k = sortedmat(i,2);
    disp(k)
    
    plot([0.9,1.1], feature(1:2,[k]),'*')
    hold on
    plot([1.9,2,2.1], feature(3:5,[k]),'*')
    plot([2.9,3,3.1], feature(6:8,[k]),'*')
    plot([3.9,4,4.1], feature(9:11,[k]),'*')
    hold off
    
    waitforbuttonpress;
    
end 
    
    
    
k = 16;

%figure
plot([0.9,1.1], feature(1:2,[k]),'*')
hold on
plot([1.9,2,2.1], feature(3:5,[k]),'*')
plot([2.9,3,3.1], feature(6:8,[k]),'*')
plot([3.9,4,4.1], feature(9:11,[k]),'*')
hold off


k_1 = 15;
k_2 = 16;

%figure
plot([0.9,1.1], feature(1:2,[k_1])./feature(1:2,[k_2]),'*')
hold on
plot([1.9,2,2.1], feature(3:5,[k_1])./feature(3:5,[k_2]),'*')
plot([2.9,3,3.1], feature(6:8,[k_1])./feature(6:8,[k_2]),'*')
plot([3.9,4,4.1], feature(9:11,[k_1])./feature(9:11,[k_2]),'*')




f1 = feature(:,46)./max(feature(:,46));
f2 = feature(:,15)./max(feature(:,15));
f3 = max(feature(:,36))./feature(:,36);
f4 = max(feature(:,9))./feature(:,9);
f5 = (feature(:,15)./feature(:,16))./max(feature(:,15)./feature(:,16));

plot(sqrt(sum([f1,f2,f3,f4].^2,2)),'*')
plot(f5,'*')

% Ranking areas
rank_areas = median(reshape(ranking_gen(:,1),18,3));

% Ranking caract
rank_feat(:,1) = median(reshape(ranking_gen(:,1),18,3),2);
rank_feat(:,2) = 1:18;
[~,idx] = sort(rank_feat(:,1)); % sort just the first column
sortedmat = rank_feat(idx,:)

