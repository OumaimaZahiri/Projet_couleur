

function Parallel_index = Parallelisme(I)

   
    RGB = I;
    se = strel('disk',2);
    I  = im2gray(RGB);
    I=255-I;

    BW1 =imdilate(I,se);

    BW2=imfill(BW1,'holes');
    BW2 =imerode(BW2,se);
    BW3 = edge(BW2,'canny',0.5);

    [H,T,R] = hough(BW3,'RhoResolution',0.5,'Theta',-90:0.5:89);

    P = houghpeaks(H,1000,'threshold',ceil(0.3*max(H(:))));

    x = T(P(:,2));
    y = R(P(:,1));

    lines = houghlines(BW3,T,R,P,'FillGap',8,'MinLength',25);
    compte = 0;
    seuilAngle = 3;
    seuilRho = 40;
      for k = 1:length(lines)
        for j = k+1:length(lines)
            if (abs(lines(k).theta-lines(j).theta)<=seuilAngle)&&(abs(lines(k).rho-lines(j).rho)>=seuilRho)
                compte=compte+1;
            end
        end
        
     end

Parallel_index = compte ;





