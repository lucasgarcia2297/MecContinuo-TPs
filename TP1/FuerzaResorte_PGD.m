function [Fout] = FuerzaResorte_PGD(Ni,Nj,X,X0,kij)
  % Calcula la fuerza que genera el resorte Ni-Nj 
  % Datos
  % =====
  %    Ni, Nj : numero de nodos i, j
  %    X      : vector de desplazamientos actuales
  %    X0     : vector de desplazamientos iniciales
  %    kij    : constante de resorte  
  %
  % Salida
  % ======
  %    Fout   : vector de fuerzas en salida 
  %

  nnod = length(X0)/2;
  Fout = zeros(2*nnod,1);  
  xi  = X((Ni-1)*2+1);
  yi  = X((Ni-1)*2+2);
  xj  = X((Nj-1)*2+1);
  yj  = X((Nj-1)*2+2);

  xi0  = X0((Ni-1)*2+1);
  yi0  = X0((Ni-1)*2+2);
  xj0  = X0((Nj-1)*2+1);
  yj0  = X0((Nj-1)*2+2);
  
  fij = kij*(sqrt((xj -xi )^2+(yj -yi )^2) - ...
             sqrt((xj0-xi0)^2+(yj0-yi0)^2));
  
  eij = [(xj -xi ); 
         (yj -yi )] / sqrt((xj0 -xi0 )^2+(yj0 -yi0)^2);
  
  Fout((Ni-1)*2+1,1) = -fij*eij(1);
  Fout((Ni-1)*2+2,1) = -fij*eij(2);
  Fout((Nj-1)*2+1,1) =  fij*eij(1);
  Fout((Nj-1)*2+2,1) =  fij*eij(2);
  
endfunction
