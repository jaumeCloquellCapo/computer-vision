% Coge una imagen en color y utiliza imadjust o histeq para mejorar
el contraste. Considera estas posibilidades:

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

%Cada imagen tiene su propio histograma. Pero como regla general se considera que
%una imagen tiene un buen contraste si su histograma se extiende ocupando casi todo
%el rango de tonos, como ocurre con en la imagen:

imgrgb=imread('danza.ppm');
equ=cat(3,histeq(imgrgb(:,:,1)),histeq(imgrgb(:,:,2)),histeq(imgrgb(:,:,3)));
Igray=rgb2gray(imgrgb);
Igray2=rgb2gray(equ);
f=figure(2); set(f,'Name','Imagen Ecualizada');
subplot(4,3,1);imshow(equ),title('Ecualizada');
subplot(4,3,4);imshow(equ(:,:,1)),title('Rojo');
subplot(4,3,5);imshow(equ(:,:,2)),title('Verde');
subplot(4,3,6);imshow(equ(:,:,2)),title('Azul');
subplot(4,3,7);imhist(equ(:,:,1)),title('Hist Rojo');
subplot(4,3,8);imhist(equ(:,:,2)),title('Hist Verde');
subplot(4,3,9);imhist(equ(:,:,2)),title('Hist Azul');
subplot(4,3,10);imshow(imgrgb),title('Imagen original');
subplot(4,3,11);imhist(Igray),title('Hist gris normal');
subplot(4,3,12);imhist(Igray2),title('Hist gris Ecualizada');

%Si se entiende por contraste la diferencia de brillo entre las zonas
%más claras y más oscuras en una imagen, la imagen original es un ejemplo de bajo contraste. No hay nada completamente oscuro ni
%tampoco muy claro. Esto se traduce en un histograma estrecho. Además, como la
%tónica dominante son los grises medios, se observa que está bastante
%centrado. Frente a escenas con una iluminación más normal, los histogramas deberían ser del
%tipo amplio como la figura Hist gris Ecu. Si no es así, un histograma desplazado a la izquierda puede
%denotar falta de exposición, y exceso de ella si lo está hacia la derecha
