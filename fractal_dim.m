function dimList = fractal_dim(f_Spectrogram_mean, frac_temp, div_frec,sel_intervalos) 

    %div_frec = 20;
    div_frec_points = div_frec*2;
    freq = f_Spectrogram_mean;
    dimList = zeros((length(freq))/div_frec_points,size(frac_temp,1)); % 10,20 20,30, 30,40 40,50 Hz
    frac_spectrogram = frac_temp;
    intervalos = 1:(length(freq))/div_frec_points;
    if sel_intervalos
       intervalos = intervalos(sel_intervalos); 
    end
    % Con ajuste
    for j = 1:size(frac_spectrogram,1)
        %disp(j)
        parfor i = intervalos
            idx_ini = (i-1)*div_frec_points;
            idx_fin = (i-1)*div_frec_points+div_frec_points;
            if idx_ini == 0
                [~,idx_ini] = max(frac_spectrogram(j,1:div_frec_points-1));
            end
            x = freq(round(idx_ini):round(idx_fin));
            y = frac_spectrogram(j, round(idx_ini):round(idx_fin));
            fractalEq = 'a/(x^b)';
            fitFrac = fit(x,y',fractalEq,'StartPoint',[1,0]);
            %fprintf('Frec: [%.2f, %.2f]Hz, Dim: %.4f\n',x(1),x(end),fitFrac.b);
            dimList(i,j) = fitFrac.b;

            %loglog(x,y)
            %hold onj
            %loglog(x,fitFrac.a./(x.^fitFrac.b),'--r')
        end
    end
    
    % Con pendiente de freq inicial y final
    
end
