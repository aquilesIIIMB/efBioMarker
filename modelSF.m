function [A_time, D_time] = modelSF(fractalSpect, freq)

[len_time, len_freq] = size(fractalSpect);

A_time = [];
D_time = [];

for i = 1:len_time
    
    F = @(b,x)b(1)*(x).^-b(2);
    x0 = [1 1];
    
    opts = optimset('Display','off');
    [x,~,~,~,~] = lsqcurvefit(F,x0,freq,fractalSpect(i,:),[ ],[ ],opts);
    
    A_time = [A_time; x(1)];
    D_time = [D_time; x(2)];
    
end


end

%plot(freq, Spectrogram_fractals(1,:))
%hold on
%plot(freq, x(1)*(freq).^-x(2))
