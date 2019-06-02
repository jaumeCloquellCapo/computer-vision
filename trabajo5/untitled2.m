imds = imageDatastore('images/','IncludeSubfolders',true,'LabelSource',...
    'foldernames');

[imdsTrain,imdsTest] = splitEachLabel(imds,0.8,'randomize');

imageSize = [128 64];
image1 = readimage(imdsTrain,1);  
scaleImage = imresize(image1,imageSize);  
[features, visualization] = extractHOGFeatures(scaleImage); %features = 3780
 
% imshow(scaleImage);hold on; plot(visualization)  

numImages = length(imdsTrain.Files);  
featuresTrain = zeros(numImages,size(features,2),'single'); % featuresTrain 
for i = 1:numImages  
    imageTrain = readimage(imdsTrain,i);  
    imageTrain = imresize(imageTrain,imageSize);  
    featuresTrain(i,:) = extractHOGFeatures(imageTrain);  
end  

trainLabels = imdsTrain.Labels;  
svmParams = templateSVM('KernelFunction','rbf', 'KernelScale', 'auto', 'Standardize', 1);
%classifer = fitcecoc(featuresTrain,trainLabels, 'Learners', svmParams, 'Coding', 'onevsall');  

classifer = fitcsvm(featuresTrain,trainLabels,'Standardize',true,'KernelFunction','RBF', 'KernelScale','auto');
numTest = length(imdsTest.Files);  

k = zeros(numTest,1) ;
j = zeros(numTest,1) ;
for i = 1:numTest 
    testImage = readimage(imdsTest,i);  
    scaleTestImage = imresize(testImage,imageSize);  
    featureTest = extractHOGFeatures(scaleTestImage);  
    [predictIndex,score] = predict(classifer,featureTest);
    
    k(i) = predictIndex == 'pos';
    j(i) = imdsTest.Labels(i) == 'pos';

    % figure;imshow(testImage);  
    % title(['predictImage: ',char(predictIndex)]);  
end  


C = confusionmat(k,j);
