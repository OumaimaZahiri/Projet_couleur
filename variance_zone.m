function v = variance_zone(img)
%VARIANCE_ZONE Summary of this function goes here
%   Detailed explanation goes here


% Passage en teinte du domaine HSV
img = rgb2hsv(img);
img = img(:,:,2);
% trouver une zone coloriée
[m, n] = size(img);
xCenter = floor(m/2);
yCenter = floor(n / 2);
ZOI = double(img(floor(xCenter - 0.2*xCenter) : floor(xCenter + 0.2 * xCenter), floor(yCenter - 0.2*yCenter) : floor(yCenter + 0.2 * yCenter)));

% calculer la variance dans cette zone

v = var(ZOI(:));
end

