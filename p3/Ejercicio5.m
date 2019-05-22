% Aplica distintas técnicas de mejora de contraste sobre la imagen
% siguiente y compara los resultados:

imgrgb=imread('paisaje.jpg');
imghsv=rgb2hsv(imgrgb);
equ3=hsv2rgb(cat(3,(imghsv(:,:,1)),imghsv(:,:,2),histeq(imghsv(:,:,3) )));
f=figure(6); set(f,'Name','Imagen Ecualizada HSV solo V');
subplot(4,3,1);imshow(equ3),title('Ecualizada HSV solo V');
subplot(4,3,2);imshow(imgrgb),title('Original');
subplot(4,3,4);imshow(equ3(:,:,1)),title('Rojo');
subplot(4,3,5);imshow(equ3(:,:,2)),title('Verde');
subplot(4,3,6);imshow(equ3(:,:,2)),title('Azul');
subplot(4,3,7);imhist(equ3(:,:,1)),title('Hist Rojo');
subplot(4,3,8);imhist(equ3(:,:,2)),title('Hist Verde');
subplot(4,3,9);imhist(equ3(:,:,3)),title('Hist Azul');
subplot(4,3,10);imhist(imgrgb(:,:,1)),title('Hist Rojo Original');
subplot(4,3,11);imhist(imgrgb(:,:,2)),title('Hist Verde Original');
subplot(4,3,12);imhist(imgrgb(:,:,3)),title('Hist Azul Original');

%La imagen que mostramos a continuación, resulta de aplicar el proceso de ecualización a la imagen
%de la figura. Puede observarse la ampliación del rango dinámico en el histograma, así como el
%aumento del contraste visual en la imagen. 
