%%
%Introducción al analisis de señales con la tranformada wavelet. 
%
%%
%familias de wavelet

waveletfamilies('f');

%muestra los nombres de las wavelet en cada familia
waveletfamilies('a');

%familias habilitadas
wavemngr('read')

%caracteristicas de una familia concreta
waveinfo('db')

%interactive herramienta para empezar el analizador wavelet
wavemenu

%1.- Pulsar wavelet display
%2.- Seleccionar la familia 
%3.- Display 

%%
%Daubechies ; dbN siendo N el orden. db1 es la wavelet Haar
waveinfo('db')

%%Biorthogonal
% Se usan dos wavelet una para reconstrucción y otra para el analisis.
waveinfo('bior')

[LoD,HiD,LoR,HiR] = wfilters('bior3.5');
subplot(221);
stem(LoD);
title('Lowpass Analysis Filter');
subplot(222);
stem(HiD);
title('Highpass Analysis Filter');
subplot(223);
stem(LoR);
title('Lowpass Synthesis Filter');
subplot(224);
stem(HiR);
title('Highpass Synthesis Filter');


%%
%CWT: Transformada wavelet continua
%La transformada wavelet continua usa el producto interior para medir la
%similaridad entre una señal y la funcion analizadora. En la transformada
%de Fourier la funcion que analiza son exponenciales complejas. El
%resultado es una función de una sola variable la frecuencia w. En la
%transformada de Fourier aventanada la funcion analizadora son
%exponenciales complejas aventanadas w(t)exp(jwt), dando lugar a una
%función de dos variables. De esta forma los coeficientes de la
%transformada de fourier aventanada STFT representa la correlación entre la
%señal y una sinusoidal con una frecuencia en un intervalo de tiempo

% En la CWT, la funcion que analiza es \Psi. La CWT compara la señal con
% \Psi desplazandola por la señal una y otra vez con versiones mas
% estrechas de la misma \Psi. Este proceso de estrechar o ensanchar se
% define por el término escala. Asi comparando la señal con la wavelet en
% difentes posiciones y escalas obtienes los coeficientes wavelet, siendo
% esta una señal de dos variables. 

%%SCALA
%Este concepto es muy importante. La escala mide cambios a un nivel de
%detalle. Dada una escala obtienes un  detalle  mayor que a una escala mas
%grande, es como mirar por un microscopio con una determinada lente. Asi
%por ejemplo se puede analizar cambios de temperatura año a año o 10 en 10
%años. Con respecto a la wavelet madre estrecharla equivale a aumentar la
%escala, ya que quieres cambios que ocurran en un periodo de tiempo mas
%pequeño. Por el contrario si la wavelet la ensanchas equivale a insertar
%una escala mas pequeña ya que quieres observar cambios que ocurran en un
%periodo de tiempo mas grande. El concepto de escala se relaciona con el 
%concepto de frecuencia. Si quieres detalles mas
%finos se usan frecuencias mas grandes . Si quieres
%detalles mas gruesos se usan frencuencias mas bajas 
%Para ver esta relacion 

wname = 'db10';

%Calcular la frecuencia central y dibuja
%la wavelet y la frecuencia central asociada.

iter = 10;
cfreq = centfrq(wname,iter,'plot')


%%
%Ejemplo de la CWT
x=zeros(1000,1);
x(500)=1;

[~,psi,xval] = wavefun('haar',10);
plot(xval,psi); axis([0 1 -1.5 1.5]);
title('Haar Wavelet');

CWTcoeffs=cwt(x,1:128,'haar'); %scalas 1:128 genera una matriz 128x1000, cada fila contiene la CWT a una escala
cwt(x,1:128,'haar','plot');
colormap jet,colorbar;

%Si observamos la CWT de la señal se observa que los coeficientes CWT se
%concentran en una region estrecha en el plano tiempo y escala. A escalas
%pequeñas se concentran alrededor del punto 500. Conforme la escala se
%incrementa el conjunto de coeficientes es mas ancho,pero permanecen
%centrado en el punto 500.


%%
%Ver los cambios abruptos
% Vamos a definir una señal sinusoidal a 4-Hz con dos discontinuidades
N = 1024; % numero de muestas
t = linspace(0,1,1024); % el espacio temporal desde 0 a 1 con 1024 muestras
x = 4*sin(2*pi*t); % la sinusoidal a 2-hz y amplitud maxima 4
x = x - sign(t - .3) - sign(.72 - t); % añadimos las discontinuidades en 0.3 y 0.72
figure,plot(t,x); xlabel('t'); ylabel('x');
grid on;

%usando la wavelet sym4 obtenemos la cwt de x
CWTcoeffs = cwt(x,1:180,'sym4'); % escalas 1 a 180
figure, imagesc(t,1:180,abs(CWTcoeffs)); 

colormap jet; axis xy;
xlabel('t'); ylabel('Scales');

