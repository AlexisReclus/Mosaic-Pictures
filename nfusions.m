function [Image_finale] = nfusions(images)

%nfusions retourne l image fusionnee totale du vecteur d images fourni

[h, w, nb] = size(images);
tx = zeros(1,nb-1);
ty = tx;

%% Calcul du masque et de la boite pour la premiere image
    [Masques(:,:,1), Boites(:,:,1)] = boite_masques(images(:,:,1));
    
%% Calcul du vecteur translation, du masque et la boite pour la deuxieme image
    [h, w] = size(images(:,:,2));
    [tx(1), ty(1)] = vect_trans(images(:,:,1),images(:,:,2),w,h);
    [Masques(:,:,2), Boites(:,:,2)] = boite_masques(images(:,:,2));

%% Calcul de la translation de la boite 2 par rapport a la boite 1 et l'image resultante entre 1 et 2
    [Boites(:,:,2)] = trans_boite(Boites(:,:,1), tx(1), ty(1));
    [Image_finale, Masque_final, Boite_finale] = fusion(images(:,:,1), images(:,:,2), Masques(:,:,1), Masques(:,:,2), Boites(:,:,1), Boites(:,:,2));

%% Boucle pour realiser le processus sur les n images fournies
for i=3:nb
    
    %% Calcul de la taille de l image qu on fusionne
    [h, w] = size(images(:,:,i));
    %% Calcul du vecteur translation entre l image a fusionner et l image precedente
    [tx(i-1), ty(i-1)] = vect_trans(images(:,:,i-1),images(:,:,i),w,h);
    %% Calcul du masque et de la boite de l image a fusionner
    [Masques(:,:,i), Boites(:,:,i)] = boite_masques(images(:,:,i));
    
    %% Calcul de la tranlation de la boite de l image a fusionner
    [Boites(:,:,i)] = trans_boite(Boites(:,:,i-1), tx(i-1), ty(i-1));
    %% FUSION entre images
    [Image_finale, Masque_final, Boite_finale] = fusion(Image_finale, images(:,:,i), Masque_final, Masques(:,:,i), Boite_finale, Boites(:,:,i));
end

end