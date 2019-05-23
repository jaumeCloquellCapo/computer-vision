%Obtener sobre la imagen formas.png las esquinas usando el método de Harris. 

im=imread('formas.png');

%se= strel('line',5,60); %elemento estructural tipo, numero de elementos, orientacion

%dilatamos 
%im=imdilate(i,se);



  mx = [-1 0 1
        -1 0 1
        -1 0 1];
    my = [1 1 1
        0 0 0
        -1 -1 -1];

    edgex_im = filter2(mx,im); %Correlate
    edgey_im = filter2(my,im); %Correlate
    mag_im = edgex_im.*edgey_im;
    
    %Display edge detection images
    %figure();
    %imshow(edgex_im,[]);
    %title('Edge Detection: X-Direction');
    %figure();
    %imshow(edgey_im,[]);
    %title('Edge Detection: Y-Direction');
    
    %Gaussian Filter  fspecial('gaussian',[5 5],2); 
    G = fspecial('gaussian',[2 2],3); 
    edgex_im = filter2(G,edgex_im.^2);
    edgey_im = filter2(G,edgey_im.^2);
    mag_im = filter2(G,mag_im);
    %figure();
    %imshow(mag_im,[]);       
    %title('Edge Magnitude');
    
    %Alocate space
    result = zeros(size(im,1),size(im,2)); 
    R = zeros(size(im,1),size(im,2));
    
    %Apply corner operation
    for ii = 1:size(im,1)
        for jj = 1:size(im,2)
            M = [edgex_im(ii,jj) mag_im(ii,jj);mag_im(ii,jj) edgey_im(ii,jj)]; 
            co(ii,jj) = det(M)-0.05*(trace(M))^2;
        end
    end
    %figure();
    %imshow(co);
    %title('Corner Output');
    
    co_max = max(max(co));
    Thresh = 0.1*co_max; %Compute threshold Note: found manually
    
    %Put positions of corners
    for ii = 2:size(im,1)-1
        for jj = 2:size(im,2)-1
            if co(ii,jj) > Thresh
                %Only grab 1 of the pixels detected
                if co(ii,jj) > co(ii-1,jj-1) && co(ii,jj) > co(ii-1,jj) && co(ii,jj) > co(ii-1,jj+1) && co(ii,jj) > co(ii,jj-1) && co(ii,jj) > co(ii,jj+1) && co(ii,jj) > co(ii+1,jj-1) && co(ii,jj) > co(ii+1,jj) && co(ii,jj) > co(ii+1,jj+1)                    
                    result(ii,jj) = 1;
                end
            end
        end
    end
    
    [c,r] = find(result == 1);
    
    %Ignore the beginning and end rows
    %c(10) = [];
    %c(9) = [];
    %c(2) = [];
    %c(1) = [];
    
    %r(10) = [];
    %r(9) = [];
    %r(2) = [];
    %r(1) = [];    
    
    figure();
    imshow(im);
    hold on;
    plot(r,c,'r.');
    title('Corners Detected');
    
    %%%%%%%%%%
    
  
    
    
    
    
    