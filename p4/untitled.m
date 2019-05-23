%Filtrado Espacial
%En cada punto de la imagen se transforma el valor del pixel de acuerdo
%al valor propio del del pixel y probablemente dependiendo de su entorno.
%Cuando la operacion que hacemos con los vecinos es una tr. lineal 
%entonces hablamos de filtrado lineal espacil-->Correlacion y convolu
%x = imfilter(img,filtro)-->correlacion
%x=imfilter(img,filtro,'conv')-->convolucion

%Problema con los bordes mostrar transparencia.
%imfilter(img,filtro,V); -->(por defecto con v=0)Se asume que fuera toma los pixeles valor V
%imfilter(img,filtro,'symmetric')->se considera que la imagen es simetrica
%en cualquiera de sus extremos
%imfilter(img,filtro,'replicate')->los puntos inexistentes toma el valor
%mas cercano
%imfilter(img,filtro,'circular')->se considera que la imagen se repite de
%forma peri?dica.


%Ejemplo de filtro media aplicado con diferentes formas de tratar los
%l?mites
filtro= fspecial('average',7);
I=imread('peppers.png');
Octe_0=imfilter(I,filtro,0);
Octe_128=imfilter(I,filtro,128);
Ocircular=imfilter(I,filtro,'circular');
Osymetric=imfilter(I,filtro,'symmetric');
Oreplicate=imfilter(I,filtro,'replicate');
figure,subplot(2,3,1),imshow(I),subplot(2,3,2),imshow(Octe_0),title('Borde 0');
subplot(2,3,3),imshow(Octe_128),title('Borde 128'),subplot(2,3,4),imshow(Ocircular),title('Borde Circular');
subplot(2,3,5),imshow(Osymetric),title('Borde Simetrico'),subplot(2,3,6),imshow(Oreplicate),title('Borde Replicando');
imtool(Octe_128)
imtool(Osymetric)
%Probando con diferentes tama?os de la mascara
filtro =fspecial('average',[7 21]);
Osymetric=imfilter(I,filtro,'symmetric');
figure,imshow(Osymetric);

%disk crea un entorno circular para calcular la media del entorno del
%pixel.Necesita el radio del circulo
fdisk=fspecial('disk',5);
O=imfilter(I,fdisk,'symmetric');
figure,imshow(O)

%gaussian: como parametros lleva el tama?o del filtro ( un numero si es
%cuadrado 2 si es rectangular) y la desviacion estandar. Por defecto estos
%valores son 3x3 y stddev=0.5
I=imread('cameraman.tif');
fgauss=fspecial('gaussian',[15 15], 10);

figure,mesh(fgauss)
figure,surface(fgauss) %usar tool para rotate 3d

%hacer un plot 2d de fgauss
fg_2d=fgauss(uint8(size(fgauss,1)/2),:);
plot([1:size(fgauss,2)],fg_2d);

Ogauss=imfilter(I,fgauss);
imshow(Ogauss)


%Filtro Mediana:
close all;
Imediana=medfilt2(I,[10 10]); %mediana con entorno 10 10
%imshow(Imediana);
imtool(Imediana);
imtool(I);
%Con imagenes de color
I=imread('cara2_ruido.jpg');
figure,imshow(I);
Imediana=cat(3,medfilt2(I(:,:,1),[5 5]),medfilt2(I(:,:,2),[5 5]),medfilt2(I(:,:,3),[5 5])); %mediana con entorno 5 5
figure,imshow(Imediana);


%hacer un comparativa con los distintos filtros 


%Ruido J = IMNOISE(I,TYPE,...) Add noise of a given TYPE to the intensity image
%     I. TYPE is a string that can have one of these values:
%  
%         'gaussian'       Gaussian white noise with constant
%                          mean and variance
%  
%         'localvar'       Zero-mean Gaussian white noise 
%                          with an intensity-dependent variance
%  
%         'poisson'        Poisson noise
%  
%         'salt & pepper'  "On and Off" pixels
%  
%         'speckle'        Multiplicative noise
close all;
I=imread('disney.png');
J= imnoise(I,'gaussian',0,0.5); %ruido gaussiano con media 0 y varianza 0.5
figure,imshow(J)

 J = imnoise(I,'salt & pepper', 0.02);% where D is the noise density.  This affects approximately
%     D*numel(I) pixels. The default for D is 0.05.
figure,imshow(J)


