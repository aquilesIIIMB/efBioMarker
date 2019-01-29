ml = 1.3;
ap = -3.3;
dv = 7.5;

S = ratBrainAtlas(ml,ap,dv);
figure;imshow(S.coronal.image);

% M1
ml = 3;
ap = 2;
dv = 1;

S = ratBrainAtlas(ml,ap,dv);
figure;imshow(S.coronal.image)

% VPL
ml = 3;
ap = -2.5;
dv = 6.2;

S = ratBrainAtlas(ml,ap,dv);

% STR
figure;imshow(S.coronal.image)
ml = 3;
ap = 1.6;
dv = -4.2;

S = ratBrainAtlas(ml,ap,dv);
figure;imshow(S.coronal.image)





