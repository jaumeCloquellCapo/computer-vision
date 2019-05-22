%2. Descomponer una imagen RGB en sus tres componentes de color (rosa.jpg).
rosa = imread('rosa.jpg')
% Una imagen de color RGB se representa por tres matrices bidimensionales,
% correspondientes a los planos R, G y B. 
imR= rosa(:,:,1);
imG= rosa(:,:,2);
imB= rosa(:,:,3);

%   1. Visualizar las tres componentes de manera simultánea junto con la imagen original y
%analizar los resultados.

figure, subplot(1,4,1),imshow(rosa),title('color'),subplot(1,4,2),imshow(imR),title ('Roja'), ...
    subplot(1,4,3),imshow(imG),title ('Verde'),subplot(1,4,4),imshow(imB),title ('Azul')

%   2. Anula una de sus bandas (por ejemplo la roja) y analiza los resultados. Se
%recomienda usar imtool para ver los valores de color en cada píxel.

rosa = imread('rosa.jpg')
rosa(:,:,2) = 0 ;
imtool(rosa)

%   3. Usa también la imagen sintetica.jpg, haz otras modificaciones y observa los
%   resultados (por ejemplo: poner una de sus bandas al nivel máximo, intercambiar el
%   papel de las bandas entre sí, aplicar un desplazamiento a alguna de las bandas con
%   circshift, invertir alguna de sus bandas con fliplr o flipud, ...).

sintetica = imread('sintetica.jpg')
imshow(sintetica)

J2=sintetica(:,:,3);
imhist(J2);
figure;
imshow(J2);

im2bw(sintetica); %Binariza la imagen con un umbral fijo

% Transformacion de intensidad
croped = imadjust(sintetica, [0 1], [1 0])
subplot(1,2,1)
imshow(sintetica)
subplot(1,2,2)
imshow(croped)

%Cambio de tamaño
g1=imresize(sintetica,0.2)
g2=imresize(sintetica,0.4)
g3=imresize(sintetica,0.8)
subplot(1,3,1)
imshow(g1)
subplot(1,3,2)
imshow(g2)
subplot(1,3,3)
imshow(g3)

% Invertir imagen 
a = fliplr(sintetica)
figure, subplot(1,2,1), imshow(sintetica),title 'original',subplot(1,2,2),imshow(a), title('invertida')

% Rotar imagen 
a=imrotate(sintetica,90); %le indicas los grados
figure, subplot(1,2,1), imshow(sintetica),title 'original',subplot(1,2,2),imshow(a), title('rotada')