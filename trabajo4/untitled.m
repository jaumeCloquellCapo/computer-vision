video_file = 'data/dedo_hr.mp4';
if ischar(video_file),
    display(['Loading file ' video_file]);
    v = VideoReader(video_file);
else
    v = video_file;
end

numFrames = v.NumberOfFrames;

display(['Total frames: ' num2str(numFrames)]);

rojo = zeros(1, numFrames);
verde = zeros(1, numFrames);
azul = zeros(1, numFrames);

for i=1:numFrames
    display(['Processing ' num2str(i) '/' num2str(numFrames)]);
    frame = read(v, i);
    
    redPlane = frame(:, :, 1);
    greenPlane = frame(:,:,2);
    bluePlane = frame(:,:,3);
    
    % tomamos las tres bandas
    rojo(i) = sum(sum(redPlane)) / (size(frame, 1) * size(frame, 2));   
    verde(i) = sum(sum(greenPlane)) / (size(frame,1) * size(frame,2)); 
    azul(i) = sum(sum(bluePlane)) / (size(frame,1) * size(frame,2));
end

% aplicamos el z-score banda a banda
rojo_norm = zscore(rojo);
verde_norm = zscore(verde);
azul_norm = zscore(azul);
    
% tenemos las tres bandas normalizadas, aplicamos PCA a continuación
% para aplicar PCA hemos de tener en cda columna la variable y las filas
% son las observaciones, luego tendremos que tener 3 columnas y tantas
% filas como número de frames
M = transpose([rojo_norm ; verde_norm ; azul_norm]);

coefs_pca = pca(M);

transformada = M*coefs_pca(:,1);
size(transformada)