function num = fctdemembrage(I)
    % compte le nombre de régions connexes sur une image
    rgbI=rgb2gray(I);
    se = strel('disk',20);
    I=255-rgbI;
    It = imtophat(I,se);
    BW = edge(It,'sobel',0.03);
    Iero = bwareaopen(BW,40);
    [ L , num ] = bwlabel(Iero);
end

