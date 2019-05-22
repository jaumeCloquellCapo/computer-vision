%recordar que hsv el verde es h=0.3333 s=1 v=1 luego 0.5- 0.333= 0.1887
%entonces mod(hsv(:,:,1)+0.1887,1.0) será 0.5 cuanto más proximo estés al
%verde luego 1-2*abs(aux-0.5) será 1 cuando estemos tratando el verde.
%llamar a la funcion chroma key con 
F=imread('chromakey_original.jpg');
B=imread('praga1.jpg');

key = [0,255,0];
RED = key(1);
GREEN = key(2);
BLUE = key(3);

imHSV=rgb2hsv(F);
A=0.5-0.3333;
aux=mod(imHSV(:,:,1)+A,1.0); 
verde = 1-2*abs(aux-0.5);
imHSV(:,:,1)=verde;
imHSV(:,:,2)=1;
imHSV(:,:,3)=1;
nueva=hsv2rgb(imHSV);
imshow(nueva)





%Implementar vosotros la funcion chroma_key2 
 %Parametros
 % F=imagen de frente
 % B=imagen de fondo
 % columna donde empezar a poner F en B
 % fila donde empezar a poner F en B
 % color del chroma (en el ejemplo verde).
ch=chroma_key2(F,B,size(B,2)-size(F,2),size(B,1)-size(F,2),0,255,0);
imshow(ch)

