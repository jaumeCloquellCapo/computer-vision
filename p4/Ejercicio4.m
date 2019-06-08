%Obtener sobre la imagen formas.png las esquinas usando el método de Harris. 

%% Harris

I = imread('formas.png');
%creación de los elementos estructurales
e = strel(imread('estrella.png'));
o = strel(imread('ovalo.png'));
c = strel(imread('cuadrado.png'));
c2 = strel(imread('cuadrado2.png'));
c3 = strel(imread('cuadrado3.png'));

imshow(imopen(I,e)); %solo se detecta una estrella por su tamaño, hay que reducir su dimensión. 
close all;
%creación de los elementos estructurales con una nueva dimensión
e = strel('arbitrary',im2bw(imresize(imread('estrella.png'),0.9)));
o = strel('arbitrary',im2bw(imresize(imread('ovalo.png'),0.9)));
c = strel('arbitrary',im2bw(imresize(imread('cuadrado.png'),0.9)));
c2 = strel('arbitrary',im2bw(imresize(imread('cuadrado2.png'),0.9)));
c3 = strel('arbitrary',im2bw(imresize(imread('cuadrado3.png'),0.9)));

%visualización
imshow(imopen(I,e));
figure,imshow(imopen(I,o));
figure,imshow(imopen(I,e));
figure,imshow(imopen(I,c));
figure,imshow(imopen(I,c2));
figure,imshow(imopen(I,c3));

%subconjunto de imágenes de texto
clear all;
close all;

%obtención de la imagen inversa de la leída para mejorar la detección
I = ~im2bw(imread('texto.png'));
imshow(I);
%creación de los elementos estructurales a partir de la imagen inversa de
%la leída. 
i = strel('arbitrary',~im2bw(imread('letra_i.png')));
k = strel('arbitrary',~im2bw(imread('letra_k.png')));
m = strel('arbitrary',~im2bw(imread('letra_m.png')));
o = strel('arbitrary',~im2bw(imread('letra_o.png')));
p = strel('arbitrary',~im2bw(imread('letra_p.png')));

figure,imshow(imopen(I,i));
figure,imshow(imopen(I,k));
figure,imshow(imopen(I,m));
figure,imshow(imopen(I,o));
figure,imshow(imopen(I,p));

%% Moravec
I = imread('formas.png');
Isize = size(I);

%Calculo de las diferencias en cuatro orientaciones
h = conv2([1 -1], I);
v = conv2([1 -1]', I);
diag1 = conv2([1 0 ; 0  1], I);
diag2 = conv2([0 1; -1 0], I);

% Para todo pixel en (i,j)
% hh(i,j) suma diferencias en valor absoluta de la ventana 3x3 centrada en i.j de h
% vv(i,j) suma diferencias en valor absoluta de la ventana 3x3 centrada en i.j de v
% diag1(i,j) suma diferencias en valor absoluta de la ventana 3x3 centrada en i.j de d1
% diag2(i,j) suma diferencias en valor absoluta de la ventana 3x3 centrada en i.j de d2

for i = 2:(Isize(1)-1)
    for j = 2:(Isize(2)-1)
        c(i,j) = min (min( sum(sum(abs(h(i-1:i+1,j-1:j+1)))),...
            sum(sum(abs(v(i-1:i+1,j-1:j+1))))),...
            min( sum(sum(abs(diag1(i-1:i+1,j-1:j+1)))),...
            sum(sum(abs(diag1(i-1:i+1,j-1:j+1))))));
    end
end

% normalizamos
maxC = max(max(c));
c = c / maxC;

% Buscamos las esquina
corners = c;
Csize = size(c);
for i = 2:(Csize(1)-1)
    for j = 2:(Csize(2)-1)
        square = c((i-1):(i+1),(j-1):(j+1));
        if (max(max(square)) == c(i,j))
            corners(i,j) = 255;
        else
            corners (i,j) = 0;
        end
    end
end

imshow(corners)