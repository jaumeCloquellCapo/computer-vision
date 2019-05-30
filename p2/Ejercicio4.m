function Ejercicio4(F, Bg, x, y, R, G, B)

F=imread(F);
Bg=imread(Bg);

% Creamos un RGB uint8 del color verde del chroma y del tamaño del fondo
unos = ones(size(Bg,1),size(Bg,2),size(Bg,3));
unos = im2uint8(unos);
unos(:,:,1) = R;
unos(:,:,2) = G;
unos(:,:,3) = B;

% Unimos la imagen a colocar y el fondo verde
loc1 = size(Bg,1)-x-size(F,1)+1:size(Bg,1)-x;
loc2 = size(Bg,2)-y-size(F,2)+1:size(Bg,2)-y;
unos(loc1, loc2,:) = F;

% Extraemos los canales del RGB
FR = unos(:,:,1);
FG = unos(:,:,2);
FB = unos(:,:,3);
FY = 0.3*FR+0.59*FG+0.11*FB;

mask = mat2gray(FG-FY) < 80/255;

% Bucle para cambiar el 255 por 1 (formato uint8)
mask = im2uint8(mask);
for i = 1:size(mask, 1)
    for j = 1:size(mask, 2)
        if mask(i,j) == 255 
            mask(i,j) = 1;
        else
            mask(i,j) = 0;
        end
    end
end

% Finalmente mantenemos canal por canal la imagen delantera (mujer) donde la mascara = 1 y el fondo donde la mascara = 0
final(:,:,1)=unos(:,:,1).*mask + B(:,:,1).*(1-mask);
final(:,:,2)=unos(:,:,2).*mask + B(:,:,2).*(1-mask);
final(:,:,3)=unos(:,:,3).*mask + B(:,:,3).*(1-mask);
imshow(mat2gray(final));
end


        
    
    

