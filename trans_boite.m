function [ Boite_out ] = trans_boite( Boite, tx, ty )
%trans_boite realise la translation d une boite

Boite_out(:,1) = Boite(:,1) + tx;
Boite_out(:,2) = Boite(:,2) + ty;

end

