% Usa imadjust para aplicar la siguiente función de transferencia a la imagen campo.ppm:

%? Ecualizar por separado cada banda R, G, B.

imgrgb=imread('campo.ppm');
equ=cat(3,histeq(imgrgb(:,:,1)),histeq(imgrgb(:,:,2)),histeq(imgrgb(:,:,3)));

f=figure(2); set(f,'Name','Imagen Ecualizada');
subplot(3,3,1);imshow(equ),title('Ecualizada');
subplot(3,3,4);imshow(equ(:,:,1)),title('Rojo');
subplot(3,3,5);imshow(equ(:,:,2)),title('Verde');
subplot(3,3,6);imshow(equ(:,:,2)),title('Azul');
subplot(3,3,7);imhist(equ(:,:,1)),title('Hist Rojo');
subplot(3,3,8);imhist(equ(:,:,2)),title('Hist Verde');
subplot(3,3,9);imhist(equ(:,:,2)),title('Hist Azul');


%? Ecualizar por separado cada banda H, S, V.

imghsv=rgb2hsv(imgrgb);
equ2=hsv2rgb(cat(3,histeq(imghsv(:,:,1)),histeq(imghsv(:,:,2)),histeq(imghsv(:,:,3) )));
f=figure(5); set(f,'Name','Imagen Ecualizada HSV');
subplot(3,3,1);imshow(equ2),title('Ecualizada HSV');
subplot(3,3,4);imshow(equ2(:,:,1)),title('Rojo');
subplot(3,3,5);imshow(equ2(:,:,2)),title('Verde');
subplot(3,3,6);imshow(equ2(:,:,2)),title('Azul');
subplot(3,3,7);imhist(equ2(:,:,1)),title('Hist Rojo');
subplot(3,3,8);imhist(equ2(:,:,2)),title('Hist Verde');
subplot(3,3,9);imhist(equ2(:,:,3)),title('Hist Azul');


%¿Cómo podemos conseguir un buen ecualizado para imágenes en
%color? Usa danza.ppm para contestar a esta pregunta.

%[TODO]

imgrgb=imread('danza.ppm');
equ=cat(3,histeq(imgrgb(:,:,1)),histeq(imgrgb(:,:,2)),histeq(imgrgb(:,:,3)));

f=figure(2); set(f,'Name','Imagen Ecualizada');
subplot(3,3,1);imshow(equ),title('Ecualizada');
subplot(3,3,4);imshow(equ(:,:,1)),title('Rojo');
subplot(3,3,5);imshow(equ(:,:,2)),title('Verde');
subplot(3,3,6);imshow(equ(:,:,2)),title('Azul');
subplot(3,3,7);imhist(equ(:,:,1)),title('Hist Rojo');
subplot(3,3,8);imhist(equ(:,:,2)),title('Hist Verde');
subplot(3,3,9);imhist(equ(:,:,2)),title('Hist Azul');