% Como se puede observar la CWT detecta tanto la oscilaciones abruptas como
% las oscilaciones propias de la señal. Las abruptas se detectan en todas
% las escalas.



%%
% A partir del filtro wavelet w se definen los cuatro filtros. De
% descomposicion Lo_D y Hi_D y los de reconstrucción Lo_R y Hi_R
%Lo_R=W/norm(W) y Lo_D=reflejar(Lo_R) y Hi_R=qmf(Lo_R) Hi_D=reflejar(Hi_R)
%qmf es Hi_R(k)=(-1)^k Lo_R(2N+1-k) (reflejo y cambiar de signo a las
%posiciones impares

%Ejemplo
%wname='db6';
wname='bior3.7'
[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wname);

subplot(221);stem(Lo_D,'markerfacecolor',[0,0,1]);
title('Low pass Decomposition');
subplot(222);stem(Hi_D,'markerfacecolor',[0,0,1]);
title('High pass Decomposition');

subplot(223);stem(Lo_R,'markerfacecolor',[0,0,1]);
title('Low pass Reconstruction');
subplot(224);stem(Hi_R,'markerfacecolor',[0,0,1]);
title('High pass Reconstruction');


%Obtenemos las transformada de Fourier del filtro paso bajo y paso alto. Y
%mostramos el modulo.
LoDFT = fft(Lo_D,64); %soporte de 65 items
HiDFT = fft(Hi_D,64);
freq = -pi+(2*pi)/64:(2*pi)/64:pi;
subplot(427); plot(freq,fftshift(abs(LoDFT)));
set(gca,'xlim',[-pi,pi]); xlabel('Radians/sample');
title('DFT Modulus - Lowpass Filter')
subplot(428); plot(freq,fftshift(abs(HiDFT)));
set(gca,'xlim',[-pi,pi]); xlabel('Radians/sample');
title('Highpass Filter');

%%
%Analysis de una imagen usando la DWT
load wbarb;
whos
image(X);colormap(map); colorbar;

%descomponemos la imagen
[cA1,cH1,cV1,cD1] = dwt2(X,'bior3.7');


%Para mostrar las bandas tenemos que sobremuestrear 
sx = size(X);
A1 = idwt2(cA1,[],[],[],'bior3.7',sx); 
H1 = idwt2([],cH1,[],[],'bior3.7',sx);
V1 = idwt2([],[],cV1,[],'bior3.7',sx);  
D1 = idwt2([],[],[],cD1,'bior3.7',sx);

colormap(map);
subplot(2,2,1); image(wcodemat(A1,192));
title('Approximation A1')
subplot(2,2,2); image(wcodemat(H1,192));
title('Horizontal Detail H1')
subplot(2,2,3); image(wcodemat(V1,192));
title('Vertical Detail V1') 
subplot(2,2,4); image(wcodemat(D1,192));
title('Diagonal Detail D1')


%si queremos realizar 2 niveles de descoposicion
[C,S] = wavedec2(X,2,'bior3.7');

%para obtener la aproximacion de la imagen usando los coeficientes
%al nivel 2
cA2 = appcoef2(C,S,'bior3.7',2);
figure,colormap(map),image(wcodemat(cA2,192))
%Para extraer los coeficientes de detalles del primer y segundo nivel
[cH2,cV2,cD2] = detcoef2('all',C,S,2);
[cH1,cV1,cD1] = detcoef2('all',C,S,1);
%Para extraer los coeficientes de aproximacion del nivel 2

%Pintar esos datos


%Para obtener la imagen de las diferentes bandas
A2= wrcoef2('a',C,S,'bior3.7',2);

%Reconstruir la imagen
typeH1 = wrcoef2('h',C,S,'bior3.7',1);
V1 = wrcoef2('v',C,S,'bior3.7',1);
D1 = wrcoef2('d',C,S,'bior3.7',1);
H2 = wrcoef2('h',C,S,'bior3.7',2);
V2 = wrcoef2('v',C,S,'bior3.7',2);
D2 = wrcoef2('d',C,S,'bior3.7',2);

%
colormap(map);
subplot(2,4,1);image(wcodemat(A1,192));
title('Approximation A1')
subplot(2,4,2);image(wcodemat(H1,192));
title('Horizontal Detail H1')
subplot(2,4,3);image(wcodemat(V1,192));
title('Vertical Detail V1')
subplot(2,4,4);image(wcodemat(D1,192));
title('Diagonal Detail D1')
subplot(2,4,5);image(wcodemat(A2,192));
title('Approximation A2')
subplot(2,4,6);image(wcodemat(H2,192));
title('Horizontal Detail H2')
subplot(2,4,7);image(wcodemat(V2,192));
title('Vertical Detail V2')
subplot(2,4,8);image(wcodemat(D2,192));
title('Diagonal Detail D2')

%Reconstruccion

X0 = waverec2(C,S,'bior3.7');
figure,colormap(map),image(X0)



