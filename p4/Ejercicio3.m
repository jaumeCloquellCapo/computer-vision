%Utiliza la correlación para buscar formas en una imagen. Para este ejercicio puedes usar
%las siguientes imágenes:

%? formas.png, estrella.png, ovalo.png, cuadrado.png, cuadrado2.png,
%cuadrado3.png
%? texto.png, letra_i.png, letra_k.png, letra_m.png, letra_o.png, letra_p.png

I1=imread('formas.png');
I2=imread('estrella.png');
I3=imread('ovalo.png');

I4=imread('cuadrado.png');
I5=imread('cuadrado2.png');
I6=imread('cuadrado3.png');

I7=imread('texto.png');
I8=imread('letra_i.png');
I9=imread('letra_k.png');

I10=imread('letra_m.png');
I11=imread('letra_o.png');
I12=imread('letra_p.png');


figure,
subplot(4,3,1),imshow(I1),title('I1');
subplot(4,3,2),imshow(I2),title('I2');
subplot(4,3,3),imshow(I3),title('I3');

subplot(4,3,4),imshow(I4),title('I4');
subplot(4,3,5),imshow(I5),title('I5');
subplot(4,3,6),imshow(I6),title('I6');

subplot(4,3,7),imshow(I7),title('I7');
subplot(4,3,8),imshow(I8),title('I8');
subplot(4,3,9),imshow(I9),title('I19');

subplot(4,3,10),imshow(I10),title('I10');
subplot(4,3,11),imshow(I11),title('I11');
subplot(4,3,12),imshow(I12),title('I12');


darkCar = I1;

darkCarValue = 50;
noDarkCar = imextendedmax(darkCar, darkCarValue);

imshow(darkCar)
figure, imshow(noDarkCar)