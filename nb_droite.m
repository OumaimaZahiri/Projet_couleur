function [nb] = nb_droite (Image)
% prend en entrée une image et renvoie le nombre de droites dans le dessin

% On extrait le scontours de l'image
I = rgb2gray(Image);
I = 255 - I;

se = strel('disk',13);
It = imtophat(I,se);
BW = edge(It,'sobel',0.03);

% Hough

[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);

P = houghpeaks(H,1000,'threshold',ceil(0.25*max(H(:))));

lines = houghlines(BW,T,R,P,'FillGap',6,'MinLength',40);
compte = 0;
seuil = 10;
    for k = 1:length(lines)
         for j = k+1:length(lines)
            if (abs(lines(k).theta-lines(j).theta)<=seuil)
                compte=compte+1;
            end
         end
    end
 nb=compte;
end


    