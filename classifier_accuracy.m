%% test de la précision du classifieur entrainé
clear all; close all; clc
%% chargement des centroides calculés et variables

load("centroides.mat");
nb_classes = 4;

premier_age = 5;
nb_personnage_classe = [ 28, 24, 23, 18, 17];
nb_maison_classe = [ 28, 26, 17, 19, 18];

%% attribution d'une classe pour chaque image

for c = 0 : (nb_classes - 1)
    classe_personnages{c + 1} = zeros(floor(nb_personnage_classe(c+1) / 2), 1);
    for n = 2:2:nb_personnage_classe(c + 1)
        i = n / 2;
        I = imread(sprintf('Database_compressed/%d ans/bonhomme/personnage_%d_%d.jpg', c + premier_age, c + premier_age, n));

        classe_personnages{c+1}(i) = classify_image(I, 'personnage', premier_age, centroides_maisons, centroides_personnages);
    end

    classe_maisons{c+1} = zeros(floor(nb_maison_classe(c+1) / 2), 1);
    for n = 1:2:nb_maison_classe(c + 1)
        i = (n+1) / 2;
        I = imread(sprintf('Database_compressed/%d ans/maison/maison_%d_%d.jpg', c + premier_age, c + premier_age, n));

        classe_maisons{c+1}(i, 1) = classify_image(I, 'maison', premier_age, centroides_maisons, centroides_personnages);
    end
end

%% Détermination de la précision du classifieur

nb_juste = 0;
total = 0;
total_juste = 0;

for c=1:nb_classes
    [n_maison, ~] = size(classe_maisons{c});
    [n_personnages, ~] = size(classe_personnages{c});
    total = total + n_maison + n_personnages;
    nb_juste = 0;
    for i=1:n_maison
        if (classe_maisons{c}(i,1)) == c - 1 + premier_age
            nb_juste = nb_juste + 1;
        end
    end

    total_juste = total_juste + nb_juste;

    accuracy = nb_juste* 100 / n_maison;

    disp(['precision maisons ', num2str(c - 1 + premier_age), ' ans : ' ,num2str(accuracy), ' %']);
    nb_juste = 0;
    for i=1:n_personnages
        if (classe_personnages{c}(i,1)) == c - 1 + premier_age
            nb_juste = nb_juste + 1;
        end
    end
    total_juste = total_juste + nb_juste;

    accuracy = nb_juste* 100 / n_personnages;

    disp(['precision personnages ', num2str(c - 1 + premier_age), ' ans : ' ,num2str(accuracy), ' %']);
end

accuracy = total_juste* 100 / total;

disp(['precision : ', num2str(accuracy), ' %']);
