function [y,v] = acquire(video_file)

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


 yi = (y - mean(y)) ./ std(y);
 xi = (x - mean(x)) ./ std(x);
 zi = (z - mean(z)) ./ std(z);

%Do the PCA

C = cov([yi' xi' zi']);

[V, D] = eig(C);

MADy=(y-My); % mean adjusted data of x
MADx=(x-My); % mean adjusted data of y
MADz=(z-Myz); % mean adjusted data of y

result = ((V)'*[MADx ; MADy]);

%[V,D] = eig([yi, xi, zi]);



display('Signal acquired.');
display(' ');
display(['Sampling rate is ' num2str(v.FrameRate) '. You can now run process(your_signal_variable, ' num2str(v.FrameRate) ')']);

end

