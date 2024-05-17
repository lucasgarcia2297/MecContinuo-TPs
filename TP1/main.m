%  Datos
%  =====
%     X0   : posiciones iniciales nodos 1 a nnod
%     mass : masas puntos 1 a nnod
%     conec: tabla de resortes y nodos conectados
%     rig  : constantes de resortes
clear all; clf;
clc;
global X0 mass conec rig Fext fixa ;
Pt = 0.5;   %Magnitud de la fuerza externa.
X0    = [0 0 10 0 1.25 5 5 5 8.75 5 2.5 10 7.5 10]';
mass  = [0.5 0.5 0.5 1 0.5 0.5 0.5]';
conec = [1 4; %tabla de resortes y nodos conectados
         7 6;
         4 3;
         4 6;
         2 4;
         4 5;
         4 7;
         2 5;
         5 7;
         1 3;
         3 6];
k=3;
rig   = [k k k k k k k k k k k]'; %constantes de resortes (k)
fixa  = [1 2 3 4];  %Posiciones fijas: x1 y1 x2 y2 
Fext  = [0 0 0 0 0 0 0 0 0 0 2*Pt 0 Pt 0]'; %Fuerzas externas sobre x1,y1,x2,y2,..,xn,yn

t0 = 0;   %Tiempo inicial = 0seg.
tF = 50; %Tiempo final = 50seg
tF_Inf_Est = 25; %Tiempo final para inciso C.

nnod  = length(X0)/2; %Número de nodos

Y0(1       :2*nnod,1) = X0(:,1);
Y0(2*nnod+1:4*nnod,1) = zeros(2*nnod,1);
#=======================================================================

#================================INCISO A=======================================
disp('=============================INCISO A===================================')
#CÁLCULOS:

[t,Y] = ode23(@odefun, [0 tF],Y0);

X  = Y(       1:2*nnod,:);
Xp = Y(2*nnod+1:4*nnod,:);

#-------------------------GRÁFICO DEL NODO NÚMERO 4-----------------------------
#Se grafica tanto en x como en y
figure(1)

subplot(2,1,1)
axis([0,tF,4,6.5]);
hold on
plot(t,Y(:,7),'b-o','MarkerSize',1) %posición x en el tiempo t
legend('Desplazamiento en X','FontSize', 14)
xlabel('Tiempo t','FontSize', 14)
ylabel('Coordenada X','FontSize', 14)
grid on
grid minor
title('Grafico Nodo Número 4','FontSize', 18)
hold off

subplot(2,1,2)
axis([0,tF,4,6.5]);
hold on
plot(t,Y(:,8),'r-*','MarkerSize',1) %posición y en el tiempo t
legend('Desplazamiento en Y','FontSize', 14)
xlabel('Tiempo t','FontSize', 14)
ylabel('Coordenada Y','FontSize', 14)
grid on
grid minor
hold off
#-------------------------GRÁFICO DE FUERZA EN LA BARRA NÚMERO 5----------------
Ni = 2; %Nodo 2
Nj = 4; %Nodo 4
kij = rig(5); % Constante de resorte para la barra 5
for i = 1:length(t)
    Fout(:,i) = FuerzaResorte(Ni,Nj,Y(i,:),X0,kij); 
    F(i) = norm(Fout(3:4,i)); % obtengo la magnitud de fuerza F24 (nodo 2 a nodo 4) que es igual a -F42
endfor
figure(2)
axis([0,tF, -0.5,4]);
hold on
title('Fuerza en la barra 5 (Nodos 2 y 4)','FontSize', 18)
xlabel('Tiempo t','FontSize', 14)
ylabel('Fuerza F','FontSize', 14)
plot(t,F,'r-o','MarkerSize',1)
grid on
hold off
#-------------------------------------------------------------------------------
#--------------------------------DESPLAZAMIENTO MÁXIMO--------------------------
for i=1:14
  desp(:,i) = abs(Y(:,i) - X0(i)); %desplazamientos de cada x e y
end
% Obtengo magnitud sacando la norma entre el desplazamiento en x y en y
cont = 0;
for i = 1:2:14
  cont += 1;
  for j = 1:length(desp(:,i))
    mag_desp(j,cont) = norm([desp(j,i) desp(j,i+1)]);
  endfor
endfor
for i =1:7
  max_desp(i) = max(mag_desp(:,i));
  printf('Desplazamiento máximo del Nodo %d = %f\n', i, max_desp(i));
  index(i) = find(mag_desp(:,i) == max_desp(i),1);
  Tiempo(i) = t(index(i));
  printf('Tiempo del desplazamiento máximo del Nodo %d = %f\n', i, Tiempo(i));
