% %% Demembrage
% 
% clc
% close all;
% clear all;
% 
% %%
% rep = '5';
% img = 3;
% 
% I = imread(sprintf('Database_compressed/%s ans/bonhomme/personnage_%s_%d.jpg',rep,rep,img));
% 
% imshow(I);
% 
% figure
% imshow(I);
% %%
% 
% rgbI=rgb2gray(I);
% 
% figure 
% imshow(rgbI)
% 
% %% top hat
% 
% se = strel('disk',20);
% I=255-rgbI;
% 
% figure
% imshow(I);
% 
% It = imtophat(I,se);
% BW = edge(It,'sobel',0.03);
% figure 
% imshow(BW,[])
% 
% %%  ouverture
% 
% Iero = bwareaopen(BW,40);
% figure
% imshow(Iero);
% 
% %% 
% 
% [ L , num ] = bwlabel(Iero);

%% test sur les classes

nb_classes = 5;
classes = [ 5, 6, 7, 8, 9 ] ;
nb_personnage_classe = [ 28, 24, 23, 18, 17];
nb_maison_classe = [ 28, 26, 17, 19, 18];

moypers = [];
moymaisons = [];


for i=1:5
    c = 0;
    
    for j=1:nb_personnage_classe(1,i)
        rep = classes(i);
        img = j;

        I= imread(sprintf('Database_compressed/%d ans/bonhomme/personnage_%d_%d.jpg',rep,rep,img));
        c = c + fctdemembrage(I);
    end
    moymoy = c/nb_personnage_classe(1,i);
    moypers = [moypers, moymoy]; 
end

for i=1:5
    c = 0;
    
    for j=1:nb_maison_classe(1,i)
        rep = classes(i);
        img = j;

        I= imread(sprintf('Database_compressed/%d ans/maison/maison_%d_%d.jpg',rep,rep,img));
        c = c + fctdemembrage(I);
    end
    moymoy = c/nb_maison_classe(1,i);
    moymaisons = [moymaisons, moymoy]; 
end

I= imread(sprintf('Database_compressed/5 ans/maison/maison_5_1.jpg',rep,rep,img));
fctdemembrage(I)

