function [ Masque, Boite ] = boite_masques( Image )
%boite_masques genere une boite englobante et un masque associes a une
%image originale

[h, w, s] = size(Image);
Masque = ones (h,w);
Boite = [-1000 -1000; -1000+w -1000+h];

end