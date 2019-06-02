function [newdata, y, v, FrameRate] = acquire(video_file)
video_file = 'data/dedo_hr.mp4';
if ischar(video_file),
    display(['Loading file ' video_file]);
    v = VideoReader(video_file);
else
    v = video_file;
end

numFrames = v.NumberOfFrames;

display(['Total frames: ' num2str(numFrames)]);

y = zeros(1, numFrames);
x = zeros(1, numFrames);
z = zeros(1, numFrames);

for i=1:numFrames,
    display(['Processing ' num2str(i) '/' num2str(numFrames)]);
    frame = read(v, i);
    y(i) = sum(sum(frame(:, :, 1))) / (size(frame, 1) * size(frame, 2)); 
    x(i) = sum(sum(frame(:, :, 2))) / (size(frame, 1) * size(frame, 2)); 
    z(i) = sum(sum(frame(:, :, 3))) / (size(frame, 1) * size(frame, 2));
end


% Primero debemos centrar los datos, es decir, restar las medias univariadas 
% En los siguientes pasos, por lo tanto, estudiamos las desviaciones de la media (s) solamente.

data = matrix([y, x, z]);

yi = (y - mean(y)) ./ std(y);
xi = (x - mean(x)) ./ std(x);
zi = (z - mean(z)) ./ std(z);


data = [yi xi zi];
%PCA

% A continuación calculamos la matriz de covarianza de los datos. 
% La matriz de covarianza contiene toda la información necesaria para rotar el sistema de coordenadas.
C = cov(data);

% Los valores propios D de la matriz de covarianza, es decir, la versión diagonal de C, da la varianza dentro de los nuevos ejes de coordenadas, es decir, los componentes principales. Ahora calculamos los vectores propios V y los valores propios D de la matriz de covarianza C.
[V,D] = eig(C);

% Cálculo del conjunto de datos en el nuevo sistema de coordenadas. Necesitamos voltear los datos nuevos hacia la izquierda / derecha ya que la segunda columna es la que tiene el valor propio más grande.
newdata = V * data';
newdata = newdata';
FrameRate = v.FrameRate;

display('Signal acquired.');
display(' ');
display(['Sampling rate is ' num2str(v.FrameRate) '. You can now run process(your_signal_variable, ' num2str(v.FrameRate) ')']);

end