%Proceso de eliminaci?n de ruido con filtros paso bajo: gaussiana, media,
%mediana
fg=fspecial('gaussian',10,1.5);
R_gauss=imfilter(J,fg);
figure,imshow(R_gauss),title('Gaussian')

fmedia=fspecial('average',[5 5]);
R_media=imfilter(J,fmedia);
figure,imshow(R_media),title('Media')

R_mediana=medfilt2(J,[5 5]);
figure,imshow(R_mediana),title('Mediana');
%______________________________________________________  
   
%Filtros para la detecci?n de bordes
%1.-Basados en el gradiente
  %Sobel solemante direccion horizontal para obtener la vertica debes usar
  %edge
  close all;
  s_h=fspecial('sobel') % matriz 3x3
  I=imread('rascacielos.bmp');
  I_h=imfilter(I,s_h);
  imshow(I_h);
  
  %Forma de obtener la matriz sobel para obtener la direcci?n vertical
  s_v=s_h';
  I_v=imfilter(I,s_v);
  Magn=sqrt(double(I_h).^2+double(I_v).^2);
  Orienta=atan2(double(I_v),double(I_h));
  figure,subplot(2,3,1),imshow(I),subplot(2,3,2),imshow(I_h);
  subplot(2,3,3),imshow(I_v),subplot(2,3,4),imagesc(Magn),subplot(2,3,5),imagesc(Orienta);
  figure, imshow(Magn,[])
  figure,colormap(gray(256)),imagesc(Magn)
  
  %Prewitt
  p_h=fspecial('prewitt');
  p_v=p_h';
  I_h=imfilter(I,p_h);
  I_v=imfilter(I,p_v);
  figure,imshow(I_h);
  figure,imshow(I_v);
  
 %%
 %Aristas imagen de color
 close all; clear all;
 I=imread('cara2_ruido.jpg');
 s_h=fspecial('sobel') % matriz 3x3
 s_v=s_h';
 R_h(:,:,1)= imfilter(I(:,:,1),s_h);
 R_h(:,:,2)= imfilter(I(:,:,2),s_h);
 R_h(:,:,3)= imfilter(I(:,:,3),s_h);
 
 R_v(:,:,1)= imfilter(I(:,:,1),s_v);
 R_v(:,:,2)= imfilter(I(:,:,2),s_v);
 R_v(:,:,3)= imfilter(I(:,:,3),s_v);
 
 Magn(:,:,1)=sqrt(double(R_h(:,:,1)).^2+double(R_v(:,:,1)).^2);
 Orienta(:,:,1)=atan2(double(R_v(:,:,1)),double(R_h(:,:,1)));
 Magn(:,:,2)=sqrt(double(R_h(:,:,2)).^2+double(R_v(:,:,2)).^2);
 Orienta(:,:,2)=atan2(double(R_v(:,:,2)),double(R_h(:,:,2)));
 Magn(:,:,3)=sqrt(double(R_h(:,:,3)).^2+double(R_v(:,:,3)).^2);
 Orienta(:,:,3)=atan2(double(R_v(:,:,3)),double(R_h(:,:,3)));
 figure,subplot(2,3,1),imshow(I),subplot(2,3,2),imshow(R_h);
  subplot(2,3,3),imshow(R_v),subplot(2,3,4),imshow(Magn,[]),subplot(2,3,5),imshow(Orienta,[]);
 
 
%______________________________________________________  
     
%2.-Basados en la segunda derivada
 %LOG: Laplaciana de una gaussiana fspecial('log',T,S) T=tama�o y
   %S=sigma. Busca los cruces por cero de la laplaciana
   close all;
   LG=fspecial('log',15,1.5); surf(LG)
   I=imread('rascacielos.bmp');
   Ilg=imfilter(I,LG);
   
   figure,colormap(gray(256)),imagesc(Ilg);
   figure,surface(LG)


   %Laplaciana: Es isotropico fspecial('laplacian',A) con A=[0,1] para
   %establecer la forma de la laplaciana. Devuelve bordes dobles y es m�s
   %sensible al ruido que los basados en el gradiente
   close all;
   I=imread('piramides.bmp');
   Lapla=fspecial('laplacian',0.5) %por defecto A=0.2
   Ilapla=imfilter(I,Lapla);
   figure,imshow(Ilapla);
   figure,imshow(I),title('Original');
   %ver la forma
   figure,surface(Lapla);
   
   
   
  
 %______________________________________________________  
   
 %EDGE:  Devuelve la imagen binaria de fronteras x=edge(img,filtro)
 
 %SOBEL BW = EDGE(I,'sobel') specifies the Sobel method.
 
