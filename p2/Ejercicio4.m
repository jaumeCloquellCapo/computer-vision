%recordar que hsv el verde es h=0.3333 s=1 v=1 luego 0.5- 0.333= 0.1887
%entonces mod(hsv(:,:,1)+0.1887,1.0) será 0.5 cuanto más proximo estés al
%verde luego 1-2*abs(aux-0.5) será 1 cuando estemos tratando el verde.
%llamar a la funcion chroma key con 

F=imread('chromakey_original.jpg');
B=imread('praga1.jpg');

 scene = B;
 obj = F;
 gs = [0 255 0];
 x = 15;
 y =15;

 [srows scols spg] = size(scene);
 [orows ocols opg] = size(obj);
 
 % generamos una matrix de zeros del tamaño del background
 pg = zeros(srows,scols,'uint8');

 % lo ponemos del mismo color que el fondo de la mujer
 canv = cat(3,pg+gs(1),pg+gs(2),pg+gs(3));
 %imshow(canv);
 
 % ponemos la imagen de la mujer en la posicion definida dentro de la
 % matriz de zeros
 canv(1+y : orows+y, 1+x : ocols+x, :) = obj;
 

Rx=canv(:,:,1); %figure, imhist(Rx)
Gx=canv(:,:,2); %figure, imhist(Gx)
Bx=canv(:,:,3); %figure, imhist(Bx)

%mask=findColor(x, 1.1); %Mascara mask=uint8(mask);
tolerance = 1.1;
[M,N,t] = size(canv);
I1 = zeros(M,N); 
I2 = zeros(M,N);
I1( find(canv(:,:,2) > tolerance * canv(:,:,1)) ) = 1; 
I2( find(canv(:,:,2) > tolerance * canv(:,:,3)) ) = 1; 
%strTitle = 'Color GREEN detected (white areas)'; 
mask = I1 .* I2;
mask=uint8(mask);

maski=not(mask); %Mascara Inversa 
maski=uint8(maski);

% Objeto del Foreground a Color
ckf1=(Rx.*(maski)); %Se multiplica la mascara inversa por el Foreground object
ckf2=(Gx.*(maski));
ckf3=(Bx.*(maski));
%
[n1 n2 n3 n4]=size(canv);
%Se agrega el color y se tranforma en matriz 3D 
ckf=zeros(n1,n2,n3);
ckf(:,:,1)=uint8(ckf1); 
ckf(:,:,2)=uint8(ckf2); 
ckf(:,:,3)=uint8(ckf3); 
ckf=uint8(ckf);
imshow(ckf);

canv = ckf;
 
%imshow(canv);
 
 % generamos una secencia de indices de ellementos del canvas cuyo valores
 % sean distintos de 0 (negro RGB (0 0 0))
 ind1 = find(canv(:,:,1) ~= 0);
 ind2 = find(canv(:,:,2) ~= 0);
 ind3 = find(canv(:,:,3) ~= 0);
 
 %ponemos la mujer en la escena
 canv1 = canv(:,:,1);
 canv2 = canv(:,:,2);
 canv3 = canv(:,:,3);
 
 scene1 = scene(:,:,1);
 scene2 = scene(:,:,2);
 scene3 = scene(:,:,3);

 scene1(ind1) = canv1(ind1);
 scene2(ind2) = canv2(ind2);
 scene3(ind3) = canv3(ind3);

 compImage = cat(3,scene1,scene2,scene3);
 imshow(compImage);