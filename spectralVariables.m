function [mat_variables,labels_Var] = spectralVariables(osciSpect, fractalSpect, freq)

%disp('Extracting spectral variables')

labels_Var = {'Pmix beta', 'Pmix gammaL', 'Pmix gammaH', 'Po delta', 'Po tetha', 'Po alpha', ...
    'Po beta', 'Po gammaL', 'Po gammaH', 'Psf widthband', ...
    'Dsf widthband', 'Dominant frequency'};

mat_variables = [];

[~, D_time] = modelSF(fractalSpect, freq);

% Pmix beta
mat_variables = [mat_variables, sum(osciSpect(:,freq>12 & freq<30) + fractalSpect(:,freq>12 & freq<30),2) * (freq(2)-freq(1))];

% Pmix gammaL
mat_variables = [mat_variables, sum(osciSpect(:,freq>30 & freq<60) + fractalSpect(:,freq>30 & freq<60),2) * (freq(2)-freq(1))];

% Pmix gammaH
mat_variables = [mat_variables, sum(osciSpect(:,freq>60 & freq<90) + fractalSpect(:,freq>60 & freq<90),2) * (freq(2)-freq(1))];

% Po delta
mat_variables = [mat_variables, sum(osciSpect(:,freq>1 & freq<4),2) * (freq(2)-freq(1))]; 

% Po tetha
mat_variables = [mat_variables, sum(osciSpect(:,freq>4 & freq<8),2) * (freq(2)-freq(1))];

% Po alpha
mat_variables = [mat_variables, sum(osciSpect(:,freq>8 & freq<12),2) * (freq(2)-freq(1))];

% Po beta
mat_variables = [mat_variables, sum(osciSpect(:,freq>12 & freq<30),2) * (freq(2)-freq(1))];

% Po gammaL
mat_variables = [mat_variables, sum(osciSpect(:,freq>30 & freq<60),2) * (freq(2)-freq(1))];

% Po gammaH
mat_variables = [mat_variables, sum(osciSpect(:,freq>60 & freq<90),2) * (freq(2)-freq(1))];

% Psf widthband
mat_variables = [mat_variables, sum(fractalSpect,2) * (freq(2)-freq(1))];

% Dsf widthband
mat_variables = [mat_variables, D_time];


% Dominant frequency 
[~,I] = max(osciSpect,[],2);
mat_variables = [mat_variables, freq(I)'];

end


%{
figure;
subplot(3,2,1)
plot(time, mat_variables(:,1))
title('Pmix beta')
subplot(3,2,2)
plot(time, mat_variables(:,2))
title('Pmix gammaL')
subplot(3,2,3)
plot(time, mat_variables(:,3))
title('Pmix gammaH')
subplot(3,2,4)
plot(time, mat_variables(:,4))
title('Po delta')
subplot(3,2,5)
plot(time, mat_variables(:,5))
title('Po tetha')
subplot(3,2,6)
plot(time, mat_variables(:,6))
title('Po alpha')

figure;
subplot(3,2,1)
plot(time, mat_variables(:,7))
title('Po beta')
subplot(3,2,2)
plot(time, mat_variables(:,8))
title('Po gammaL')
subplot(3,2,3)
plot(time, mat_variables(:,9))
title('Po gammaH')
subplot(3,2,4)
plot(time, mat_variables(:,10))
title('Psf widthband')
subplot(3,2,5)
plot(time, mat_variables(:,11))
title('Dsf widthband')
subplot(3,2,6)
plot(time, mat_variables(:,12))
title('Dominant frequency')
%}