endfor
figure(3)
hold on
title('Desplazamientos de los nodos en el tiempo','FontSize', 18)
xlabel('Tiempo t','FontSize', 14)
ylabel('Magnitud de desplazamiento','FontSize', 14)
for i=1:7
    plot(t,mag_desp(:,i),'MarkerSize',1)
endfor
plot(Tiempo(3:7),max_desp(3:7),'k*');
legend('Nodo1',
       'Nodo2',
       'Nodo3',
       'Nodo4',
       'Nodo5',
       'Nodo6',
       'Nodo7',
       'Máximos')
grid on
hold off
##-------------------------------------------------------------------------------


##-------------------------MOVIMIENTO RETICULADO---------------------------------
##filename = 'Caso1-incisoA.gif';
figure(4)
axis([-1,12,-1,12]);
title('Deformación de la estructura','FontSize', 18)
xlabel('Coordenada X','FontSize', 14)
ylabel('Coordenada Y','FontSize', 14)
hold on;
grid on;
graficar(Y); #Es una funcion graficar.m
hold off;
disp('========================================================================')
##===============================================================================



#================================INCISO B=======================================
disp('=============================INCISO B===================================')
#Resolucion con Fext = sen(t)
[t_B,Y_B] = ode23(@odefun_senoidal, [0 tF], Y0);

#-------------------------GRÁFICO DEL NODO NÚMERO 4-----------------------------
#Se grafica tanto en x como en y
figure(5)

subplot(2,1,1)
axis([0,tF,4,6.5]);
hold on
plot(t_B,Y_B(:,7),'b-o','MarkerSize',1) %posición x en el tiempo t
legend('Desplazamiento en X','FontSize', 14)
xlabel('Tiempo t','FontSize', 14)
ylabel('Coordenada X','FontSize', 14)
grid on
grid minor
title('Grafico Nodo Número 4','FontSize', 18)
hold off

subplot(2,1,2)
axis([0,tF,4,6.5]);
hold on
plot(t_B,Y_B(:,8),'r-*','MarkerSize',1) %posición y en el tiempo t
legend('Desplazamiento en Y','FontSize', 14)
xlabel('Tiempo t','FontSize', 14)
ylabel('Coordenada Y','FontSize', 14)
grid on
grid minor
hold off

#-------------------------GRÁFICO DE FUERZA EN LA BARRA NÚMERO 5----------------
Ni = 2; %Nodo 2
Nj = 4; %Nodo 4
kij = rig(5); % Constante de resorte para la barra 5
for i = 1:length(t_B)
    Fout_B(:,i) = FuerzaResorte(Ni,Nj,Y_B(i,:),X0,kij); 
    F_B(i) = norm(Fout_B(3:4,i)); % obtengo la magnitud de fuerza F24 (nodo 2 a nodo 4) que es igual a -F42
endfor
figure(6)
axis([0,tF, -0.5,4]);
hold on
title('Fuerza en la barra 5 (Nodos 2 y 4)','FontSize', 18)
xlabel('Tiempo t','FontSize', 14)
ylabel('Fuerza F','FontSize', 14)
plot(t_B,F_B,'r-o','MarkerSize',1)
grid on
hold off
#-------------------------------------------------------------------------------
#--------------------------------DESPLAZAMIENTO MÁXIMO--------------------------
for i=1:14
  desp_B(:,i) = abs(Y_B(:,i) - X0(i)); %desplazamientos de cada x e y
end
% Obtengo magnitud sacando la norma entre el desplazamiento en x y en y
cont = 0;
for i = 1:2:14
  cont += 1;
  for j = 1:length(desp_B(:,i))
    mag_desp_B(j,cont) = norm([desp_B(j,i) desp_B(j,i+1)]);
  endfor
endfor
for i =1:7
  max_desp_B(i) = max(mag_desp_B(:,i));
  printf('Desplazamiento máximo del Nodo %d = %f\n', i, max_desp_B(i));
  index_B(i) = find(mag_desp_B(:,i) == max_desp_B(i),1);
  Tiempo_B(i) = t_B(index_B(i));
  printf('Tiempo del desplazamiento máximo del Nodo %d = %f\n', i, Tiempo_B(i));
endfor
figure(7)
hold on
title('Desplazamientos de los nodos en el tiempo','FontSize', 18)
xlabel('Tiempo t','FontSize', 14)
ylabel('Magnitud de desplazamiento','FontSize', 14)
for i=1:7
    plot(t_B,mag_desp_B(:,i),'MarkerSize',1)
endfor
plot(Tiempo_B(3:7),max_desp_B(3:7),'k*');
legend('Nodo1',
       'Nodo2',
       'Nodo3',
       'Nodo4',
       'Nodo5',
       'Nodo6',
       'Nodo7',
       'Máximos')
