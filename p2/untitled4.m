%The frst step is to create 3D image array of the same size of the scene image array and the same color -
%the "green screen" color - as the background of the object image. This is the "canvas" in our example
%Matlab scripts.

ch=imread('chromakey_original.jpg');
bg=imread('praga1.jpg');

x=0;
y= 0;
r = 0;
g = 255;
b = 0;

[bg_w, bg_h, bg_c] = size(bg);
[ch_w, ch_h, ch_c] = size(ch);

A=ch(1,1);

A(:,:,1)=r;
A(:,:,2)=g;
A(:,:,3)=b;

ch_col = rgb2hsv(A);

hsv=rgb2hsv(ch);

aux = 0.5 - ch_col(1,1,1);
hsv(:,:,1)=mod(hsv(:,:,1)+aux,1.0);


if (ch_w + x > bg_w) || (ch_h + y > bg_h)
    disp("Por favor, introduzca otras coordenadas")
else
    
    
    for x_ = 1:ch_h
        for y_ = 1:ch_w
            cond = 1-2*abs(hsv(y_,x_,1)-0.5);
            if (cond < 0.9 || cond > 1.1)
                bg(y_+y,x_+x,:) = ch(y_,x_,:);
            end
        end
    end
end

imshow(bg)
        
    
    

