

%Mostrar las componentes frecuenciales que entran en un disco de centro u,v y radio r. 
% Visualizar diferentes discos cambiando el centro y radio.

I_original=imread('cameraman.tif');


%Eliminación de ruido. 
% Sobre la imagen cameraman insertar ruido gaussiano 
% y mirar que componentes frecuenciales habría que eliminar para reducir el mayor ruido posible.
%Leemos de nuevo la imagen 

I_original=imread('cameraman.tif');

% añadimos ruido gaussiano 
sig = 100; 
V = (sig/256)^2;  
I_noise = imnoise(I_original,'gaussian',0,V)
figure, imshow(I_original),title('Imagen Original');
figure,imshow(I_noise),title('Imagen con ruido');

% Hacemos una copia de la imagen con ruido
I = I_noise

mi=size(I,1)/2;
mj=size(I,2)/2;
x=1:size(I,2);
y=1:size(I,1);
[Y, X]=meshgrid(y-mi,x-mj);
dist = hypot(X,Y);

sigma =30;
H_gau=exp(-(dist.^2)/(2*(sigma^2))); %gaussiana
figure,mesh(H_gau)
Id=im2double(I);
I_dft=fft2(Id);

%creamos el filtro paso bajo
DFT_filt_gau=fftshift(H_gau).*I_dft;
I3= real(ifft2(DFT_filt_gau));

%Determina la transformada de Fourier discreta de la imagen  pero con el valor de
%|F(0,0)| en el centro de la imagen. 
figure, imshow(log(1+abs(fftshift(DFT_filt_gau))),[]),title('TF de la imagen filtrada');
figure,imshow(I3),title('Imagen filtrada');


%Realizar sobre la imagen barbara una descomposición wavelet usando bior3.7 con tres niveles. Fijado un porcentaje , por ejemplo 10 %, que  indican el porcentaje de coeficientes que nos quedamos de entre todos los coeficientes wavelets de la descomposición. Estos coeficientes son los que tiene mayor magnitud. 
%Variar el procentaje y obtener una grafica en la que en el eje X tenemos razon de compresión y en el eje Y el valor de PSNR.

clear all
load wbarb;
whos
image(X);colormap(map); colorbar;

% Calcula la DWT de una imagen.
[C, S] = wavedec2(X,3,'bior3.7');

% porcentaje de elemento que nos quedamos
percentage = 10;
nEle = percentage * length(C) / 100;
C([nEle:length(C)]) = 0;

A1 = appcoef2(C,S,'bior3.7',1);
[H1,V1,D1] = detcoef2('all',C,S,1);
A2 = appcoef2(C,S,'bior3.7',2);
[H2,V2,D2] = detcoef2('all',C,S,2);
A3 = appcoef2(C,S,'bior3.7',3);
[H3,V3,D3] = detcoef2('all',C,S,3); 

H1 = wrcoef2('h',C,S,'bior3.7',1); 
V1 = wrcoef2('v',C,S,'bior3.7',1); 
D1 = wrcoef2('d',C,S,'bior3.7',1); 
H2 = wrcoef2('h',C,S,'bior3.7',2);
V2 = wrcoef2('v',C,S,'bior3.7',2); 
D2 = wrcoef2('d',C,S,'bior3.7',2);
H3 = wrcoef2('h',C,S,'bior3.7',3);
V3 = wrcoef2('v',C,S,'bior3.7',3); 
D3 = wrcoef2('d',C,S,'bior3.7',3);

V1img = wcodemat(V1,255);
H1img = wcodemat(H1,255);
D1img = wcodemat(D1,255);
A1img = wcodemat(A1,255);

V2img = wcodemat(V2,255);
H2img = wcodemat(H2,255);
D2img = wcodemat(D2,255);
A2img = wcodemat(A2,255);

V3img = wcodemat(V3,255);
H3img = wcodemat(H3,255);
D3img = wcodemat(D3,255);
A3img = wcodemat(A3,255);

X0 = waverec2(C,S,'bior3.7');

%mat3 = [A3img,V3img;H3img,D3img];
%mat2 = [mat3,V2img;H2img,D2img];
%mat1 = [mat2,V1img;H1img,D1img];

imshow(uint8(X0))
[peaksnr, snr] = psnr(uint8(X0), uint8(X));    fprintf('\n El error psnr es %0.4f', peaksnr);
%Obtenemos un valor alto de PSNR 25.8675 que significa que la razón señal a
%ruido es grande. 


