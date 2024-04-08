function Yp = odefun_senoidal(t,Y)
  global X0 mass conec rig Fext fixa Pt;
  
  nnod = length(X0)/2;
  nres = length(rig);
  nfix = length(fixa);
  
  X = Y(1:2*nnod);
  Xp = Y(2*nnod + 1:4*nnod);
  
  Yp(1:2*nnod,1) = Xp;
  
  Force = zeros(2*nnod,1);
  
  for i = 1:nres
    Ni = conec(i,1);
    Nj = conec(i,2);
    kij = rig(i);
    Force += FuerzaResorte(Ni, Nj, X, X0, kij);
  endfor
  
  #Aca esta todda la modificacion para incluir la fuerza senoidal en el tiempo
  Amplitud = 1;
  Frecuencia = 0.5;
  
  #Calculo el valor de la fuerza senoidal en funcion del tiempo t
  Fuerza_senoidal = Amplitud*sin(2*pi*Frecuencia*t);
  
  %Asegurar que la fuerza senoidal actue solo en los nodos donde se aplica Pt
  Fuerza_senoidal_aplicada = zeros(2*nnod,1);
  Fuerza_senoidal_aplicada(11) = 2*Fuerza_senoidal;
  Fuerza_senoidal_aplicada(13) = Fuerza_senoidal;
  
  %Ajustar la fuerza senoidal al tamano correcto
  Fuerza_senoidal_aplicada = Fuerza_senoidal_aplicada(1:2*nnod);
  
  Force = -Force + Fext + Fuerza_senoidal_aplicada(1:2*nnod);
  
  for i = 1:nnod
    Force(2*i-1) = Force(2*i-1)/mass(i);
    Force(2*i) = Force(2*i) / mass(i);
  endfor
  
  Yp(2*nnod + 1:4*nnod,1) = Force;
  
  for i = 1:nfix
    Yp(2*nnod + fixa(i)) = 0.;
  end
endfunction