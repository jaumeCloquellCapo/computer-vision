function [Image] = Ejercicio4(F,B,startColumn,startRow,colorR,colorG,colorB)
    F = imread(F);
    B = imread(B);
    %umbral
    th = 0.05; 
    %crea un vector en la tercera dimensión
    ColorHSV = zeros(1,1,3);
    %rellena el vector con los valores pasados por parámetro
    ColorHSV(1,1,:) = [colorR colorG colorB]; 
    %se transforma a hsv tanto el vector como la imagen de frente
    ColorHSV = rgb2hsv(ColorHSV);

    ImageFHSV = rgb2hsv(F);

    %Se buscan aquellos colores que estén a mayor distancia que el umbral
    Ind = find(abs(ImageFHSV(:,:,1) - ColorHSV(1,1,1)) > th);

    %Transforma los índices encontrados en indice fila y columna
    [Indi,Indj] = ind2sub(size(F),Ind);

    %Mueve la imagen al punto pasado por parámetros
    IndiB = Indi + startRow;
    IndjB = Indj + startColumn;

    %Elimina los valores fuera de la imagen de fondo.
    for i=1:size(Ind)
        if Indi(i) > size(B,1) || Indj(i) > size(B,2)
            Indi(i) = null;
            Indj(i) = null;
            Ind(i) = null;
            IndiB(i) = null;
            IndjB(i) = null;
        end
    end

    %Se copia el fondo
    Image = B;

    %Se copian aquellos píxeles que no son el croma
    for i=1:size(Ind)
        Image(Indi(i),Indj(i),:) = F(Indi(i),Indj(i),:);
    end


end

