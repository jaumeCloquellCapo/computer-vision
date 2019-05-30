pathPos = "pos";
pathNeg = "neg";
imlist = dir('pos/*.ppm');
for i = 1:length(imlist)
    im = imread('pos/'+imlist(i));
    fpos{i} = HOG(double(im));
end
% extract features for negative examples
imlist = dir('neg/*.jpg');
for i = 1:length(imlist)
    im = imread('neg/' + imlist(i));
    fneg{i} = HOG(double(im));
end