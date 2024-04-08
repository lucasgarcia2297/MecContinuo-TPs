function graficar(X)
  #En una variable meto las posicion en x y en y de las masas
  x1 = X(:,1); %Posicion x masa m1
  x2 = X(:,3); %Posicion x masa m2
  x3 = X(:,5); %Posicion x masa m3
  x4 = X(:,7); %Posicion x masa m4
  x5 = X(:,9); %Posicion x masa m5
  x6 = X(:,11); %Posicion x masa m6
  x7 = X(:,13); %Posicion x masa m7
  y1 = X(:,2); %Posicion y masa m1
  y2 = X(:,4); %Posicion y masa m2
  y3 = X(:,6); %Posicion y masa m3
  y4 = X(:,8); %Posicion y masa m4
  y5 = X(:,10); %Posicion y masa m5
  y6 = X(:,12); %Posicion y masa m6
  y7 = X(:,14); %Posicion y masa m7

  figure(2)
  #Entro en un bucle para graficar
  for i = 1:1:length(X)
    clf %Elimino la grafica anterior
    #Activar el grid y el hold (Para que el segundo ploteo se haga) sobre el anterior
    grid on
    grid minor
    hold on
    
    #Definir el limite de los ejes manualmente, si no por cada grafica octave lo cambia
    axis([-4,16,-4,16]);
    
    #Grafico lo fijo -> m1 y m2 estan fijas tanto en x como en y
    #m1 fija tanto en x como en y
    line ([x1(1) x1(1)+1], [y1(1) y1(1)-1], "linestyle", "-", "color", "k");
    line ([x1(1) x1(1)-1], [y1(1) y1(1)-1], "linestyle", "-", "color", "k");
    line ([x1(1)-1.2 x1(1)+1.2], [y1(1)-1 y1(1)-1], "linestyle", "-", "color", "k");
    
    #m2 fija tanto en x como en y
    line ([x2(1) x2(1)+1], [y2(1) y2(1)-1], "linestyle", "-", "color", "k");
    line ([x2(1) x2(1)-1], [y2(1) y2(1)-1], "linestyle", "-", "color", "k");
    line ([x2(1)-1.2 x2(1)+1.2], [y2(1)-1 y2(1)-1], "linestyle", "-", "color", "k");
    
    #Puntos que representan las masas
    plot(x1(i),y1(i),'ro','MarkerSize',8);
    plot(x2(i),y2(i),'ro','MarkerSize',8);
    plot(x3(i),y3(i),'ro','MarkerSize',8);
    plot(x4(i),y4(i),'ro','MarkerSize',16);
    plot(x5(i),y5(i),'ro','MarkerSize',8);
    plot(x6(i),y6(i),'ro','MarkerSize',8);
    plot(x7(i),y7(i),'ro','MarkerSize',8);
    
    #Lineas que representan las conexiones entre masas
    #La 1 va con la 3 y la 4
    line ([x1(i) x3(i)], [y1(i) y3(i)], "linestyle", "-.", "color", "k");
    line ([x1(i) x4(i)], [y1(i) y4(i)], "linestyle", "-.", "color", "k");
    
    #La 2 va con la 4 y la 5
    line ([x2(i) x4(i)], [y2(i) y4(i)], "linestyle", "-.", "color", "k");
    line ([x2(i) x5(i)], [y2(i) y5(i)], "linestyle", "-.", "color", "k");
    
    #La 3 va con la 4 y la 6
    line ([x3(i) x4(i)], [y3(i) y4(i)], "linestyle", "-.", "color", "k");
    line ([x3(i) x6(i)], [y3(i) y6(i)], "linestyle", "-.", "color", "k");
    
    #La 4 va con la 5 la 6 y la 7
    line ([x4(i) x5(i)], [y4(i) y5(i)], "linestyle", "-.", "color", "k");
    line ([x4(i) x6(i)], [y4(i) y6(i)], "linestyle", "-.", "color", "k");
    line ([x4(i) x7(i)], [y4(i) y7(i)], "linestyle", "-.", "color", "k");
    
    #La 5 va con la 7
    line ([x5(i) x7(i)], [y5(i) y7(i)], "linestyle", "-.", "color", "k");
    
    #La 6 va con la 7
    line ([x6(i) x7(i)], [y6(i) y7(i)], "linestyle", "-.", "color", "k");
    
    pause(0.0005)
  endfor
endfunction