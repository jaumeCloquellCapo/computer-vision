% Leemos la imagen
castillo_orig = imread('castillo.pgm');
castillo_vac = imread('Castillo_oculto2bits.pgm');

% desencriptar
A = castillo_vac;
figure, subplot(2,2,1);imshow(castillo_vac);title('castillo con imagen oculta');
B=bitget(A,1); subplot(2,2,2);imshow(logical(B));title('Primer imagen '); %obtenos el primer bit
B=bitget(A,2); subplot(2,2,3);imshow(logical(B));title('Segunda imagen'); %obtenos el segundo bit
% encriptar
B = bitshift(castillo_orig,-1);
B = bitshift(B,1);
B = B + bitand(castillo_vac,1);
subplot(2,2,4);imshow(B);title('Imagen encriptada');

