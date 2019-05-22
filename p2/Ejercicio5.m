

%Crea una animación en la que, dada una imagen, se pueda ver como van ciclando los
%colores. Para ello, cada fotograma se obtendrá sumando un pequeño incremento a la
%componente H del fotograma anterior. Para ello puedes usar las funciones im2frame y
%movie.

A=imread('Warhol_Marilyn_1967_OnBlueGround.jpg');
A(:,:,1)=1;

h=rgb2hsv(A);
%cambiamos la saturacion para ver los distintos valores

clear peli1
k=1;
for v=0:0.01:1
      h(:,:,1)=v;
      peli1(k)=im2frame(hsv2rgb(h));
      k=k+1;
end

mplay(peli1)