

F=imread('chromakey_original.jpg');
B=imread('praga1.jpg');

f = B;
x= F;

Rx=x(:,:,1); %figure, imhist(Rx)
Gx=x(:,:,2); %figure, imhist(Gx)
Bx=x(:,:,3); %figure, imhist(Bx)

%mask=findColor(x, 1.1); %Mascara mask=uint8(mask);
tolerance = 1.1;
[M,N,t] = size(x);
I1 = zeros(M,N); 
I2 = zeros(M,N);
I1( find(x(:,:,2) > tolerance * x(:,:,1)) ) = 1; 
I2( find(x(:,:,2) > tolerance * x(:,:,3)) ) = 1; 
%strTitle = 'Color GREEN detected (white areas)'; 
mask = I1 .* I2;
mask=uint8(mask);

maski=not(mask); %Mascara Inversa 
maski=uint8(maski);
% Objeto del Foreground a Color
ckf1=(Rx.*(maski)); %Se multiplica la mascara inversa por el Foreground object
ckf2=(Gx.*(maski));
ckf3=(Bx.*(maski));
%
[n1 n2 n3 n4]=size(x);
%Se agrega el color y se tranforma en matriz 3D 
ckf=zeros(n1,n2,n3);
ckf(:,:,1)=uint8(ckf1); 
ckf(:,:,2)=uint8(ckf2); 
ckf(:,:,3)=uint8(ckf3); 
ckf=uint8(ckf);
imshow(ckf);


% hasta aui todo okey


f=B;
f = imresize(f, [n1 n2]); %figure,imshow(f);
[l1 l2 l3]=size(f);

%Se extraen las componentes de cada color del Background(R,G,B) 
Rf=f(:,:,1); %figure, imshow(Rf);%figure, imhist(Rx)
Gf=f(:,:,2); %figure, imshow(Gf);%figure, imhist(Gx)
Bf=f(:,:,3); %figure, imshow(Bf);%figure, imhist(Bx)
%

%Objeto del Background a Color
ckb1=(Rf.*(mask)); %Se multiplica la mascara por el Background 
ckb2=(Gf.*(mask));
ckb3=(Bf.*(mask));

%Se agrega el color y se tranforma en matriz 3D

ckb=zeros(n1,n2,n3); 
ckb(:,:,1)=uint8(ckb1); 
ckb(:,:,2)=uint8(ckb2); 
ckb(:,:,3)=uint8(ckb3); 
ckb=uint8(ckb);
%Chroma Key
ck=ckf+ckb; %Se sumas las dos componentes video2(t).cdata=ck;
imshow(ck);