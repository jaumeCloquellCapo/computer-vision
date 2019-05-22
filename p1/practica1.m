

%Probar los distintos visualizadores de que disponemos en Matlab (imshow, imtool,
%imagesc). Para ello cargar la imagen disney.png y:
%   1. Visualizarla con los tres visualizadores.

disney = imread('disney.png')
imshow(disney)
imtool(disney)
imagesc(disney)

%   2. Convertir a tipo double con double(img) y visualizar de nuevo.

Id1=double(disney);
figure, imshow(Id1,[])

%cuidado con la visualizacion de Id1 si pones solo imshow(Id1) se vera todo
%blanco
%   3. Convertir a double con im2double y analizar el resultado.

Id2=im2double(disney);
figure, imshow(Id2)
