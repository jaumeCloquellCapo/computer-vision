%Compara el resultado que producen el filtrado gaussiano y el filtro de mediana sobre las
%imágenes disney_r1.png ... disney_r5.png.

I1=imread('disney_r1.png');
I2=imread('disney_r2.png');
I3=imread('disney_r3.png');
I4=imread('disney_r4.png');
I5=imread('disney_r5.png');

fg=fspecial('gaussian',10,1.5);

I1Gaussiano= imfilter(I1,fg);
I1mediana=medfilt2(I1,[10 10]);

I2Gaussiano= imfilter(I2,fg); 
I2mediana=medfilt2(I2,[10 10]);

I3Gaussiano= imfilter(I3,fg);
I3mediana=medfilt2(I3,[10 10]);

I4Gaussiano= imfilter(I4,fg); 
I4mediana=medfilt2(I4,[10 10]);

I5Gaussiano= imfilter(I5,fg); %ruido gaussiano con media 0 y varianza 0.5
I5mediana=medfilt2(I5,[10 10]);

figure,
subplot(3,5,1),imshow(I1),title('r1');
subplot(3,5,2),imshow(I1Gaussiano),title('r1 Gaussiano');
subplot(3,5,3),imshow(I1mediana),title('r1 mediana');

subplot(3,5,4),imshow(I2),title('r2');
subplot(3,5,5),imshow(I2Gaussiano),title('r2 Gaussiano');
subplot(3,5,6),imshow(I2mediana),title('r2 mediana');

subplot(3,5,7),imshow(I3),title('r3');
subplot(3,5,8),imshow(I3Gaussiano),title('disney r3 Gaussiano');
subplot(3,5,9),imshow(I3mediana),title('disney r3 mediana');

subplot(3,5,10),imshow(I4),title('r4');
subplot(3,5,11),imshow(I4Gaussiano),title('r4 Gaussiano');
subplot(3,5,12),imshow(I4mediana),title('r4 mediana');

subplot(3,5,13),imshow(I5),title('r5');
subplot(3,5,14),imshow(I5Gaussiano),title('disney r5 Gaussiano');
subplot(3,5,15),imshow(I5mediana),title('disney r5 mediana');

%Puede apreciarse cómo el filtro gaussiano elimina el ruido mejor y además emborrona menos los
%bordes en las imagenes 4 y 5. Respecto al resto de imagenes el filtro por
%media tiene un mejor comportamiento, eliminando casi en su totalidad todo
%el ruido de la imagen