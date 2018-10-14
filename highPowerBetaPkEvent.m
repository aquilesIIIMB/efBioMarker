function [idx_pk,idx_Npk,idx_ptos,mean_range,n_events] = highPowerBetaPkEvent(osci, umbral_osci)


    idx_ptos = findchangepts(diff(diff(osci)),'MaxNumChanges',30,'Statistic','std');
    idx_pk = [];
    idx_Npk = [1:length(osci)];
    mean_range = zeros(1,length(idx_ptos)+1);
    idx_eval = cell(1,length(idx_ptos)+1);
    

    idx_eval{1} = 1:idx_ptos(1);
    mean_range(1) = mean(osci(idx_eval{1}));
    %if mean_range(1) >= umbral_osci
    %    idx_pk = [idx_pk, idx_eval{1}];
    %end

    for k = 1:length(idx_ptos)-1
        idx_eval{k+1} = idx_ptos(k):idx_ptos(k+1);
        mean_range(k+1) = mean(osci(idx_eval{k+1}));

        %if mean_range(k+1) >= umbral_osci
        %    idx_pk = [idx_pk, idx_eval{k+1}];
        %end

    end

    idx_eval{length(idx_ptos)+1} = idx_ptos(length(idx_ptos)):length(osci);
    mean_range(length(idx_ptos)+1) = mean(osci(idx_eval{length(idx_ptos)+1}));
    %if mean_range(length(idx_ptos)+1) >= umbral_osci
    %    idx_pk = [idx_pk, idx_eval{length(idx_ptos)+1}];
    %end
        
    sort_mean_range = sort(mean_range);
    idx_mr = find(mean_range>prctile(osci,30)+umbral_osci);
    idx_pk = unique([idx_eval{idx_mr}]);
    idx_Npk = idx_Npk(~ismember(idx_Npk, idx_pk));
    
    n_events = length(idx_mr);
    %idx_pk = find(osci>(mean(sort_mean_range(1:2)))+umbral_osci);
    
end







