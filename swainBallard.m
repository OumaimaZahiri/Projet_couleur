function nb_color = swainBallard(img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
quant=4;
nb_bin=quant^3;
Iq=floor(img/nb_bin);
    
Iq=Iq(:,:,1)+quant*Iq(:,:,2)+quant*quant*Iq(:,:,3);
h=histogram(Iq(:),nb_bin);

[~,nb_color] = size(find(h.BinCounts > 0.02 * sum(h.BinCounts)));
nb_color = nb_color - 1;

end

