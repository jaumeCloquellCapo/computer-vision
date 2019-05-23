%%%Morfologia de imagenes 
% Dilatar: Hace crecer los objetos de la imagen que depende el elemento
% estructural
%Con imagenes binarias
bw = imread('text.png');
se= strel('line',11,90); %elemento estructural tipo, numero de elementos, orientacion

%dilatamos 
bw2=imdilate(bw,se);
figure, subplot(1,2,1),imshow(bw),subplot(1,2,2),imshow(bw2);


%%Veamoslo con un poco mas detalle
a=[ 0 1 0; 0 1 0; 0 1 0;0 1 0]
se=strel('line',3,0);%longitud 3 angulo 0. ancla punto central
b=imdilate(a,se);


%otro elemento structural
se2 = strel('square',2); 
b2=imdilate(a,se2);% el ancla depende de si es dilatacion (esquina inferior derecha)


%Dilatacion sobre imagenes de niveles de gris. Escoge el maximo de los
% puntos que se?ala el elemento estructural una vez que se ancla en un punto
I=imread('cameraman.tif');
se=strel('ball',5,5);
I2=imdilate(I,se);
figure, subplot(1,2,1),imshow(I),subplot(1,2,2),imshow(I2);



%% EROSION
%la erosion sobre imagen. Mantiene intactos los puntos cuando el elemento
%estructural conincide con la imagen
%imagennes binaria

close all;
originalBW = imread('circles.png');  
se = strel('disk',11);        
erodedBW = imerode(originalBW,se);
figure, subplot(1,2,1),imshow(originalBW),subplot(1,2,2), imshow(erodedBW)

%%Veamoslo con un poco mas de detalle
a=[ 0 1 1 0; 0 1 1 0; 0 1 1 0;0 1 0 0]
se=strel('square',2);
b=imerode(a,se)


%Erosion sobre imagenes de niveles de gris. Escoge el minimo de los
% puntos que se?ala el elemento estructural una vez que se ancla en un punto


originalI = imread('cameraman.tif');
se = strel('ball',5,5);
erodedI = imerode(originalI,se);
figure, imshow(originalI), figure, imshow(erodedI)

%% Apertura: erosion + dilataion

%sobre imagenes binarias
originalBW = imread('circles.png');  
se = strel('disk',15);        
openBW = imopen(originalBW,se);
figure, subplot(1,2,1),imshow(originalBW),subplot(1,2,2), imshow(openBW)


%Para buscar una forma en un conjunto
formas = imread('formas.png');
estrella = imread('estrella.png');
%creamos un elemento estructural con la estrella
se = strel('arbitrary',estrella);
%aplicamos la apertura
s_estr= imopen(formas,se);
figure,subplot(1,2,1),imshow(formas),subplot(1,2,2),imshow(s_estr);
%resulta que la estrella igual es solo una
%hagamos la estrella mas peque?a
estrella2=im2bw(imresize(estrella,0.9),0.5);

se = strel('arbitrary',estrella2);
%aplicamos la apertura
s_estr= imopen(formas,se);
figure,subplot(1,2,1),imshow(formas),subplot(1,2,2),imshow(s_estr);

%Sobre imagnes de niveles de gris 

original = imread('snowflakes.png');
figure, imshow(original);
se = strel('disk',5);

afterOpening = imopen(original,se);
figure, imshow(afterOpening,[]);

%% CIERRE: dilatacion +erosion
%sobre imagenes binarias
close all;
originalBW = imread('circles.png');  
se = strel('disk',15);        
closeBW = imclose(originalBW,se);
figure, subplot(1,2,1),imshow(originalBW),subplot(1,2,2), imshow(closeBW)



%Sobre imagnes de niveles de gris 

original = imread('snowflakes.png');
figure, imshow(original);
se = strel('disk',5);

afterClose = imclose(original,se);
figure, imshow(afterClose,[]);

%% ESQUELETO: Aplica la erosion un numero de veces hasta un punto en el cual
% que si lo vuelve aplicar se queda con una imagen negra.

estrella = imread('estrella.png');
esque= bwmorph(estrella,'skel',Inf);
figure, imshow(esque);

%%Fronteras
%Exterior: Dilatar y restarle la imagen
estrella = imread('estrella.png');
se= strel('disk',2);
f_ext= imdilate(estrella,se)-estrella;
figure, imshow(f_ext);

%Frontera interior:a la imagen original restamos la  Erosionada
estrella = imread('estrella.png');
se= strel('disk',2);
f_int= estrella-imerode(estrella,se);
figure, imshow(f_int);

%las dos fronteras
f=f_ext+f_int;
figure,imshow(f);


%Rellenar los agueros de una imagen
rellena=imfill(f_ext,'holes');
figure,imshow(rellena)

%otro ejemplo de relleno
BW4 = im2bw(imread('coins.png'));
BW5 = imfill(BW4,'holes');
figure,imshow(BW4), figure, imshow(BW5)
%% Componentes Conexas. Primera aprox. a la segmentacion
%bwlabel etiqueta componentes conexas en una imagen binaria
[L,NUM]=bwlabel(BW5,4);%%4-conectados
colores =['y' 'm' 'c' 'r' 'g' 'b' 'w' 'k'];
figure,imshow(BW5), hold on
% for i=1:8
%  [F R]=find(L==i);
% plot(R,F,'Color',colores(i));
% end
mas_colores={ [0 0 0],[0,0,1],[0,1,0],[0,1,1],[1,0,0],[1,0,1],...
    [1,1,0],[1,1,1],[0,0,0.5],[0,0.5,0]};

for i=1:NUM
 [F R]=find(L==i);
plot(R,F,'Color',mas_colores{i});
end    

%% TOP-HAT : aplica la apertura de una imagen y le quita a la imagen original  este resultado
%mejora el contraste
close all; clear all;
arroz =imread('rice.png');
se =strel('disk',12);
tophat = imtophat(arroz,se);
apertura = imopen(arroz,se);
figure,imshow(arroz),title('Original');
figure,imshow(tophat),title('Top-Hat');
figure,imshow(apertura),title('Apertura');