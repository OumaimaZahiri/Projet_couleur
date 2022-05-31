function NB = nombrecouleurstest(I)

Image=I;

[x,y,z]=size(Image);
listeRGB=[];
listeHSV=[];
seuil=0.5;
for i=1:3:x
    for j=1:3:y
        t=size(listeRGB,2);
        couleurRGB  = [[Image(i,j,1),Image(i,j,2),Image(i,j,3)]];
        couleurHSV = rgb2hsv(double(couleurRGB)/255);
        h1=couleurHSV(1);s1=couleurHSV(2);v1=couleurHSV(3);
        testseuil=1;
        for k=1:t/3
            h2=listeHSV(3*(k-1)+1);
            s2=listeHSV(3*(k-1)+2);
            v2=listeHSV(3*k);
            hsvdistance=sqrt((v2-v1)^2+s1^2+s2^2-2*s1*s2*cos(h2-h1));
            if hsvdistance<seuil
                testseuil=0;
            end
        end
        if testseuil==1
            listeRGB=[listeRGB,couleurRGB];
            listeHSV=[listeHSV,couleurHSV];
        end
    end
end

NB=size(listeRGB,2);
