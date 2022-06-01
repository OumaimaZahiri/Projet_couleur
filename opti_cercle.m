%% optimisation nb cercle
clear all; close all; clc

I = imread("Database_compressed\7 ans\bonhomme\personnage_7_13.jpg");

I = imgaussfilt(I, 0.7);

RGB = I;
se = strel('disk',2);
I  = im2gray(RGB);
I=(255-I)/255;

% BW1 =imdilate(I,se);
% 
% BW2=imfill(BW1,'holes');
% BW2 =imerode(BW2,se);
BW3 = double(edge(I,'canny',0.5));

figure(),
imshow(BW3, []); colorbar

[m, n] = size(BW3);
mini = (m + n) / 100;
maxi = (m + n) / log(m*n);
radii = mini:7:maxi;
h = circle_hough(BW3, radii, 'same');

seuil = 0.9*max(h(:));
peaks = circle_houghpeaks(h, radii, 'npeaks', 2, 'threshold', seuil);

figure,
imshow(RGB);
hold on;
for peak = peaks
    
    [x, y] = circlepoints(peak(3));
    plot(x+peak(1), y+peak(2), 'g-');
end
hold off