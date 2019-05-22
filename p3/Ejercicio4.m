%Usa la funci�n adapthisteq sobre la imagen mujer.jpg y analiza el resultado.
I=imread('mujer.jpg');
J=adapthisteq(I);
J2=adapthisteq(I,'clipLimit',0.005,'Distribution','uniform');
J3=adapthisteq(I,'clipLimit',0.005,'Distribution','exponential');
J4=adapthisteq(I,'clipLimit',0.005,'Distribution','rayleigh');
figure,imshow(J);
figure,imshow(J2);figure,imshow(J3);figure,imshow(J4);

%realiza ecualizaci�n de histograma adaptable con contraste limitado.
%A diferencia de histeq, opera en peque�as regiones de datos (tiles) en lugar de en toda la imagen. 
%El contraste de cada mosaico se realza de manera que el histograma de cada regi�n de salida coincida aproximadamente con el histograma 
%especificado (distribuci�n uniforme por defecto). El realce de contraste puede ser limitado para evitar amplificar el ruido que podr�a estar presente en la imagen.

%[TODO]