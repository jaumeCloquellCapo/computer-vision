%Implementa alguna modificación sobre la componente H de la imagen. Por ejemplo,
%suma un valor constante a dicho componente y visualiza la imagen resultante.

I=imread('Warhol_Marilyn_1967_OnBlueGround.jpg');

hsv = rgb2hsv(I); % HSV version of original image
HSV = hsv;         % HSV version of image we're modifying
HSV(:,:,1) = 2/3; % Shift the hue component, this is not pretty...
%HSV(:,:,2) = 1;       % Change the saturation
IM = hsv2rgb(HSV);                  % Convert back to RGB
subplot(1,2,1),imagesc(I)          % display anf compare 
subplot(1,2,2),imagesc(IM)          % the 2 images