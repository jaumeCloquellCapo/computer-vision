%1. Cargar la imagen mujer.jpg y realiza las siguientes operaciones:
%? Mejora el contraste usando únicamente operaciones
%aritméticas (+, -, *, /).

I=imread('mujer.jpg');
%Esta operación aumenta el brillo de manera uniforme. El efecto sobre el histograma es que lo
%desplaza hacia la derecha. Posiblemente muchos píxeles serán saturados al máximo valor.
Isuma=I+100;
Iresta=I-100;
Ipro=I*1.5;
Idiv=I/2;

figure
subplot(3,2,1),subimage(Isuma),title('Suma');
subplot(3,2,2),subimage(Iresta),title('Resta');
subplot(3,2,3),subimage(Ipro),title('Producto');
subplot(3,2,4),subimage(Idiv),title('Division');
subplot(3,2,1),subimage(I),title('Original');

%? Usa imadjust para mejorar el contraste. Usa la función
%stretchlim.

J1=imadjust(I,stretchlim(I),[]);
figure,subplot(1,2,1),imshow(I),subplot(1,2,2),imshow(J1);

%? Usa imadjust para aplicar una función de transferencia de tipo
%gamma. Comprueba el efecto que produce la transformación
%en la imagen y en el histograma.

J2 = imadjust(I,[0.3 0.7],[]);
figure,subplot(1,2,1),imshow(I),subplot(1,2,2),imshow(J2);

%? Usa imadjust para aplicar la siguiente función de transferencia:
%Finalmente, ecualiza la imagen.

ratio = 100/255;
J3 = imadjust(I, [ratio 255/255], [0 1- ratio], 1);
Ieq=histeq(J3);
figure,subplot(1,2,1),imshow(I),subplot(1,2,2),imshow(J3);

