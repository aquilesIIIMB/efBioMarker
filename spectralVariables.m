function [mat_variables,labels_Var] = spectralVariables(osciSpect, fractalSpect, freq)

%disp('Extracting spectral variables')

labels_Var = {'Pmix beta', 'Po delta', 'Po tetha', 'Po alpha', ...
    'Po beta', 'Po gammaL', 'Po gammaH', 'Psf widthband', ...
    'Dsf widthband', 'Rate delta-gammaL', 'Rate tetha-gammaL', ...
    'Rate alpha-gammaL', 'Rate beta-gammaL', 'Rate delta-gammaH', ...
    'Rate tetha-gammaH', 'Rate alpha-gammaH', 'Rate beta-gammaH', ...
    'Dominant frequency'};

mat_variables = [];

[~, D_time] = modelSF(fractalSpect, freq);

% Pmix beta
mat_variables = [mat_variables, sum(osciSpect(:,freq>12 & freq<30) + fractalSpect(:,freq>12 & freq<30),2)];

% Po delta
mat_variables = [mat_variables, sum(osciSpect(:,freq>1 & freq<4),2)]; 

% Po tetha
mat_variables = [mat_variables, sum(osciSpect(:,freq>4 & freq<8),2)];

% Po alpha
mat_variables = [mat_variables, sum(osciSpect(:,freq>8 & freq<12),2)];

% Po beta
mat_variables = [mat_variables, sum(osciSpect(:,freq>12 & freq<30),2)];

% Po gammaL
mat_variables = [mat_variables, sum(osciSpect(:,freq>30 & freq<60),2)];

% Po gammaH
mat_variables = [mat_variables, sum(osciSpect(:,freq>60 & freq<90),2)];

% Psf widthband
mat_variables = [mat_variables, sum(fractalSpect,2)];

% Dsf widthband
mat_variables = [mat_variables, D_time];

% Rate delta/gammaL
mat_variables = [mat_variables, sum(osciSpect(:,freq>1 & freq<4),2) ./ sum(osciSpect(:,freq>30 & freq<60),2)];

% Rate tetha/gammaL
mat_variables = [mat_variables, sum(osciSpect(:,freq>4 & freq<8),2) ./ sum(osciSpect(:,freq>30 & freq<60),2)];

% Rate alpha/gammaL
mat_variables = [mat_variables, sum(osciSpect(:,freq>8 & freq<12),2) ./ sum(osciSpect(:,freq>30 & freq<60),2)];

% Rate beta/gammaL
mat_variables = [mat_variables, sum(osciSpect(:,freq>12 & freq<30),2) ./ sum(osciSpect(:,freq>30 & freq<60),2)];

% Rate delta/gammaH
mat_variables = [mat_variables, sum(osciSpect(:,freq>1 & freq<4),2) ./ sum(osciSpect(:,freq>60 & freq<90),2)];

% Rate tetha/gammaH
mat_variables = [mat_variables, sum(osciSpect(:,freq>4 & freq<8),2) ./ sum(osciSpect(:,freq>60 & freq<90),2)];

% Rate alpha/gammaH
mat_variables = [mat_variables, sum(osciSpect(:,freq>8 & freq<12),2) ./ sum(osciSpect(:,freq>60 & freq<90),2)];

% Rate beta/gammaH
mat_variables = [mat_variables, sum(osciSpect(:,freq>12 & freq<30),2) ./ sum(osciSpect(:,freq>60 & freq<90),2)];


% Dominant frequency (just plot)
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
title('Po delta')
subplot(3,2,3)
plot(time, mat_variables(:,3))
title('Po tetha')
subplot(3,2,4)
plot(time, mat_variables(:,4))
title('Po alpha')
subplot(3,2,5)
plot(time, mat_variables(:,5))
title('Po beta')
subplot(3,2,6)
plot(time, mat_variables(:,6))
title('Po gammaL')

figure;
subplot(3,2,1)
plot(time, mat_variables(:,7))
title('Po gammaH')
subplot(3,2,2)
plot(time, mat_variables(:,8))
title('Psf widthband')
subplot(3,2,3)
plot(time, mat_variables(:,9))
title('Dsf widthband')
subplot(3,2,4)
plot(time, mat_variables(:,10))
title('Rate delta/gammaL')
subplot(3,2,5)
plot(time, mat_variables(:,11))
title('Rate tetha/gammaL')
subplot(3,2,6)
plot(time, mat_variables(:,12))
title('Rate alpha/gammaL')

figure;
subplot(3,2,1)
plot(time, mat_variables(:,13))
title('Rate beta/gammaL')
subplot(3,2,2)
plot(time, mat_variables(:,14))
title('Rate delta/gammaH')
subplot(3,2,3)
plot(time, mat_variables(:,15))
title('Rate tetha/gammaH')
subplot(3,2,4)
plot(time, mat_variables(:,16))
title('Rate alpha/gammaH')
subplot(3,2,5)
plot(time, mat_variables(:,17))
title('Rate beta/gammaH')
subplot(3,2,6)
plot(time, mat_variables(:,18))
title('Dominant frequency')
%}
