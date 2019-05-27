%Analizar la imagen distorsion1.jpg y aplicar diferentes técnicas para mejorarla
%(eliminación del ruido). En concreto, prueba con suavizados gaussianos y con el filtro
%'motion' de Matlab.

I=imread('distorsion1.jpg');

fg=fspecial('motion',20,45);
IMotion1= imfilter(I,fg);
fg=fspecial('motion',9,20);
IMotion2= imfilter(I,fg);
fg=fspecial('motion',12,0);
IMotion3= imfilter(I,fg);



%fg = fspecial('gaussian',[3,3],0.5);
IGauss1 = imfilter(I,fspecial('gaussian',[3,3],0.5));
%fg = fspecial('gaussian',[5,5],0.5);
IGauss2 = imfilter(I,fspecial('gaussian',[5,5],0.5));
%fg = fspecial('gaussian',[10,10],0.5);
IGauss3 = imfilter(I,fspecial('gaussian',[10,10],0.5));

%fg = fspecial('gaussian',[3,3],3);
IGauss4 = imfilter(I,fspecial('gaussian',[3,3],3));
%fg = fspecial('gaussian',[5,5],6);
IGauss5 = imfilter(I,fspecial('gaussian',[5,5],6));
%fg = fspecial('gaussian',[10,10],9);
IGauss6 = imfilter(I,fspecial('gaussian',[10,10],9));


figure,
subplot(4,3,1),imshow(I),title('rostro 1');

subplot(4,3,4),imshow(IMotion1),title('IMotion1');
subplot(4,3,5),imshow(IMotion2),title('IMotion2');
subplot(4,3,6),imshow(IMotion3),title('IMotion3');


subplot(4,3,4),imshow(IMotion1),title('IMotion1');
subplot(4,3,5),imshow(IMotion2),title('IMotion2');
subplot(4,3,6),imshow(IMotion3),title('IMotion3');

subplot(4,3,7),imshow(IGauss1),title('IGauss1 [3,3],0.5');
subplot(4,3,8),imshow(IGauss2),title('IGauss2 [5,5],0.5');
subplot(4,3,9),imshow(IGauss3),title('IGauss3 [10,10],0.5');

subplot(4,3,10),imshow(IGauss4),title('IGauss4 [3,3],3');
subplot(4,3,11),imshow(IGauss5),title('IGauss5 [3,3],6');
subplot(4,3,12),imshow(IGauss6),title('IGauss6 [3,3],9');

% Respecto al filtro gausinao he empezado utilizando los valores
% predeterminados para hsize ([3 3]) y sigma (0.5) hasta llegar a [10 10] y sigma 9. hsize es solo el tamaño del filtro, en este caso es una matriz de 3 x 3. Sigma es la sigma de la función de gauss.
% Como podemos obseervar la elección de sigma depende mucho de lo que queramos hacer. Suavizado gaussiano es el filtrado de paso bajo, lo que significa que se suprime de alta frecuencia detalle (ruido, pero también de los bordes), mientras que la preservación de la baja frecuencia de partes de la imagen (es decir, aquellos que no varían mucho). 
% Como estamos buscando para suprimir el ruido en una imagen con el fin de
% mejorar la detección de pequeñas características, la mejor opción es
% elejir un sigma que hace que la Gaussiana sólo ligeramente más pequeño
% que la característica, es decir sigma 0.5 por ejemplo


%¿Se te ocurre alguna otra técnica que mejore sensiblemente la calidad de la imagen
%respecto de los filtrados propuestos?

% El filtro por mediana podría ser una buena opción ya que esta es una técnica alternativa cuando el objeto a alcanzar es más la
%reducción del ruido que el difuminado de la imagen (como es este caso). Consiste en sustituir el valor del nivel de gris de cada punto de la imagen de
%entrada por el valor mediano de los puntos que están incluidos dentro de una
%ventana entorno. 



