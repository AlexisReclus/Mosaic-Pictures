%% Projet TS 225 --� Recalage par correlation de phase | Application a la construction d’une mosaïque d’images

clear;
close all;
clc;

%% Nous chargeons l image de notre choix
A = double(imread('/phare.jpg'));

w = 256;
h = 128;
tx = 52;
ty = 26;

%% On decoupe l image en 4 sous images
[img1, img2, img4, img6] = decoupe_img(A,w,h,tx,ty);

figure,
subplot(4,1,1);
imshow(uint8(img1));
subplot(4,1,2);
imshow(uint8(img2));
subplot(4,1,3)
imshow(uint8(img4));
subplot(4,1,4)
imshow(uint8(img6));

%% calcul du vecteur translation entre les 4 sous images

[posx, posy] = vect_trans(img1,img2,w,h);
[posx_2, posy_2] = vect_trans(img2,img4,w,h);
[posx_3, posy_3] = vect_trans(img4,img6,w,h);

%% Realisation de la fusion entre les images

[M1, Boite1] = boite_masques(img1);

[M2, Boite2] = boite_masques(img2);
[Boite2] = trans_boite(Boite1, posx, posy);

%% Fusion image 1 / image 2
[img3, M3, Boite3] = fusion( img1, img2, M1, M2, Boite1, Boite2);

[M4, Boite4] = boite_masques(img4);
[Boite4] = trans_boite(Boite2, posx_2, posy_2);

%% Fusion image 1-2 / image 3
[img5, M5, Boite5] = fusion(img3, img4, M3, M4, Boite3, Boite4);

[M6, Boite6] = boite_masques(img6);
[Boite6] = trans_boite(Boite4, posx_3, posy_3);

%% Fusion image 1-2-3 / image 4
[img7, M7, Boite7] = fusion(img5, img6, M5, M6, Boite5, Boite6);

figure, 
imshow(uint8(img7));