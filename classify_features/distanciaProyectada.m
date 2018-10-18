function [dist, dist_list,dist_entre_cm,dist_pl, dist_cm] = distanciaProyectada(CM, point)

    % distancia desde el vector base que se resta
    vectoresBase = [0.*CM(1,:);CM];
    dist_pl = [];
    dist_cm = [];
    %dist = [norm()];
    dist_entre_cm = [];
    dist_list = [];
    
    for i = 1:size(CM,1)
        u = point - vectoresBase(i,:);
        v = vectoresBase(i+1,:) - vectoresBase(i,:);
        dist_entre_cm = [dist_entre_cm, norm(v)];
        
        %dist_pl = [dist_pl, norm(v*(dot(u,v)/(norm(v)^2))-u)];
        dist_pl = [dist_pl, norm(v*(dot(u,v)/(norm(v)^2)))];
        dist_cm = [dist_cm, norm(CM(i,:)-point)];
        dist_list = [dist_list, norm(v*(dot(u,v)/(norm(v)^2))-u), norm(CM(i,:)-point)];
    end

    dist_entre_cm = cumsum(dist_entre_cm);
    
    [~,I]= min(dist_list); % encontrar linea o cm mas cercano
    dist = dist_pl(1);
    
    if I ~= 1
        %disp('sumo')
        %disp(round(I/2))
        dist = dist_pl(round(I/2)) + dist_entre_cm(round(I/2)); % distancia del punto en la linea ente centros
    end

end
