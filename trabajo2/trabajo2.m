castillo = imread('castillo.pgm');
Castillo_oculto2bits = imread('Castillo_oculto2bits.pgm');

% realizamos una operación AND para de una forma sencilla, permite comparar
% los bits que le indiquemos. Si comparten ponemos una mascara de 1 por
% ejemplo, este en 8 bits vendría representado por 1 0 0 0 0 0 0 0 .
% Entonces en este caso si comparten 1 en la misma posición que la imagen
% el resultado es 1 en caso contrrio 0. De esta forma obtememos el bit
% menos significativo duna forma rápida y sencilla.

% 1 => 1 0 0 0 0 0 0 0 en 8 bits
vacas_2 = bitand(Castillo_oculto2bits,1);

% 3 => 0 1 0 0 0 0 0 0 en 8 bits
vacas_3 = bitand(Castillo_oculto2bits,3);
vacas_3 = double(vacas_3);
vacas_3 = (vacas_3 - min(min(vacas_3))) / (max(max(vacas_3)) - min(min(vacas_3)));


figure,subplot(1,4,1),imshow(Castillo_oculto2bits), title('Original');
subplot(1,4,2),imshow(double(vacas_2)), title('Vaca 2 bits');
subplot(1,4,3),imshow(vacas_3), title('Vaca 3 bits');


% Para recuperar la original encriptada desplazamos el bit más
% significativo y luego desplazamos todo a la izquierda para restar 1 a la
% imagen y sumamos los niveles de gris 
B = bitshift(castillo,-1);
B = bitshift(B,1);
B = B + bitand(Castillo_oculto2bits,1);
subplot(1,4,4),imshow(B), title('Imagen encriptada');
