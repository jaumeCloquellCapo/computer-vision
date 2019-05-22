%Usa la función adapthisteq sobre la imagen mujer.jpg y analiza el resultado.
I=imread('mujer.jpg');
J=adapthisteq(I);
J2=adapthisteq(I,'clipLimit',0.005,'Distribution','uniform');
J3=adapthisteq(I,'clipLimit',0.005,'Distribution','exponential');
J4=adapthisteq(I,'clipLimit',0.005,'Distribution','rayleigh');
figure,imshow(J);
figure,imshow(J2);figure,imshow(J3);figure,imshow(J4);

%realiza ecualización de histograma adaptable con contraste limitado.
%A diferencia de histeq, opera en pequeñas regiones de datos (tiles) en lugar de en toda la imagen. 
%El contraste de cada mosaico se realza de manera que el histograma de cada región de salida coincida aproximadamente con el histograma 
%especificado (distribución uniforme por defecto). El realce de contraste puede ser limitado para evitar amplificar el ruido que podría estar presente en la imagen.

%[TODO]