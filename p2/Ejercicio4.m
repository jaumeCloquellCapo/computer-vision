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
gs = [79 221 61];
 ch=chroma_key2(F,B,size(B,2)-size(F,2),size(B,1)-size(F,2),gs);
imshow(ch)

    [rows, columns, numberOfColorChannels] = size(F);
    outDims = [rows columns];
    x = imresize(B,outDims);
    y = imresize(F,outDims);
    % Mix them together
    z = y;  % Preallocate space for the result
    % Find the green pixels in the foreground (y)
    yd = double(y)/255;
    % Greenness = G*(G-R)*(G-B)
    greenness = yd(:,:,2).*(yd(:,:,2)-yd(:,:,1)).*(yd(:,:,2)-yd(:,:,3));
    % Threshold the greenness value
    thresh = 0.3*mean(greenness(greenness>0));
    isgreen = greenness > thresh;
    % Thicken the outline to expand the greenscreen mask a little
    outline = edge(isgreen,'roberts');
    se = strel('disk',1);
    outline = imdilate(outline,se);
    isgreen = isgreen | outline;
    % Blend the images
    % Loop over the 3 color planes (RGB)
    for j = 1:3
        rgb1 = x(:,:,j);  % Extract the jth plane of the background
        rgb2 = y(:,:,j);  % Extract the jth plane of the foreground
        % Replace the green pixels of the foreground with the background
        rgb2(isgreen) = rgb1(isgreen);
        % Put the combined image into the output
        z(:,:,j) = rgb2;
    end
    imshow(z)
 

function compImage = chroma_key2(F, B, x, y, gs)
 scene = B;
 obj = F;
 %gs = [79 221 61];
 %x = 15;
 %y =15;

 [srows scols spg] = size(scene);
 [orows ocols opg] = size(obj);
 % create our "green screen"
 % first, make one page of all zeros
 % JPG uses data type uint8 to save memory space
 % uint8 is 8-bit unsigned integers vs. default 64-bit double-precision
 % note binary 2^8 = 256, and 0-255 is 256 numbers
 pg = zeros(srows,scols,'uint8');

 % make the green screen canvas
 canv = cat(3,pg+gs(1),pg+gs(2),pg+gs(3));
 %imshow(canv);
 % put object on canvas at x,y coordinates
 canv(1+y : orows+y, 1+x : ocols+x, :) = obj;
%imshow(canv);
 % find linear (sequential) indices of elements of object on canvas
 % whose values are not equal to green screen values
 ind1 = find(canv(:,:,1) ~= gs(1));
 ind2 = find(canv(:,:,2) ~= gs(2));
 ind3 = find(canv(:,:,3) ~= gs(3));
 % put object from canvas onto scene to form composite image

 % make copies of each page of canvas and scene
 % since we have linear indices for each page
 canv1 = canv(:,:,1);
 canv2 = canv(:,:,2);
 canv3 = canv(:,:,3);
 
 scene1 = scene(:,:,1);
 scene2 = scene(:,:,2);
 scene3 = scene(:,:,3);

 % replace elements in scene pages with elements from canvas pages
 scene1(ind1) = canv1(ind1);
 scene2(ind2) = canv2(ind2);
 scene3(ind3) = canv3(ind3);

 % concatenate (cat) the pages into one composite image
 compImage = cat(3,scene1,scene2,scene3);
end
   