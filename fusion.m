function [ Im, M, B ] = fusion( Im1, Im2, M1, M2, B1, B2 )
% fusion effectue la fusion de deux images et retourne une image, un masque
% et une boite englobante

%% Calcul de la taille des images a fusionner
[h1,w1,s1] = size(Im1);
[h2,w2,s2] = size(Im2);

%% Retourne une erreur si une image est en noir et blanc et l autre et en couleur par exemple
if (s1~=s2)
    disp('ERROR SIZE OF IMAGES');
    return;
end

%% Calcul de la boite englobante totale B a partir de B1 et B2
B(1,:) = min(B1(1,:), B2(1,:));
B(2,:) = max(B1(2,:), B2(2,:));

%% Preallocation du masque et de l image fusionnee resultante
taillex = B(2,1) - B(1,1);
tailley = B(2,2) - B(1,2);

M = zeros(tailley, taillex);
Im = M;

%% Calcul des positions de l image 1 dans l image fusionne resultante
pos_im1_t = [B1(1,2) - B(1,2) + 1, B1(1,1) - B(1,1) + 1];
pos_im1_b = [pos_im1_t(1,1) + h1 - 1, pos_im1_t(1,2) + w1 - 1];
%% Calcul des positions de l image 2 dans l image fusionne resultante
pos_im2_t = [B2(1,2) - B(1,2) + 1, B2(1,1) - B(1,1) + 1];
pos_im2_b = [ pos_im2_t(1,1) + h2 - 1, pos_im2_t(1,2) + w2 - 1];

%% On place l image 1 dans l image fusionnee resultante, en multipliant par la valeur du masque 1 pour que les pixels comptent avec leur "poids fort"
Im(pos_im1_t(1,1):pos_im1_b(1,1),pos_im1_t(1,2):pos_im1_b(1,2),1:s1) = Im1(1:h1,1:w1,1:s1).*M1(:,:,1);
%% On place l image 2 dans l image fusionnee resultante, en multipliant par la valeur du masque 2 pour que les pixels comptent avec leur "poids fort"
Im(pos_im2_t(1,1):pos_im2_b(1,1),pos_im2_t(1,2):pos_im2_b(1,2),1:s2) = Im(pos_im2_t(1,1):pos_im2_b(1,1),pos_im2_t(1,2):pos_im2_b(1,2),1:s2) + Im2(1:h2,1:w2,1:s2).* M2(:,:,1);

%% Realisatio du masque resultant en mettant les valeurs du masque 1 au bon endroit
M(pos_im1_t(1,1):pos_im1_b(1,1),pos_im1_t(1,2):pos_im1_b(1,2)) = M1(1:h1,1:w1);
%% Realisatio du masque resultant en additionnant les valeurs du masque 2 au bon endroit
M(pos_im2_t(1,1):pos_im2_b(1,1),pos_im2_t(1,2):pos_im2_b(1,2)) = M(pos_im2_t(1,1):pos_im2_b(1,1),pos_im2_t(1,2):pos_im2_b(1,2)) + M2(1:h2,1:w2);

%% On divise par le masque resultant pour corriger l intensite
Im(:,:,:) = Im(:,:,:)./M(:,:,1);
Im(isnan(Im))=0;

end

