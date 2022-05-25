%% Dessinage, entrainement du classifieur. Calcul des centroides des classes.
clear all; close all; clc
%% variables

nb_classes = 5;

premier_age = 5;
nb_personnage_classe = [ 28, 24, 23, 18, 17];
nb_maison_classe = [ 28, 26, 17, 19, 18];
tolerance = 0.05;

% centroides pour chaque classe de dimension 4 (4 caractéristiques)
centroides_personnages = zeros(nb_classes, 4);
centroides_maisons = zeros(nb_classes, 4);

%% enregistrement des signatures de la moitié des images de chaque classe

for c = 0 : (nb_classes - 1)
    signature_personnages{c+1} = zeros(floor(nb_personnage_classe(c+1)), 4);
    for n = 1:nb_personnage_classe(c + 1)
        %         i = (n+1) / 2;
        i = n;
        I = imread(sprintf('Database_compressed/%d ans/bonhomme/personnage_%d_%d.jpg', c + premier_age, c + premier_age, n));

        signature_personnages{c+1}(i, 1) = nb_couleurs(I, tolerance);
        signature_personnages{c+1}(i, 2) = variance_zone(I);
        signature_personnages{c+1}(i, 3) = fctdemembrage(I);
        signature_personnages{c+1}(i,4) = Parallelisme(I);
    end

    signature_maisons{c+1} = zeros(floor(nb_maison_classe(c+1)), 4);
    for n = 1:nb_maison_classe(c + 1)
        %         i = (n+1) / 2;
        i = n;
        I = imread(sprintf('Database_compressed/%d ans/maison/maison_%d_%d.jpg', c + premier_age, c + premier_age, n));

        signature_maisons{c+1}(i, 1) = nb_couleurs(I, tolerance);
        signature_maisons{c+1}(i, 2) = variance_zone(I);
        signature_maisons{c+1}(i, 3) = nb_cercle(I);
        signature_maisons{c+1}(i,4) = Parallelisme(I);
    end
end

%% calcul des centroides pour chaque classe

for c=1:nb_classes
    centroides_personnages(c, 1) = 1 / nb_personnage_classe(c) * sum(signature_personnages{c}(:, 1));
    centroides_personnages(c, 2) = 1 / nb_personnage_classe(c) * sum(signature_personnages{c}(:, 2));
    centroides_personnages(c, 3) = 1 / nb_personnage_classe(c) * sum(signature_personnages{c}(:, 3));
    centroides_personnages(c, 4) = 1 / nb_personnage_classe(c) * sum(signature_personnages{c}(:, 4));

    centroides_maisons(c, 1) = 1 / nb_maison_classe(c) * sum(signature_maisons{c}(:, 1));
    centroides_maisons(c, 2) = 1 / nb_maison_classe(c) * sum(signature_maisons{c}(:, 2));
    centroides_maisons(c, 3) = 1 / nb_maison_classe(c) * sum(signature_maisons{c}(:, 3));
    centroides_maisons(c, 4) = 1 / nb_maison_classe(c) * sum(signature_maisons{c}(:, 4));

end

%% enregistrement des centroides dans un fichier .dat

save("centroides", "centroides_maisons", "centroides_personnages");

