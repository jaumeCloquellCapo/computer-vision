

%Crea una animación en la que, dada una imagen, se pueda ver como van ciclando los
%colores. Para ello, cada fotograma se obtendrá sumando un pequeño incremento a la
%componente H del fotograma anterior. Para ello puedes usar las funciones im2frame y
%movie.

I=imread('Warhol_Marilyn_1967_OnBlueGround.jpg');
clear peli;
y=rgb2hsv((I));
z=y;
for i=1:255
    disp(i)
    z(:,:,1)=mod(y(:,:,1)+i/255.0,0.99);
    peli(i)=im2frame((hsv2rgb(z)));
end
movie(peli);