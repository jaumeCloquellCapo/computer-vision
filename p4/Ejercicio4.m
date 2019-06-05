%Obtener sobre la imagen formas.png las esquinas usando el método de Harris. 

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