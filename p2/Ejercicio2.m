%Haz otra función que, de forma análoga, muestre los histogramas de las componentes
%RGB. Esta vez no hay que mostrar ningún mapa de color específico para ninguna de
%ellas.

I=imread('Warhol_Marilyn_1967_OnBlueGround.jpg');
%Igray=rgb2gray(I);
figure;
%subplot(2,2,1),subimage(I),title('Original');
%subplot(2,2,2),subimage(Igray),title('Niveles de gris');
%subplot(2,2,3),imhist(Igray),title('Histgrama N.G');
subplot(3,3,1),subimage(I(:,:,1)),title('Rojo');
subplot(3,3,2),subimage(I(:,:,2)),title('Verde');
subplot(3,3,3),subimage(I(:,:,3)),title('Azul');
subplot(3,3,4),imhist(I(:,:,1)),title('Histgrama Rojo');
subplot(3,3,5),imhist(I(:,:,2)),title('Histgrama Verde');
subplot(3,3,6),imhist(I(:,:,3)),title('Histgrama Azul');

