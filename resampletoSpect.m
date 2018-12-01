function y = resampletoSpect(a, len_y)
% 0 artefact, 1 sennal

[row, col] = size(a);
y = zeros(len_y, col);
delta = row/len_y;

   
for j = 1:len_y

    y(j,:) = min(a(round((j-1)*delta)+1 : round(j*delta),:));

    %disp(round((j-1)*delta)+1)
    %disp(round(j*delta))



end




end