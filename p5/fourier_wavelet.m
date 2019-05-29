

%Mostrar las componentes frecuenciales que entran en un disco de centro u,v y radio r. 
% Visualizar diferentes discos cambiando el centro y radio.


%Eliminación de ruido. Sobre la imagen cameraman insertar ruido gaussiano y mirar que componentes frecuenciales habría que eliminar para reducir el mayor ruido posible.


%Realizar sobre la imagen barbara una descomposición wavelet usando bior3.7 con tres niveles. Fijado un porcentaje , por ejemplo 10 %, que  indican el porcentaje de coeficientes que nos quedamos de entre todos los coeficientes wavelets de la descomposición. Estos coeficientes son los que tiene mayor magnitud. 
%Variar el procentaje y obtener una grafica en la que en el eje X tenemos razon de compresión y en el eje Y el valor de PSNR.

%Analysis de una imagen usando la DWT
%load wbarb;
%whos
%image(X);colormap(map); colorbar;

%descomponemos la imagen
%[cA1,cH1,cV1,cD1] = dwt2(X,'bior3.7');

clear all
load wbarb;
whos
image(X);colormap(map); colorbar;
im = imread('cameraman.tif');
imshow(im);


% Calcula la DWT de una imagen.
[C, S] = wavedec2(X,3,'bior3.7');


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

mat3 = [A3img,V3img;H3img,D3img];
mat2 = [mat3,V2img;H2img,D2img];
mat1 = [mat2,V1img;H1img,D1img];

imshow(uint8(X0))
%imshow(mat1)


%%%%5

w='bior3.7';
n = 3;
[c,s] = wavedec2(im,n,w);
V=[];
for i=n:-1:1;
    LL = appcoef2(c,s,w,i);
    [HL,LH,HH] = detcoef2('all',c,s,i);
    if i==n
        V=[LL,HL;LH,HH];
    end
    if i~=n
        V=cat(1,cat(2,V,HL),cat(2,LH,HH));
    end
end

PSNR=10 * log10 ( ( 255 * 255 ) / MSE)



