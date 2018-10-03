function [ img1, img2, img3, img4 ] = decoupe_img( A,w,h,tx,ty )
%This function cut an image into 2 sub-images with size w*h and shifted by
%tx and ty
figure,
imshow(uint8(A));

[x, y] = ginput(1);
x = floor(x);
y = floor(y);

%% On effectue le decoupage manuel, en appliquant toujours tx et ty par rapport à la photo precedente
img1 = A(y:y+h-1,x:x+w-1,:);
img2 = A(y+ty:y+ty+h-1,x+tx:x+tx+w-1,:);
img3 = A(y+2*ty:y+2*ty+h-1,x+2*tx:x+2*tx+w-1,:);
img4 = A(y+3*ty:y+3*ty+h-1,x+3*tx:x+3*tx+w-1,:);

end

