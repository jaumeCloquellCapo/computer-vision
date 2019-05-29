%The frst step is to create 3D image array of the same size of the scene image array and the same color -
%the "green screen" color - as the background of the object image. This is the "canvas" in our example
%Matlab scripts.

imageRGB=imread('chromakey_original.jpg');
background=imread('praga1.jpg');

initx=0;
inity= 0;
red = 0;
green = 255;
blue = 0;

imHSV = rgb2hsv(imageRGB);
A = 0.5-0.3333;
range = mod(imHSV(:,:,1) + A, 1.0); 
gr = 1-2*abs(range - 0.5);
[indexX, indexY] = find(gr < 0.82);

imgChroma = background;
for i=1:length(indexX)
    imgChroma(indexX(i)+initx,indexY(i)+inity,:) = imageRGB(indexX(i),indexY(i),:);
end
figure, imshow(imgChroma);
    
    

