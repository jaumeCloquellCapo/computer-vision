%1. Cargar la imagen mujer.jpg y realiza las siguientes operaciones:
%? Mejora el contraste usando �nicamente operaciones
%aritm�ticas (+, -, *, /).

I=imread('mujer.jpg');
%Esta operaci�n aumenta el brillo de manera uniforme. El efecto sobre el histograma es que lo
%desplaza hacia la derecha. Posiblemente muchos p�xeles ser�n saturados al m�ximo valor.
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

%? Usa imadjust para mejorar el contraste. Usa la funci�n
%stretchlim.

J1=imadjust(I,stretchlim(I),[]);
figure,subplot(1,2,1),imshow(I),subplot(1,2,2),imshow(J1);

%? Usa imadjust para aplicar una funci�n de transferencia de tipo
%gamma. Comprueba el efecto que produce la transformaci�n
%en la imagen y en el histograma.

% imadjust(I,[low_in high_in],[low_out high_out],gamma)
J2 = imadjust(I,[],[],0.5);
figure,subplot(1,2,1),imshow(I),subplot(1,2,2),imshow(J2);

%? Usa imadjust para aplicar la siguiente funci�n de transferencia:
%Finalmente, ecualiza la imagen.

J3 = imadjust(I, [100/255 255/255], [0 255/255], 1);
Ieq=histeq(J3);
figure,subplot(1,2,1),imshow(I),subplot(1,2,2),imshow(J3);

