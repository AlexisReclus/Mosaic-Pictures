clear;
close all;
clc;

%% Choix des images
[filename,pathname]=uigetfile('*.bmp','multiselect','on');
for f=1:length(filename)
    images(:,:,f) = double(imread(fullfile(pathname,filename{f})));
end

tic
%% Appel de la fonction
ImgFinale = nfusions(images);
toc
%% Affichage de l image fusionnee
figure
imshow(uint8(ImgFinale));

%% Calcul de l erreur en changeant l ordre
% 
% [filename,pathname]=uigetfile('*.bmp','multiselect','on');
% for f=1:length(filename)
%     images2(:,:,f) = double(imread(fullfile(pathname,filename{f})));
% end
% 
% ImgFinale2 = nfusions(images2);
% 
% figure
% imshow(uint8(ImgFinale2));

%% Attention, prendre le meme nbre d images pour avoir une somme realisable
%error = sum(sum(abs(ImgFinale2 - ImgFinale)));