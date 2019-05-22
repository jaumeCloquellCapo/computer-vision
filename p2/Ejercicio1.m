%Cargar una imagen RGB y convertirla a HSV. Para ello implementa una función que
%reciba como entrada la imagen en formato RGB y que muestre una ventana con la
%imagen y los histogramas de sus tres componentes HSV.

I=imread('Warhol_Marilyn_1967_OnBlueGround.jpg');

imhsv = rgb2hsv(I);
im1= imhsv(:,:,1);
im2= imhsv(:,:,2);
im3= imhsv(:,:,3);

mapahsv=hsv(256);
%Hue : the color type (such as red, blue, or yellow).
%Ranges from 0 to 360° in most applications. (each value corresponds to one color : 0 is red, 45 is a shade of orange and 55 is a shade of yellow).
figure;
subplot(2,2,1), imshow(I),title('Imagen');
subplot(2,2,2),imhist(im2uint8(im1),mapahsv), title('Color');
subplot(2,2,3),imhist(im2uint8(im2)), title('Saturacion');
subplot(2,2,4),imhist(im2uint8(im3)), title('Brillo');


%Para la componente de Color, muestra en la barra inferior el color con que se
%corresponde cada valor mostrado (usa el parámetro map de la función imhist y la
%función hsv para obtener el mapa de color de este modelo).
%