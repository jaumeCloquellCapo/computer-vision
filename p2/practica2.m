%MODELO HSV: H tono==color. [0,1] S: pureza del color. [0,1] 0 el color mas
%blanco. V: brillo [0,1]. Intensidad del conlor. 0 es negro 1: intensidad
%del color es mas fuerte.


%ver el rojo en el hsv
A=zeros(128,128,3); %crea una imagen con tres bandas double
A(:,:,1)=1;
figure, imshow(A),title('Roja');

h=rgb2hsv(A);
h(1,1,:) 
%rojo en hsv es h=0 s=1 v = 1
%cambiamos la saturacion para ver los distintos valores

clear peli1
k=1;
for v=0:0.01:1
      h(:,:,2)=v;
      peli1(k)=im2frame(hsv2rgb(h));
      k=k+1;
end

mplay(peli1)
%cambiando brillo
clear peli2
h(:,:,2)=1;
k=1
for v=0:0.01:1
     h(:,:,3)=v;
     
     peli2(k)=im2frame(hsv2rgb(h));
     k=k+1;
end
        
figure,subplot(1,2,1),movie(peli1),title('Saturacion'),subplot(1,2,2),movie(peli2),title('Luminancia');
%movie2avi(peli1,'satu.avi');
%movie2avi(peli2,'lum.avi');
%_____________________________
%ver el verde h=0.3333 s=1 v=1
A=imread('chromakey_original.jpg');
%A(:,:,2)=1; %Lo construyes en el rgb y ahora lo pasas a hsv
h=rgb2hsv(A);
h(1,1,:)

clear peli1
k=1;
for v=0:0.01:1
      h(:,:,2)=v;
      peli1(k)=im2frame(hsv2rgb(h));
      k=k+1;
end

clear peli2
k=1
for v=0:0.01:1
     h(:,:,3)=v;
     peli2(k)=im2frame(hsv2rgb(h));
     k=k+1;
end
        
figure,subplot(1,2,1),movie(peli1),title('Saturacion'),subplot(1,2,2),movie(peli2),title('Luminancia');

%_____________________________
%ver el azul h=0.6667 s=1 v=1
A=zeros(128,128,3);
A(:,:,3)=1;
h=rgb2hsv(A);
h(1,1,:)

clear peli1
k=1;
for v=0:0.01:1
      h(:,:,2)=v;
      peli1(k)=im2frame(hsv2rgb(h));
      k=k+1;
end

clear peli2
k=1
for v=0:0.01:1
     h(:,:,3)=v;
     peli2(k)=im2frame(hsv2rgb(h));
     k=k+1;
end
        
figure,subplot(1,2,1),movie(peli1),title('Saturacion'),subplot(1,2,2),movie(peli2),title('Luminancia');
%%%VER LOS PUNTOS verdes DE rosa2.jpg h=0.3333 s=1 v =1
I=imread('rosa2.jpg');

imHSV=rgb2hsv(I);
A=0.5-0.3333;
aux=mod(imHSV(:,:,1)+A,1.0); 
azul = 1-2*abs(aux-0.5);
imHSV(:,:,1)=azul;
imHSV(:,:,2)=1;
imHSV(:,:,3)=1;
nueva=hsv2rgb(imHSV);
figure,imshow(I),title('rosa');
figure,imshow(nueva),title('Verdes')
%_________________________________
%Otros modelos de color
%YIQ: Y luminancia I:fase Q: cuadratura. Se utiliza para el sistema de
%televisión NTSC
I=imread('Warhol_Marilyn_1967_OnBlueGround.jpg');
imYIQ=rgb2ntsc(im2double(I));

figure, subplot(1,4,1),imagesc(imYIQ(:,:,1));
subplot(1,4,2),imagesc(imYIQ(:,:,2));
subplot(1,4,3),imagesc(imYIQ(:,:,3));

Irec=im2uint8(ntsc2rgb(imYIQ));
figure,imagesc(Irec);

%---------------------------
%Modelo Ycbcr: Parecido al modelo YUV se utiliza en los estandares MPEG-2 y
%JPEG2. Y: luminancia y Cb y Cr son las componetes cromáticas

imYCbCr=rgb2ycbcr(I);
figure, subplot(1,4,1),imagesc(imYCbCr(:,:,1));
subplot(1,4,2),imagesc(imYCbCr(:,:,2));
subplot(1,4,3),imagesc(imYCbCr(:,:,3));

Irec=im2uint8(ycbcr2rgb(imYCbCr));
figure,imagesc(Irec);

%---------------------------
%Modelo Lab. Es independiente del dispositivo. La distancia euclidea entre
%dos colores está altamente correlada con la diferencia perceptual que
%perciben dos humanos.
%L componente de luminancia. a y b componentes cromáticas. a: define la
%posición entre el verde y el rojo y b:la posicion entre el azul y amarillo
ff= makecform('srgb2lab');
result=applycform(I,ff);

