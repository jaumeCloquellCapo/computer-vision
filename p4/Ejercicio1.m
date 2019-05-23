%Compara el resultado que producen el filtrado gaussiano y el filtro de mediana sobre las
%imágenes disney_r1.png ... disney_r5.png.
I1=imread('disney_r1.png');
I2=imread('disney_r2.png');
I3=imread('disney_r3.png');
I4=imread('disney_r4.png');
I5=imread('disney_r5.png');
I1Gaussiano= imnoise(I1,'gaussian',0,0.5); %ruido gaussiano con media 0 y varianza 0.5
I1mediana=medfilt2(I1,[10 10]);

I2Gaussiano= imnoise(I2,'gaussian',0,0.5); %ruido gaussiano con media 0 y varianza 0.5
I2mediana=medfilt2(I2,[10 10]);

I3Gaussiano= imnoise(I3,'gaussian',0,0.5); %ruido gaussiano con media 0 y varianza 0.5
I3mediana=medfilt2(I3,[10 10]);

I4Gaussiano= imnoise(I4,'gaussian',0,0.5); %ruido gaussiano con media 0 y varianza 0.5
I4mediana=medfilt2(I4,[10 10]);

I5Gaussiano= imnoise(I5,'gaussian',0,0.5); %ruido gaussiano con media 0 y varianza 0.5
I5mediana=medfilt2(I5,[10 10]);

figure,
subplot(5,2,1),imshow(I1Gaussiano),title('disney r1 Gaussiano');
subplot(5,2,2),imshow(I1mediana),title('disney r1 mediana');

subplot(5,2,3),imshow(I2Gaussiano),title('disney r2 Gaussiano');
subplot(5,2,4),imshow(I2mediana),title('disney r2 mediana');

subplot(5,2,5),imshow(I3Gaussiano),title('disney r3 Gaussiano');
subplot(5,2,6),imshow(I3mediana),title('disney r3 mediana');

subplot(5,2,7),imshow(I4Gaussiano),title('disney r4 Gaussiano');
subplot(5,2,8),imshow(I4mediana),title('disney r4 mediana');

subplot(5,2,9),imshow(I5Gaussiano),title('disney r5 Gaussiano');
subplot(5,2,10),imshow(I5mediana),title('disney r5 mediana');

