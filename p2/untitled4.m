%The frst step is to create 3D image array of the same size of the scene image array and the same color -
%the "green screen" color - as the background of the object image. This is the "canvas" in our example
%Matlab scripts.
F=imread('chromakey_original.jpg');
B=imread('praga1.jpg');

 scene = B;
 obj = F;
 gs = [79 221 61];
 x = 15;
 y =15;

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
 imshow(compImage);