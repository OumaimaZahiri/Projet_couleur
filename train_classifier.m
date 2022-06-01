
%% Dessinage, entrainement du classifieur. Calcul des centroides des classes.
clear all; close all; clc
%% variables

nb_classes = 5;

premier_age = 5;
nb_personnage_classe = [ 28, 24, 23, 18, 17];
nb_maison_classe = [ 28, 26, 17, 19, 18];
tolerance = 0.05;

% centroides pour chaque classe de dimension 4 (4 caractéristiques)
nb_caracteristiques = 4;
centroides_personnages = zeros(nb_classes, nb_caracteristiques);
centroides_maisons = zeros(nb_classes, nb_caracteristiques);

%Barre de chargement
total = (sum(nb_maison_classe) + sum(nb_personnage_classe)) / 2;
chargement=0;
f=waitbar(chargement, "Progression...");

%% enregistrement des signatures d'une image sur deux de chaque classe

for c = 0 : (nb_classes - 1)
    signature_personnages{c+1} = zeros(floor(nb_personnage_classe(c+1) / 2), nb_caracteristiques);
    for n = 2:2:nb_personnage_classe(c + 1)
%         i = (n+1) / 2;
        i = n;
        I = imread(sprintf('Database_compressed/%d ans/bonhomme/personnage_%d_%d.jpg', c + premier_age, c + premier_age, n));

        signature_personnages{c+1}(i, 1) = nombrecouleurstest(I);
        signature_personnages{c+1}(i, 2) = variance_zone(I);
        signature_personnages{c+1}(i, 3) = nb_cercle(I);
        signature_personnages{c+1}(i,4) = Parallelisme(I);
        chargement = chargement + 1 / total;
        waitbar(chargement, f,"Progression...");
    end

    signature_maisons{c+1} = zeros(floor(nb_maison_classe(c+1) / 2), nb_caracteristiques);
    for n = 2:2:nb_maison_classe(c + 1)
%         i = (n+1) / 2;
        i = n;
        I = imread(sprintf('Database_compressed/%d ans/maison/maison_%d_%d.jpg', c + premier_age, c + premier_age, n));

        signature_maisons{c+1}(i, 1) = nombrecouleurstest(I);
        signature_maisons{c+1}(i, 2) = variance_zone(I);
        signature_maisons{c+1}(i, 3) = nb_cercle(I);
        signature_maisons{c+1}(i,4) = Parallelisme(I);
        chargement = chargement + 1 / total;
        waitbar(chargement, f, "Progression...");
    end
end

%% calcul des centroides pour chaque classe

for c=1:nb_classes
    for ctr=1:nb_caracteristiques
        centroides_personnages(c, ctr) = 1 / nb_personnage_classe(c) * sum(signature_personnages{c}(:, ctr));

        centroides_maisons(c, ctr) = 1 / nb_maison_classe(c) * sum(signature_maisons{c}(:, ctr));
    end
end

%% enregistrement des centroides dans un fichier .dat

save("centroides", "centroides_maisons", "centroides_personnages");

