function [Yp] = odefun_PD (t,Y)
%
% Función que corresponde al inciso C.
%   Este archivo lo único que cambia de odefun.m es que llama a la función 
%   "FuerzaResorte_PD" para el calculo de fuerzas considerando 
%   pequeñas deformaciones.
%
global X0 mass conec rig Fext fixa;
%  Datos
%  =====
%     X0   : posiciones iniciales nodos 1 a nnod
%     mass : masas puntos 1 a nnod
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
    Force = Force + FuerzaResorte_PD(Ni,Nj,X,X0,kij);
endfor

Force = -Force + Fext;

for i=1:nnod
    Force(2*i-1) = Force(2*i-1) / mass(i);
    Force(2*i  ) = Force(2*i  ) / mass(i);
endfor

Yp(2*nnod+1:4*nnod,1) = Force;

for i=1:nfix
    Yp(2*nnod+fixa(i)) = 0.;
endfor

endfunction