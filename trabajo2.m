castillo_orig = imread('castillo.pgm');
castillo_vac = imread('Castillo_oculto2bits.pgm');

mask = 1;
vacas_bw = bitand(castillo_vac,mask);

mask = 3;
vacas_gray = bitand(castillo_vac,mask);
vacas_gray = double(vacas_gray);
vacas_gray = (vacas_gray - min(min(vacas_gray))) / (max(max(vacas_gray)) - min(min(vacas_gray)));

castillo_vac_bw = bitshift(castillo_orig,-1);
castillo_vac_bw = bitshift(castillo_vac_bw,1);
castillo_vac_bw = castillo_vac_bw + vacas_bw;

figure,subplot(1,4,1),imshow(castillo_vac), title('Original encriptado');
subplot(1,4,2),imshow(double(vacas_bw)), title('?ltimo bit');
subplot(1,4,3),imshow(vacas_gray), title('?ltimos dos bits');
subplot(1,4,4),imshow(castillo_vac_bw), title('Imagen encriptada');