%%Transformada de Fourier de una imagen
I=imread('cameraman.tif');
Id=im2double(I); %% pasamos a double la imagen
ft=fft2(Id); %obtenemos la transformada de fourier
ft_shift =fftshift(ft); %desplazado el 00 al centro u+N/2, v+M/2

figure,subplot(1,2,1), imshow(abs(ft),[]),subplot(1,2,2),imshow(abs(ft_shift),[])%%mostramos la magnitud de la TF
mapa =colormap(gray(256));
figure,subplot(1,2,1), imshow(abs(ft),mapa),subplot(1,2,2),imshow(abs(ft_shift),mapa)%%mostramos la magnitud de la TF

%normalmente para ver mejor el espectro se aplica una transformada
%logaritmo que satura, ya que la frecuencia central (0,0) tiene muchas mas
%energía que el resto y por lo tanto en muchas imágenes es dificil
%visualizar el resto de las  frecuencias
flog=(log(1+abs(ft_shift)));
figure, subplot(1,2,1),imshow(flog,[]), title ('Log del espectro'),subplot(1,2,2),imshow(abs(ft_shift),[])

close all;
whos ft_shift
freal = real(ft_shift);
fimg = imag(ft_shift);


figure, subplot(2,2,1),imshow(freal,[]), title ('Real'),subplot(2,2,2),imshow(fimg,[]),title('Imaginaria'),...
    subplot(2,2,3), imshow(log(1+abs(ft_shift)),[]),title('Log Modulo'),...
    subplot(2,2,4), imshow((angle(ft_shift))), title('Fase')



%% Visualizar armonicos
F=zeros(256,256);
F=complex(F,0); %creamos una imagen compleja de 256x256


%Componente verticales
FV=F;
%FV(1,2)=1;
%Incremento de la frecuencia en la vertical
FV(1,16)=1;


%Componente horizontales
FH=F;
%FH(2,1)=1;
%Incremento de la frecuencia en la vertical
FH(16,1)=1;


IFv=real(ifft2(FV));
IFh= real(ifft2(FH));
figure, subplot(1,2,1),imshow(IFv,[]),title('Vertical'),subplot(1,2,2),imshow(IFh,[]),title('Horizontal')  


Fsuma = FH+FV;
Isuma=real(ifft2(Fsuma));
figure,imshow(Isuma,[])
%% Filtrado en el dominio de Fourier
%Leemos de nuevo la imagen 
I=imread('cameraman.tif');
%Obtenemos una matriz de distancias
% dist=zeros(size(I,1),size(I,2));
% mi=size(I,1)/2;
% mj=size(I,2)/2;
% for i=1:size(I,1)
%     for j=1:size(I,2)
%         dist(i,j)=hypot(i-mi,j-mj);
%         
%     end
% end
%Otra forma de hacer lo mismo con meshgrid
mi = size(I,1)/2;
mj = size(I,2)/2;
x=1:size(I,2);
y=1:size(I,1);
[Y, X]=meshgrid(y-mi,x-mj);
dist = hypot(X,Y);


%creamos el filtro paso bajo
radius = 35;
H=zeros(size(I,1),size(I,2));

ind=ind2sub(size(H), find(dist<=radius));
H(ind)=1;
Hd=fftshift(double(H));
figure, imshow((H)),title('Filtro Paso bajo ideal');

%CONVOLUCION CON EL FILTRO IDEAL EN EL DOMINIO DE FOURIER
I_dft=fft2(im2double(I));
DFT_filt=Hd.*I_dft;
I2=real(ifft2(DFT_filt));
figure,imshow(log(1+abs(fftshift(DFT_filt))),[]),title('Filtered FT');
figure,imshow(I2,[]),title('Imagen Filtrada');


%% FIltrado PASO BAJO
% COn una Gaussiana
I=imread('cameraman.tif');

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
figure,imshow(Id),title('Imagen original');
figure, imshow(log(1+abs(fftshift(I_dft))),[]),title('DFT de la imagen original');
figure, mesh((dist)),title('Matriz de distancias');
figure, imshow((H_gau)),title('Paso Bajo:Gaussiana');

%Filtrado con la gausiana
DFT_filt_gau=fftshift(H_gau).*I_dft;
I3= real(ifft2(DFT_filt_gau));
figure, imshow(log(1+abs(fftshift(DFT_filt_gau))),[]),title('TF de la imagen filtrada');
figure,imshow(I3),title('Imagen filtrada');


%Con Butterworth 
D0=35; n=3
H_but= 1./(1+(dist./D0).^(2*n));
figure,mesh(H_but)
figure, imshow((H_but)),title('Paso Bajo:Butterworth');

%Filtrado con butterworth
DFT_filt_but=fftshift(H_but).*I_dft;
I3= real(ifft2(DFT_filt_but));
figure, imshow(log(1+abs(fftshift(DFT_filt_but))),[]),title('TF de la imagen filtrada');
figure,imshow(I3),title('Imagen filtrada');


%% FIltrado PASO ALTO
% Filtro Ideal
I=imread('cameraman.tif');
%Obtenemos una matriz


%creamos una matriz de distancias
radius = 35;
H=ones(size(I,1),size(I,2));

ind=ind2sub(size(H), find(dist<=radius));
H(ind)=0;
Hd=fftshift(double(H));
figure, imshow((H)),title('Filtro Paso Alto Ideal');

%CONVOLUCION CON EL FILTRO IDEAL EN EL DOMINIO DE FOURIER
I_dft=fft2(im2double(I));
DFT_filt=Hd.*I_dft;
I2=real(ifft2(DFT_filt));

figure,imshow(Id),title('Imagen original');
figure, imshow(log(1+abs(fftshift(I_dft))),[]),title('DFT de la imagen original');
figure, mesh((dist)),title('Matriz de distancias');



figure,imshow(log(1+abs(fftshift(DFT_filt))),[]),title('Filtered FT');
figure,imshow(I2,[]),title('Imagen Filtrada');


%Filtro Paso Alto Gaussiana


sigma =30;
H_gau=1-exp(-(dist.^2)/(2*(sigma^2))); %gaussiana paso alto
figure,mesh(H_gau);
Id=im2double(I);
I_dft=fft2(Id);
figure,imshow(Id),title('Imagen original');
figure, imshow(log(1+abs(fftshift(I_dft))),[]),title('DFT de la imagen original');
figure, mesh((dist)),title('Matriz de distancias');
figure, imshow((H_gau)),title('Paso Alto:Gaussiana');

%Filtrado con la gausiana
DFT_filt_gau=fftshift(H_gau).*I_dft;
I3= real(ifft2(DFT_filt_gau));
figure, imshow(log(1+abs(fftshift(DFT_filt_gau))),[]),title('TF de la imagen filtrada');
figure,imshow(I3),title('Imagen filtrada');


%Filtro Paso Alto Butterworth

D0=35; n=3;
H_but= 1./(1+(D0./dist).^(2*n));
figure,mesh(H_but)
figure, imshow((H_but)),title('Paso Bajo:Butterworth');

%Filtrado con butterworth
DFT_filt_but=fftshift(H_but).*I_dft;
I3= real(ifft2(DFT_filt_but));
figure, imshow(log(1+abs(fftshift(DFT_filt_but))),[]),title('TF de la imagen filtrada');
figure,imshow(I3),title('Imagen filtrada');



%%Eliminacion de ruido con Fourier


