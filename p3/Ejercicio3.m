% Usa imadjust para aplicar la siguiente función de transferencia a la imagen campo.ppm:

A=imread('campo.ppm');
A2 = imadjust(A, [110/255 190/255], [0 255/255], 0.75);
figure, subplot(2,4,1),imshow(A), subplot(2,4,2),imhist(A(:,:,1)),title('Rojo'), subplot(2,4,3),imhist(A(:,:,2)),title('Verde'),subplot(2,4,4),imhist(A(:,:,3)),title('Azul');
subplot(2,4,5),imshow(A2), subplot(2,4,6),imhist(A2(:,:,1)), subplot(2,4,7),imhist(A2(:,:,2)),subplot(2,4,8),imhist(A2(:,:,3));

