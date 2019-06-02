destdirs = 'January';
mkdir(destdirs);

dinfo = dir('images/pos/*.ppm');
filenames = {dinfo.name};
%remove filenames that are not a 4 digit year followed by a 2 digit month followed by a
%2 digit day followed by .mat. Years starting in 0, 1, or 2 are accepted with this check
maxImages = 400;
randomNumbers = randperm(length(filenames), maxImages);
for i = 1:maxImages
   n = randomNumbers(i);
   full_name= fullfile('images/pos', filenames(i).name);
   thisfile = imread(full_name);
   % thisfile = filenames{i};
   copyfile(['images/pos' filenames(i).name], destdirs);
end

imageDatastore = imageDatastore('images/','IncludeSubfolders',true,'LabelSource',...
    'foldernames');

maxImages = 400;
randomNumbers = randperm(total_images, maxImages);

removeImages(imageIndex,[1 3]);

[trainingSet,imdsTest] = splitEachLabel(imdsTrain,0.7,'randomize');

imageSize = [128 64];
image1 = readimage(imdsTrain,1);  
scaleImage = imresize(image1,imageSize);  
[features, visualization] = extractHOGFeatures(scaleImage); %features = 3780
 
% imshow(scaleImage);hold on; plot(visualization)  

numImages = length(imdsTrain.Files);  

featuresTrain = zeros(numImages,size(features,2),'single'); % featuresTrain????  
for i = 1:numImages  
    imageTrain = readimage(imdsTrain,i);  
    imageTrain = imresize(imageTrain,imageSize);  
    featuresTrain(i,:) = extractHOGFeatures(imageTrain);  
end  

trainLabels = imdsTrain.Labels;  
 svmParams = templateSVM('KernelFunction','rbf', 'KernelScale', 'auto', 'Standardize', 1);
classifer = fitcecoc(featuresTrain,trainLabels, 'Learners', svmParams, 'Coding', 'onevsall'));  

numTest = length(imdsTest.Files);  
for i = 1:numTest  
    testImage = readimage(imdsTest,i);  
    scaleTestImage = imresize(testImage,imageSize);  
    featureTest = extractHOGFeatures(scaleTestImage);  
    [predictIndex,score] = predict(classifer,featureTest);  
    figure;imshow(testImage);  
    title(['predictImage: ',char(predictIndex)]);  
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

imsdsPos = imageDatastore('images/pos','IncludeSubfolders',true,'LabelSource',...
    'foldernames');

imdsNeg = imageDatastore('images/neg','IncludeSubfolders',true,'LabelSource',...
    'foldernames');


imageSize = [128 64];
image1 = readimage(imdsNeg,1);  
scaleImage = imresize(image1,imageSize);  
[features, visualization] = extractHOGFeatures(scaleImage);
numImages = length(imdsNeg.Files); 
HOG_X_neg = zeros(numImages,size(features,2),'single'); % featuresTrain????  
for i = 1:numImages  
    imageTest = readimage(imdsNeg,i);  
    imageTest = imresize(imageTest,imageSize);  
    HOG_X_neg(i,:) = extractHOGFeatures(imageTest);  
end  



image1 = readimage(imsdsPos,1);  
[features, visualization] = extractHOGFeatures(image1);
numImages = length(imsdsPos.Files); 
HOG_X_pos = zeros(numImages,size(features,2),'single'); % featuresTrain????  
for i = 1:numImages  
    imageTest = readimage(imsdsPos,i);  
    HOG_X_pos(i,:) = extractHOGFeatures(imageTest);  
end  


dummy=[imsdsPos; imdsNeg];

trainLabels = imdsTrain.Labels;  
 svmParams = templateSVM('KernelFunction','rbf', 'KernelScale', 'auto', 'Standardize', 1);
classifer = fitcecoc(featuresTrain,trainLabels, 'Learners', svmParams, 'Coding', 'onevsall'));  


%%%%%%%%%
% read all images with specified extention, its jpg in our case
filenames = dir('images/pos/*.ppm');
% count total number of photos present in that folder
total_images = numel(filenames);

maxImages = 400;
randomNumbers = randperm(total_images, maxImages);
HOG_X_pos = cell(1,total_images); %// New - Declare feature matrix
%HOG_X_pos = zeros(maxImages, 3780, 'single');
y_pod = [];
for i = 1:maxImages
    n = randomNumbers(i);
    % Specify images names with full path and extension 
    fprintf(1, 'Now reading %s\n', filenames(n).name);
    full_name= fullfile('images/pos', filenames(1).name);

    % Read images
    training_images = imread(full_name);
    HOG_X_pos{1} = extractHOGFeatures(training_images);
    
    %// New - Add feature vector to matrix
    % HOG_X_pos{i} = featureVector;
    %y_pos{n} = full_name;
    y_pos = [y_pos, -1];
end

filenames = dir('images/neg/*.jpg');
total_images = numel(filenames);
HOG_X_neg = cell(1,total_images); 
%HOG_X_neg = zeros(total_images, 3780, 'single');
y_neg = [];
for n = 1:total_images 
    fprintf(1, 'Now reading %s\n', filenames(n).name);
    full_name= fullfile('images/neg', filenames(1).name);
    training_images = imread(full_name);
    imresired = imresize(training_images, [128 64]);
    HOG_X_neg{n} = extractHOGFeatures(imresired);
    %HOG_X_neg{n} = featureVector;
    y_neg = [y_neg, -1];
end

fpos= HOG_X_pos; 
fneg = HOG_X_neg;

out_max = 1;            
out_min = -1;       

V = cell (3,[]);

fprintf ('Loading positive images ');

for k=1:length(fpos)
    fprintf ('.');    
    IM{1} = fpos{k}';    
    
    for i=1:1
        V{1,end+1}= 'p';
        V{2,end} = out_max;
        V(3,end) = {IM{i}};
    end    
end

fprintf ('\nLoading negetive examples ');
for j=1:length(fneg)
    fprintf ('.');
    IM{1} = fneg{j}';
    
    for i=1:1
        V{1,end+1}= 'n';
        V{2,end} = out_min;
        V(3,end) = {IM{i}};
    end    
end
fprintf('\n');

SV =V;
fprintf('Training SVM..\n');
T = cell2mat(SV(2,:));
tP = SV(3,:)';
P = tP; % each row of P correspond to a training example 
model = svmlearn(P, T', '-t -g 0.3 -c 0.5');
fprintf('done. \n');




X=[HOG_X_pos;HOG_X_neg];
trainingLabels = trainingSet.Labels;
% fitcecoc uses SVM learners and a 'One-vs-One' encoding scheme.
classifier = fitcecoc(trainingFeatures, trainingLabels);

%y_pos = zeros(total_images);
%y_neg = -1*ones(1,maxImages);

X=P;

y=T';

ntrain= round(0.8*length(y));
ntest = size(X,1)-ntrain;

idx = randperm(length(y)) %obtenemos una permutación
X_train= X(idx(1:ntrain),:);
y_train=y(idx(1:ntrain));

X_test= X(idx(ntrain+1:length(y)),:);
y_test=y(idx(ntrain+1:length(y)));

SVMModel = fitcsvm(X_train,y_train,'Standardize',true,'KernelFunction','RBF', 'KernelScale','auto');
y_pred_train=predict(SVMModel,X_train);
% y de igual forma para el conjunto test sería
y_pred_test=predict(SVMModel,X_test);
confusionmat(y_train,y_pred_train);
confusionmat(y_test,y_pred_test);