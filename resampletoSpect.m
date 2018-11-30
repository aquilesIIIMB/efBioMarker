function y = resampletoSpect(a, len_y)
% 0 artefact, 1 sennal

[row, col] = size(a);
y = zeros(len_y, col);
delta = round(row/len_y);

   
for j = 1:len_y

    y(j,:) = min(a((j-1)*delta+1 : (j)*delta+1,:));

    %disp((j-1)*delta+1)
    %disp((j)*delta+1)



end




end