function graficar(X)
%Para generar el GIF se le pasa la figuta y el nombre del archivo. 
##function graficar(X,f,filename)  

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

  #Grafico lo fijo -> m1 y m2 estan fijas tanto en x como en y
  #m1 fija tanto en x como en y
  plot([x1(1) x1(1)+1], [y1(1) y1(1)-1], "linestyle", "-", "color", "k");
  
  plot([x1(1) x1(1)-1], [y1(1) y1(1)-1], "linestyle", "-", "color", "k");
  plot([x1(1)-1.2 x1(1)+1.2], [y1(1)-1 y1(1)-1], "linestyle", "-", "color", "k");
  
  #m2 fija tanto en x como en y
  plot([x2(1) x2(1)+1], [y2(1) y2(1)-1], "linestyle", "-", "color", "k");
  plot([x2(1) x2(1)-1], [y2(1) y2(1)-1], "linestyle", "-", "color", "k");
  plot([x2(1)-1.2 x2(1)+1.2], [y2(1)-1 y2(1)-1], "linestyle", "-", "color", "k");
  
  #Lineas que representan las conexiones entre masas
  #La 1 va con la 3 y la 4
  h(1) = plot([x1(1) x3(1)], [y1(1) y3(1)], "linestyle", "-","lineWidth",2, "color", "k");
  h(2) = plot([x1(1) x4(1)], [y1(1) y4(1)], "linestyle", "-","lineWidth",2, "color", "k");
  
  #La 2 va con la 4 y la 5
  h(3) = plot([x2(1) x4(1)], [y2(1) y4(1)], "linestyle", "-","lineWidth",2, "color", "k");
  h(4) = plot([x2(1) x5(1)], [y2(1) y5(1)], "linestyle", "-","lineWidth",2, "color", "k");
  
  #La 3 va con la 4 y la 6
  h(5) = plot([x3(1) x4(1)], [y3(1) y4(1)], "linestyle", "-","lineWidth",2, "color", "k");
  h(6) = plot([x3(1) x6(1)], [y3(1) y6(1)], "linestyle", "-","lineWidth",2, "color", "k");
  
  #La 4 va con la 5 la 6 y la 7
  h(7) = plot([x4(1) x5(1)], [y4(1) y5(1)], "linestyle", "-","lineWidth",2, "color", "k");
  h(8) = plot([x4(1) x6(1)], [y4(1) y6(1)], "linestyle", "-","lineWidth",2, "color", "k");
  h(9) = plot([x4(1) x7(1)], [y4(1) y7(1)], "linestyle", "-","lineWidth",2, "color", "k");
  
  #La 5 va con la 7
  h(10)= plot([x5(1) x7(1)], [y5(1) y7(1)], "linestyle", "-","lineWidth",2, "color", "k");
  
  #La 6 va con la 7
  h(11) = plot([x6(1) x7(1)], [y6(1) y7(1)], "linestyle", "-","lineWidth",2, "color", "k");
  
  % Puntos que representan las masas
  h(12) = plot(x1(1),y1(1),'bo','MarkerSize',5,'markerfacecolor','blue');
  h(13) = plot(x2(1),y2(1),'bo','MarkerSize',5,'markerfacecolor','blue');
  h(14) = plot(x3(1),y3(1),'bo','MarkerSize',5,'markerfacecolor','blue');
  h(15) = plot(x4(1),y4(1),'bo','MarkerSize',10,'markerfacecolor','blue');
  h(16) = plot(x5(1),y5(1),'bo','MarkerSize',5,'markerfacecolor','blue');
  h(17) = plot(x6(1),y6(1),'bo','MarkerSize',5,'markerfacecolor','blue');
  h(18) = plot(x7(1),y7(1),'bo','MarkerSize',5,'markerfacecolor','blue');
  

  % Tiempo en segundos de cada trama en el GIF
##  DelayTime =0.001; 
  
  #Entro en un bucle para graficar
  for i = 1:1:length(X)
    pause(0.001)
    
    #Lineas que representan las conexiones entre masas
    #La 1 va con la 3 y la 4
    set(h(1),'xdata',[x1(i), x3(i)],'ydata',[y1(i), y3(i)]);
    set(h(2),'xdata',[x1(i), x4(i)],'ydata',[y1(i), y4(i)]);
    
    #La 2 va con la 4 y la 5
    set(h(3),'xdata',[x2(i), x4(i)],'ydata',[y2(i), y4(i)]);
    set(h(4),'xdata',[x2(i), x5(i)],'ydata',[y2(i), y5(i)]);
    
    #La 3 va con la 4 y la 6
    set(h(5),'xdata',[x3(i), x4(i)],'ydata',[y3(i), y4(i)]);
    set(h(6),'xdata',[x3(i), x6(i)],'ydata',[y3(i), y6(i)]);
    
    #La 4 va con la 5 la 6 y la 7
    set(h(7),'xdata',[x4(i), x5(i)],'ydata',[y4(i), y5(i)]);
    set(h(8),'xdata',[x4(i), x6(i)],'ydata',[y4(i), y6(i)]);
    set(h(9),'xdata',[x4(i), x7(i)],'ydata',[y4(i), y7(i)]);
    
    #La 5 va con la 7
    set(h(10),'xdata',[x5(i), x7(i)],'ydata',[y5(i), y7(i)]);
    
    #La 6 va con la 7
    set(h(11),'xdata',[x6(i), x7(i)],'ydata',[y6(i), y7(i)]);
    
    #Puntos que representan las masas
    set(h(12),'xdata',[x1(i) x1(i)],'ydata',[y1(i) y1(i)]);
    set(h(13),'xdata',[x2(i) x2(i)],'ydata',[y2(i) y2(i)]);
    set(h(14),'xdata',[x3(i) x3(i)],'ydata',[y3(i) y3(i)]);
    set(h(15),'xdata',[x4(i) x4(i)],'ydata',[y4(i) y4(i)]);
    set(h(16),'xdata',[x5(i) x5(i)],'ydata',[y5(i) y5(i)]);
    set(h(17),'xdata',[x6(i) x6(i)],'ydata',[y6(i) y6(i)]);
    set(h(18),'xdata',[x7(i) x7(i)],'ydata',[y7(i) y7(i)]);
   
      
##  % Procesamiento para el GIF
##    % Asignar figura a un frame
##    frame = getframe(f);
##    % Convert frame to RGB image (3 dimensional) 
##    im = frame2im(frame);
##    % Transform RGB samples to 1 dimension with a color map "cm". 
##    [imind,cm] = rgb2ind(im); 
##    if i == 1;
##        % Create GIF file
##        imwrite(imind,cm,filename,'gif','DelayTime', DelayTime , 'Compression' , 'lzw');
##    else
##        % Add each new plot to GIF
##        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime', DelayTime , 'Compression' , 'lzw');
##    endif
  endfor
endfunction