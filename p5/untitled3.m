
load wbarb;
whos
image(X);colormap(map); colorbar;
img  = imread('cameraman.tif');
% niveles de descompresion 
n= 2;

%% IMGDWT
% Calcula la DWT de una imagen.

w='bior3.7';
[c,s] = wavedec2(img,n,w);
V=[];
for i=n:-1:1
    LL = appcoef2(c,s,w,i);
    [HL,LH,HH] = detcoef2('all',c,s,i);
    if i==n
        V=[LL,HL;LH,HH];
    end
    if i~=n
        V=cat(1,cat(2,V,HL),cat(2,LH,HH));
    end
end


[V,c,s] = imgdwt(n,img);
handles.c=c;
handles.s=s;
handles.n=n;
guidata(hObject,handles);
axes(handles.image_out);
axis image;
colormap gray;
imagesc(V);
set(handles.compressed_image,'String','[LL,HL;LH,HH]');