%     BW = EDGE(I,'sobel',THRESH) specifies the sensitivity threshold for 
%     the Sobel method. EDGE ignores all edges that are not stronger than 
%     THRESH.  If you do not specify THRESH, or if THRESH is empty ([]), 
%     EDGE chooses the value automatically.
%  
%     BW = EDGE(I,'sobel',THRESH,DIRECTION) specifies directionality for the
%     Sobel method. DIRECTION is a string specifying whether to look for
%     'horizontal' or 'vertical' edges, or 'both' (the default).
%  
%     BW = EDGE(I,'sobel',...,OPTIONS) provides an optional string
%     input. String 'nothinning' speeds up the operation of the algorithm by
%     skipping the additional edge thinning stage. By default, or when 
%     'thinning' string is specified, the algorithm applies edge thinning.
%  
%     [BW,thresh] = EDGE(I,'sobel',...) returns the threshold value.
%  
%     [BW,thresh,gv,gh] = EDGE(I,'sobel',...) returns vertical and
%     horizontal edge responses to Sobel gradient operators. You can 
%     also use these expressions to obtain gradient responses:
%     if ~(isa(I,'double') || isa(I,'single')); I = im2single(I); end
%     gh = imfilter(I,fspecial('sobel') /8,'replicate'); and
%     gv = imfilter(I,fspecial('sobel')'/8,'replicate');
   
I=imread('disney.png');
b=edge(I,'sobel');
figure,imshow(b);

bh=edge(I,'sobel','vertical');
figure,imshow(bh)
 
bn=edge(I,'sobel','nothinning'); %sin adelgazamiento de las fronteras
figure,imshow(bn);



Ipre=edge(I,'prewitt');
figure,imshow(Ipre);
Irob=edge(I,'roberts');
figure,imshow(Irob)

Ilog=edge(I,'log');
figure,imshow(Ilog);

%High-boost: restar a la imagen original una version promedio de esta.
%Perfilar los bordes
close all;
f=fspecial('laplacian',0);
r=I-imfilter(I,f);
imtool(r)
figure,imshow(I),title('Original');
%Mas sobre fspecial. Realzar los brodes
% H = FSPECIAL('unsharp',ALPHA) returns a 3-by-3 unsharp contrast
%     enhancement filter. FSPECIAL creates the unsharp filter from the
%     negative of the Laplacian filter with parameter ALPHA. ALPHA controls
%     the shape of the Laplacian and must be in the range 0.0 to 1.0.
%     The default ALPHA is 0.2.
% Aumenta la fuerza de las fronteras. Mejora los perfiles
H = fspecial('unsharp');
sharpened = imfilter(I,H,'replicate');
figure,imshow(sharpened);title('Sharpened Image');
Ishar=edge(sharpened,'canny');
figure,imshow(Ishar);



%Correlacion con las figuras.


%%
%RUIDO DE MOVIMIENTO. Sobre distorsion2.jpg
;

     
%% Detector de Esquinas corner 


%% EJERCICIO: Programar el detector de esquinas de Moravec



%%
%CANNY
  
% BW = edge(I,'canny') specifies the Canny method.
%  
%     BW = edge(I,'canny',THRESH) specifies sensitivity thresholds for the
%     Canny method. THRESH is a two-element vector in which the first element
%     is the low threshold, and the second element is the high threshold. If
%     you specify a scalar for THRESH, this value is used for the high
%     threshold and 0.4*THRESH is used for the low threshold. If you do not
%     specify THRESH, or if THRESH is empty ([]), edge chooses low and high
%     values automatically.
%  
%     BW = edge(I,'canny',THRESH,SIGMA) specifies the Canny method, using
%     SIGMA as the standard deviation of the Gaussian filter. The default
%     SIGMA is sqrt(2); the size of the filter is chosen automatically, based
%     on SIGMA.
%  
%     [BW,thresh] = edge(I,'canny',...) returns the threshold values as a
%     two-element vector.

I=imread('disney.png');
Icanny=edge(I,'canny');
figure,imshow(Icanny);