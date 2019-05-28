%Lecura de las imagenes
index = 1;
for n = 'a':'e'
    path = strcat('camiones/', n, '.jpg');
    adraImg = imread(path);
    adraImg = rgb2gray(adraImg);
    adraImg = im2double(adraImg);
    adraImages(:,:,index) = adraImg;
    index = index + 1;
end

sizeVector = size(adraImages);


%Hotelling
%Mean and expectation mean  of pixel vectors
mean = zeros(1,sizeVector(3), 'double');
for i = 1:sizeVector(1)
    for j = 1:sizeVector(2)
        vector = adraImages(i,j,:);
        vector = squeeze(vector(1,1,:)).';
        mean = mean + vector;
    end
end

mean = mean / (sizeVector(1) * sizeVector(2));
expectationMean = ((mean') * mean) / (sizeVector(1) * sizeVector(2));

expectation = zeros(sizeVector(3),sizeVector(3), 'double');
for i = 1:sizeVector(1)
    for j = 1:sizeVector(2)
        vector = adraImages(i,j,:);
        vector = squeeze(vector(1,1,:)).';
        expectation = expectation + vector' * vector;
    end
end
expectation = expectation / (sizeVector(1) * sizeVector(2));

%Matriz de Covarianza
covMatrix = expectation - expectationMean;

%Obtenemos los Autovalores y Autovectores
[eigenVectors, eigenValues] = eig(covMatrix);

%Ordenamos los Autovectores por los Autovalores
eigenVectors = fliplr(eigenVectors);
eigenValues = flipud(fliplr(eigenValues));

% Aplicamos sobre los Autovectores la transformada de la siguiente forma y=A(x?mx) para descubrir las nuevas imágenes, 
newAdraImages = adraImages;
for n = 1:sizeVector(3)
    for i = 1:sizeVector(1)
        for j = 1:sizeVector(2)
            vector = adraImages(i,j,:);
            vector = squeeze(vector(1,1,:)).';
            newAdraImages(i,j,:) = (vector - mean) * eigenVectors;
        end
    end
end

figure, 
subplot(2,3,1),imshow(newAdraImages(:,:,1));
subplot(2,3,2), imshow(newAdraImages(:,:,2), []);
subplot(2,3,3), imshow(newAdraImages(:,:,3), []);
subplot(2,3,4), imshow(newAdraImages(:,:,4), []);
subplot(2,3,5), imshow(newAdraImages(:,:,5), []);
    
