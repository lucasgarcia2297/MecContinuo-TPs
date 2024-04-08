%  Datos
%  =====
%     X0   : posiciones iniciales nodos 1 a nnod
%     mass : masas puntos 1 a nnod
%     conec: tabla de resortes y nodos conectados
%     rig  : constantes de resortes
clear all
clc
global X0 mass conec rig Fext fixa;
Pt = 0.5;
X0    = [0 0 10 0 1.25 5 5 5 8.75 5 2.5 10 7.5 10]';
mass  = [0.5 0.5 0.5 4 0.5 0.5 0.5]';
conec = [1 4;
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
rig   = [3 3 3 3 3 3 3 3 3 3 3]';
fixa  = [1 2 3 4];
Fext  = [0 0 0 0 0 0 0 0 0 0 2*Pt 0 Pt 0]';

nnod  = length(X0)/2;

Y0(1       :2*nnod,1) = X0(:,1);
Y0(2*nnod+1:4*nnod,1) = zeros(2*nnod,1);

[t,Y] = ode45(@odefunejer6,[0 25],Y0); #Uso este porque demora la mitad, pero devuelve menor cantidad de nodos
#[t,Y] = ode23(@odefunejer6, [0 25],Y0);

#X  = Y(       1:2*nnod,:);
#Xp = Y(2*nnod+1:4*nnod,:);

#========================GRAFICO DEL NODO NUMERO 4========================
#Se grafica tanto en X como en Y

#El tiempo t sale de la funcion ode23
figure(1)
plot(t,Y(:,7),'-o')
hold on
plot(t,Y(:,8),'r-*')
title('Grafic Nodo Numero 4')
legend('Fuerza en X', 'Fuerza en Y')
grid on
grid minor

#========================GRAFICO DE BARRA NUMERO 5========================
#los nodos 2 y 4
#figure(2)

#========================GRAFICO RETICULADO========================
graficar(Y); #Es una funcion graficar.m

#==========================================================================================================
#==========================================================================================================

#========================Resolucion con Fext = sen(t)========================
[t_sen,y_sen] = ode45(@odefun_senoidal, [0 25], Y0);

##========================Grafico del nodo numero 4========================
figure(4)
plot(t_sen,y_sen(:,7),'o')
hold on
plot(t_sen,y_sen(:,8),'r-*')
title('Grafico nodo numero 4 con fuerza senoidal')
legend('Fuerza en X', 'Fuerza en Y')
grid on
grid minor
##========================GRAFICO DE BARRA NUMERO 5========================
figure(5)

##========================GRAFICO RETICULADO========================
graficar(y_sen); #Es una funcion graficar.m