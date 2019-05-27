%Utiliza la correlación para buscar formas en una imagen. Para este ejercicio puedes usar
%las siguientes imágenes:

%? formas.png, estrella.png, ovalo.png, cuadrado.png, cuadrado2.png,
%cuadrado3.png
%? texto.png, letra_i.png, letra_k.png, letra_m.png, letra_o.png, letra_p.png

formas=imread('formas.png');
imshow(formas);
estrella=imread('estrella.png');
figure,imshow(estrella);
Ires=imfilter(double(formas),double(estrella));
%maximo
[max(max(Ires)) min(min(Ires))] %[max(I(:)) min(I(:))]
Ires=Ires/max(max(Ires));
Ith=(Ires>=0.96);
[rows cols] = find(Ith==1)
[res ces]=size(estrella);
r2=uint16(round(res/2)); c2=uint16(round(ces/2));
for r=1:size(rows)
    inirow =rows(r)-r2+1;
    if (inirow<=0) 
            inirow=1;
    end
     finrow =rows(r)+r2;
    if (finrow>size(formas,1)) 
            finrow=size(formas,1);
    end
    c=r;
        inicol=cols(c)-c2+1;
         if (inicol<=0) 
            inicol=1;
        end
     fincol =cols(c)+c2;
    if (fincol>size(formas,2)) 
            fincol=size(formas,2);
    end
        
        Iest(inirow:inirow+size(estrella,1)-1,inicol:inicol+size(estrella,2)-1)=estrella(1:size(estrella,1),1:size(estrella,2));
    
end
figure,imshow(Iest);