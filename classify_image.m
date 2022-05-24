function classe = classify_image(I, type, premier_age, centroides_maison, centroides_personnages)

signature = [nb_couleurs(I, 0.05), variance_zone(I), nb_cercle(I), nb_droite(I)];

n =size(centroides_maison, 1);

distances = zeros(1, n);

if strcmp(type, 'maison')
    % calcul des distances avec le centroide de la classe
    for c=1:n
        distances(c) = sqrt((centroides_maison(c, 1) - signature(1))^2 + (centroides_maison(c, 2) - signature(2))^2 + (centroides_maison(c, 3) - signature(3))^2 + (centroides_maison(c, 4) - signature(4))^2);
    end
else
    % calcul des distances avec le centroide de la classe
    for c=1:n
        distances(c) = sqrt((centroides_personnages(c, 1) - signature(1))^2 + (centroides_personnages(c, 2) - signature(2))^2 + (centroides_personnages(c, 3) - signature(3))^2 + (centroides_personnages(c, 4) - signature(4))^2);
    end
end

classe = 0;

for c=1:n
    if distances(classe + 1) > distances(c)
        classe = c - 1;
    end
end

classe = classe + premier_age;

end