figure, subplot(1,4,1),imagesc(result(:,:,1));
subplot(1,4,2),imagesc(result(:,:,2));
subplot(1,4,3),imagesc(result(:,:,3));


ff= makecform('lab2srgb');
Irec= applycform(result,ff);

figure,imagesc(Irec);

%_________________________________
%IMAGEN ROSA rosa2.jpg
%Mostrar el histograma de la rosa.
%El histograma se aplica sobre imagenes monobanda
%el histograma imhist(x): muestra el histograma de una imagen imagen.
%imhist(x,N) solamente usa N bins para mostrar el histograma [counts,
%X]=imhist(x) da el numero de ocurrencias por los binx X. stem(X,counts)
%muestra el histograma
I=imread('rosa2.jpg');

figure,subplot(1,4,1),imshow(I);
subplot(1,4,2),imhist(I(:,:,1)),title('Roja');
subplot(1,4,3),imhist(I(:,:,2)),title('Verde');
subplot(1,4,4),imhist(I(:,:,3)),title('Azul');
   
%comentario: al ver el histograma de color vemos un pico en el color azul
%pero no se va nada de ese color. ¿?

%ponemos cion a 1 el brillo tambien a 1 y veremos que en el fondo
%gris en realidad es azul con poca saturación.

h= rgb2hsv(I);
h(:,:,2)=1;
h(:,:,3)=1;
Inueva=hsv2rgb(h);

figure,subplot(1,4,1),imshow(Inueva);
subplot(1,4,2),imhist(Inueva(:,:,1)),title('Roja');
subplot(1,4,3),imhist(Inueva(:,:,2)),title('Verde');
subplot(1,4,4),imhist(Inueva(:,:,3)),title('Azul');


%Sobre la imagen alhambra vemos sus histogramas. Generalmente cuando una
%imagen esta bien constratada suele usar, mas o menos todos los niveles de
%gris por igual. 
I=imread('alhambra.jpg');
Igray=rgb2gray(I);
subplot(3,3,1),subimage(I),title('Original');
subplot(3,3,2),subimage(Igray),title('Niveles de gris');
subplot(3,3,3),imhist(Igray),title('Histgrama N.G');
subplot(3,3,4),subimage(I(:,:,1)),title('Rojo');
subplot(3,3,5),subimage(I(:,:,2)),title('Verde');
subplot(3,3,6),subimage(I(:,:,3)),title('Azul');
subplot(3,3,7),imhist(I(:,:,1)),title('Histgrama Rojo');
subplot(3,3,8),imhist(I(:,:,2)),title('Histgrama Verde');
subplot(3,3,9),imhist(I(:,:,3)),title('Histgrama Azul');

%_____________________________________________
%Si queremos mostrar un único histograma para una imagen de color debemos
%pasarla a niveles de gris con rgb2gray
Igray=rgb2gray(I);
figure,imhist(Igray);


%vemos los histogramas asociados al color saturacion y brillo.

I=imread('rosa2.jpg');
imhsv = rgb2hsv(I);
im1= imhsv(:,:,1);
im2= imhsv(:,:,2);
im3= imhsv(:,:,3);

mapahsv=hsv(256);
figure;
subplot(1,4,1), subimage(I),title('Imagen');
subplot(1,4,2),imhist(im2uint8(im1),mapahsv), title('Color');
subplot(1,4,3),imhist(im2uint8(im2)), title('Saturacion');
subplot(1,4,4),imhist(im2uint8(im3)), title('Brillo');


%_____________________________________________
%Ciclamos los colores de la imagen rosa2.jpg

I=imread('rosa2.jpg');
clear peli;
y=rgb2hsv((I));
z=y;
for i=1:255
    disp(i)
    z(:,:,1)=mod(y(:,:,1)+i/255.0,0.99);
    peli(i)=im2frame((hsv2rgb(z)));
end
movie(peli);

%_____________________________________________
%Chroma key.

%recordar que hsv el verde es h=0.3333 s=1 v=1 luego 0.5- 0.333= 0.1887
%entonces mod(hsv(:,:,1)+0.1887,1.0) será 0.5 cuanto más proximo estés al
%verde luego 1-2*abs(aux-0.5) será 1 cuando estemos tratando el verde.
%llamar a la funcion chroma key con 
F=imread('chromakey_original.jpg');
B=imread('praga1.jpg');




%Implementar vosotros la funcion chroma_key2 
 %Parametros
 % F=imagen de frente
 % B=imagen de fondo
 % columna donde empezar a poner F en B
 % fila donde empezar a poner F en B
 % color del chroma (en el ejemplo verde).
ch=chroma_key2(F,B,size(B,2)-size(F,2),size(B,1)-size(F,2),0,255,0);
imshow(ch)