grid on
hold off
##------------------------------------------------------------------------------
##-------------------------MOVIMIENTO RETICULADO--------------------------------
##filename = 'Caso1-incisoB.gif';
figure(8)
axis([-1,12,-1,12]);
title('Deformación de la estructura','FontSize', 18)
xlabel('Coordenada X','FontSize', 14)
ylabel('Coordenada Y','FontSize', 14)
hold on;
grid on;
graficar(Y_B); #Es una funcion graficar.m
hold off;
##==============================================================================
disp('========================================================================')

#================================INCISO C=======================================
disp('=============================INCISO C===================================')
#Resolucion con Fext = sen(t)
[t_C,Y_C] = ode23(@odefun_PD, [0 tF_Inf_Est], Y0);

#-------------------------GRÁFICO DEL NODO NÚMERO 4-----------------------------
#Se grafica tanto en x como en y
figure(9)

subplot(2,1,1)
axis([0,tF_Inf_Est, 4,6.5]);
hold on
plot(t_C,Y_C(:,7),'b-o','MarkerSize',1) %posición x en el tiempo t
legend('Desplazamiento en X','FontSize', 14)
xlabel('Tiempo t','FontSize', 14)
ylabel('Coordenada X','FontSize', 14)
grid on
grid minor
title('Grafico Nodo Número 4','FontSize', 18)
hold off

subplot(2,1,2)
axis([0,tF_Inf_Est, 4,6.5]);
hold on
plot(t_C,Y_C(:,8),'r-*','MarkerSize',1) %posición y en el tiempo t
legend('Desplazamiento en Y','FontSize', 14)
xlabel('Tiempo t','FontSize', 14)
ylabel('Coordenada Y','FontSize', 14)
grid on
grid minor
hold off
#-------------------------GRÁFICO DE FUERZA EN LA BARRA NÚMERO 5----------------
Ni = 2; %Nodo 2
Nj = 4; %Nodo 4
kij = rig(5); % Constante de resorte para la barra 5
for i = 1:length(t_C)
    Fout_C(:,i) = FuerzaResorte_PD(Ni,Nj,Y_C(i,:),X0,kij); 
    F_C(i) = norm(Fout_C(3:4,i)); % obtengo la magnitud de fuerza F24 (nodo 2 a nodo 4) que es igual a -F42
endfor
figure(10)
axis([0,tF_Inf_Est, -0.5,4]);
hold on
title('Fuerza en la barra 5 (Nodos 2 y 4)','FontSize', 18)
xlabel('Tiempo t','FontSize', 14)
ylabel('Fuerza F','FontSize', 14)
plot(t_C,F_C,'r-o','MarkerSize',1)
grid on
hold off
#-------------------------------------------------------------------------------
#--------------------------------DESPLAZAMIENTO MÁXIMO--------------------------
for i=1:14
  desp_C(:,i) = abs(Y_C(:,i) - X0(i)); %desplazamientos de cada x e y
end
% Obtengo magnitud sacando la norma entre el desplazamiento en x y en y
cont = 0;
for i = 1:2:14
  cont += 1;
  for j = 1:length(desp_C(:,i))
    mag_desp_C(j,cont) = norm([desp_C(j,i) desp_C(j,i+1)]);
  endfor
endfor
for i =1:7
  max_desp_C(i) = max(mag_desp_C(:,i));
  printf('Desplazamiento máximo del Nodo %d = %f\n', i, max_desp_C(i));
  index_C(i) = find(mag_desp_C(:,i) == max_desp_C(i),1);
  Tiempo_C(i) = t_C(index_C(i));
  printf('Tiempo del desplazamiento máximo del Nodo %d = %f\n', i, Tiempo_C(i));
endfor
figure(11)
hold on
title('Desplazamientos de los nodos en el tiempo','FontSize', 18)
xlabel('Tiempo t','FontSize', 14)
ylabel('Magnitud de desplazamiento','FontSize', 14)
for i=1:7
    plot(t_C,mag_desp_C(:,i),'MarkerSize',1)
endfor
plot(Tiempo_C(3:7),max_desp_C(3:7),'k*');
legend('Nodo1',
       'Nodo2',
       'Nodo3',
       'Nodo4',
       'Nodo5',
       'Nodo6',
       'Nodo7',
       'Máximos')
grid on
hold off
##------------------------------------------------------------------------------
##-------------------------MOVIMIENTO RETICULADO--------------------------------
figure(12)
##filename = 'Caso1-incisoC'
axis([-1,12,-1,12]);
title('Deformación de la estructura','FontSize', 18)
xlabel('Coordenada X','FontSize', 14)
ylabel('Coordenada Y','FontSize', 14)
hold on;
grid on;
graficar(Y_C); #Es una funcion graficar.m
hold off;
##==============================================================================
disp('========================================================================')

##==============================================================================