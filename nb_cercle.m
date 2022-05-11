function nb = nb_cercle(I)
%NB_CERCLE Summary of this function goes here
%   Detailed explanation goes here

im  = rgb2gray(I);
e = bwmorph(~imbinarize(im), 'remove');

[m, n] = size(im);
mini = (m + n) / 40 ;
maxi = (m + n) / 4;
pas = max(floor((maxi - mini) / (m/n*mini)), 3);
radii = mini:pas:maxi;
h = circle_hough(e, radii, 'same', 'normalise');

peaks = circle_houghpeaks(h, radii, 'nhoodxy', 15, 'nhoodr', 21, 'npeaks', 10, 'threshold', 0.9 * max(h(:)));

nb = size(peaks,2);
end

