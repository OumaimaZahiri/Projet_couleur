function nb = nb_couleurs(I,tolerance)
%NB_COULEURS Summary of this function goes here
%   Detailed explanation goes here

%% compter les couleurs
k = 2;
n = 2^k;
d = 256 / n;
IG = 255 - rgb2gray(I);
% 1/ Uniformisation du fond
ES = strel('disk', 80);

IF = imtophat(IG, ES);

% figure, imshow(IF, []);

level = multithresh(IF);
ZOI = imquantize(IF,level);
ZOI = imfill(ZOI, 'holes') - 1;
% 2/ Quantification des couleurs de l'image

I = I .* uint8(floor(ZOI));

IQ_int = uint8(floor(double(I)/d)*d);
[~, map] = rgb2ind(IQ_int, tolerance);



figure(4),
subplot(1,2,1), imshow(IQ_int, []); colormap('default'); colorbar
subplot(1,2,2), imshow(I, []); colormap(map); colorbar

% 3/ Comptage des couleurs
[nb, ~] = size(map);
end

