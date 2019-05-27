%¿Cómo se puede mejorar la calidad de las imágenes distorsion2.jpg, rostro1.png y
%rostro2.png? [TODO]

%Se utiliza un filtro mediana cuya plantilla tenga un tamaño tal que al aplicarlo sobre los píxeles
%de los puntos siempre haya en el entorno que define la plantilla un número superior del píxeles que
%no sean píxeles de los puntos. De esta forma el tono de gris de cada píxel de un punto se sustituye
%por el tono de gris correspondiente al valor mediano de los tonos de gris de los píxeles que
%cubre la plantilla. 

%En estas imagenes puede apreciarse la importancia de definir el tamaño de la máscara [3 3]. Cuanto mayor
%sea ésta se consigue una mayor reducción del ruido, pero a cambio se produce una mayor
%difuminación de los bordes. 

I1=imread('rostro1.png');
I2=imread('rostro2.png');
I3=imread('distorsion2.jpg');

fg=fspecial('gaussian',5,0.5);
I1Gaussiano= imfilter(I1,fg);
I2Gaussiano= imfilter(I2,fg);
I3Gaussiano= imfilter(I3,fg);

I1mediana=medfilt2(I1,[3 3]);
I2mediana=medfilt2(I2,[3 3]);

I3mediana=cat(3,medfilt2(I3(:,:,1),[3 3]),medfilt2(I3(:,:,2),[3 3]),medfilt2(I3(:,:,3),[3 3])); %mediana con entorno 5 5

figure,
subplot(3,3,1),imshow(I1),title('rostro 1');
subplot(3,3,2),imshow(I2),title('rostro 2');
subplot(3,3,3),imshow(I3),title('distorsion');

subplot(3,3,4),imshow(I1Gaussiano),title('gauss 1');
subplot(3,3,5),imshow(I2Gaussiano),title('gauss 2');
subplot(3,3,6),imshow(I3Gaussiano),title('gauss');

subplot(3,3,7),imshow(I1mediana),title('mediana 1');
subplot(3,3,8),imshow(I2mediana),title('mediana 2');
subplot(3,3,9),imshow(I3mediana),title('mediana');