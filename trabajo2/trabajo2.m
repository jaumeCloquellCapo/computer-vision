%% Recuperaci�n de la imagen - primera opci�n A
%Para recuperar la imagen de las vacas tenemos que realizar un procedimiento a nivel de bit que consiste en los siguientes pasos:
%Desplazar todos los bits a la izquierda 6 posiciones, nos da como resultado la imagen de las vacas con tres tonos de grises.
%Desplazar todos los bits a la izquierda 7 posiciones, nos da como resultado la imagen de las vacas con dos tonos de grises.

%Cargar las im�genes, original y encriptada.
Original = imread('castillo.pgm');
Cover = imread('Castillo_oculto2bits.pgm');

% Mover los bits de la imagen 6 posiciones a la derecha:
threegreyscale = bitshift(Cover,6); %imagen de tres escalas de grises
%Si miramos los pixeles del fondo en el inspector nos muestra que esos p�xeles tiene el valor 64 y buscamos que este nivel tenga el valor 128, por lo que multiplicamos por 2 cada uno de los p�xeles.
threegreyscale = 2.*threegreyscale;

% Para la obtenci�n de la imagen con dos niveles de gris realizamos el mismo proceso pero en lugar de desplazar los bits 6 posiciones los movemos 7.
twogreyscale = bitshift(Cover,7); %imagen de dos escalas de grises
% Como pasaba la imagen inicial da un resultado parecido al deseado, pero m�s oscuro, Por lo que se necesitaba multiplicar por dos para corregir el nivel de gris al deseado.
twogreyscale = 2.*twogreyscale;

%figure, subplot(1,2,1),imshow(threegreyscale),subplot(1,2,2),imshow(twogreyscale);

%% Recuperaci�n de la imagen - segunda opci�n B

% realizamos una operaci�n AND para de una forma sencilla, permite comparar
% los bits que le indiquemos. Si comparten ponemos una mascara de 1 por
% ejemplo, este en 8 bits vendr�a representado por 1 0 0 0 0 0 0 0 .
% Entonces en este caso si comparten 1 en la misma posici�n que la imagen
% el resultado es 1 en caso contrrio 0. De esta forma obtememos el bit
% menos significativo duna forma r�pida y sencilla.

% 1 => 1 0 0 0 0 0 0 0 en 8 bits
twogreyscaleB = bitand(Cover,1);

% 3 => 0 1 0 0 0 0 0 0 en 8 bits
threegreyscaleB = bitand(Cover,3);
threegreyscaleB = double(threegreyscaleB);
threegreyscaleB = (threegreyscaleB - min(min(threegreyscaleB))) / (max(max(threegreyscaleB)) - min(min(threegreyscaleB)));

%%  Recuperaci�n original encriptada

% Para recuperar la original encriptada desplazamos el bit m�s
% significativo y luego desplazamos todo a la izquierda para restar 1 a la
% imagen y sumamos los niveles de gris 


encripted = bitshift(Original,-1);
encripted = bitshift(encripted,1);
encripted = encripted + bitand(Cover,1);

%%  Visualizaci�n de las imagenes

figure,subplot(2,3,1),imshow(Cover), title('Original');
subplot(2,3,2),imshow(twogreyscale), title('Vaca 2 bits (A)');
subplot(2,3,3),imshow(threegreyscale), title('Vaca 3 bits (A)');
subplot(2,3,4),imshow(double(twogreyscaleB)), title('Vaca 2 bits (B)');
subplot(2,3,5),imshow(threegreyscaleB), title('Vaca 3 bits (b)');
subplot(2,3,6),imshow(encripted), title('Imagen encriptada');

