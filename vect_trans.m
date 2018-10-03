function [ res_tx, res_ty ] = vect_trans( img1, img2,w, h )
%This functions computes the translation vector between the two images

%% Cette partie est a decommenter dans le cas ou la mosaique d image est en couleur
% R1=img1(:,:,1);
% G1=img1(:,:,2);
% B1=img1(:,:,3);
% 
% Y1=0.299*R1+0.587*G1+0.114*B1;
% 
% R2=img2(:,:,1);
% G2=img2(:,:,2);
% B2=img2(:,:,3);
% 
% Y2=0.299*R2+0.587*G2+0.114*B2;

%% Pour une image en couleur, decommenter la partie precedente et changer img1 par Y1 et img2 par Y2
fft_img1 = fft2(img1);
fft_img2 = fft2(img2);

P = fft_img2.*conj(fft_img1)./(abs(fft_img2.*conj(fft_img1)));

p = ifft2(P);

[res_ty, res_tx] = find(p == max(p(:)));

if (res_tx < floor(w/2))
    res_tx=-res_tx+1;
else
    res_tx = w-res_tx+1;
    
end
if (res_ty < floor(h/2))
        res_ty = -res_ty+1;
    else
        res_ty = h-res_ty+1;
end
end

