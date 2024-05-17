function Yp = odefun (t,Y)
%
%
global X0 mass conec rig Fext fixa;
%  Datos
%  =====
%     X0   : posiciones iniciales nodos 1 a 5
%     mass : masas puntos 1 a 5
%     conec: tabla de resortes y nodos conectados
%     rig  : constantes de resortes
% 

nnod  = length(X0)/2;
nres  = length(rig);
nfix  = length(fixa);

X  = Y(1       :2*nnod);
Xp = Y(2*nnod+1:4*nnod);

Yp(  1:2*nnod,1) = Xp;

Force = zeros(2*nnod,1);
for i=1:nres
    Ni = conec(i,1);
    Nj = conec(i,2);
    kij = rig(i);
    Force = Force + FuerzaResorte(Ni,Nj,X,X0,kij);
end

Force = -Force + Fext;

for i=1:nnod
    Force(2*i-1) = Force(2*i-1) / mass(i);
    Force(2*i  ) = Force(2*i  ) / mass(i);
end

Yp(2*nnod+1:4*nnod,1) = Force;

for i=1:nfix
    Yp(2*nnod+fixa(i)) = 0.;
end
