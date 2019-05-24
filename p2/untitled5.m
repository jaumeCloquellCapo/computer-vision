
F=imread('chromakey_original.jpg');
B=imread('praga1.jpg');

%data = coder.load('background.mat','bg');
%scene = data.bg;
% Main loop
%imgFinal = chromaKey(img, scene, refColorYCbCr, t1, t2);


fg = imread('chromakey_original.jpg');
bg = imread('praga1.jpg');
refColorRGB = [79 221 61]; % RGB light Green
tmpColor = zeros([1,1,3],('uint8'));
tmpColor(1,1,:) = uint8(refColorRGB);
refColor = rgb2ycbcr(tmpColor);
threshold1 = 14;
threshold2 = 20;
 % function %
P = fg; 
Pscene = bg; 
refColorYCbCr = refColor;
t1 = threshold1;
t2 = threshold2;

Cbref = double(refColorYCbCr(1,1,2));
Crref = double(refColorYCbCr(1,1,3));
PYCbCr = rgb2ycbcr(P);
Cb = double(PYCbCr(:,:,2));
Cr = double(PYCbCr(:,:,3));
d = (Cb - Cbref).^2 + (Cr - Crref).^2;
t1 = t1^2;
t2 = t2^2;
m = zeros([size(d,1) size(d,2)]);
for j = 1:size(m,1)
    for k = 1:size(m,2)
        if d(j,k) > t2
            m(j,k) = 1;
        elseif d(j,k) > t1
            m(j,k) = (d(j,k) - t1) / (t2 - t1);
        end
    end
end
m = repmat(imgaussfilt(m,0.8), [1 1 3]);
%m=uint8(m);
%    how to combine im and mask
Pfinal = uint8(double(P).*m + double(Pscene).*(1-m));
% function end %
 
%figure(1),image(img);
figure(2),image(Pfinal);