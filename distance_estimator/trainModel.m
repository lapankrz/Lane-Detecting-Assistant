function [model, C, S, acc] = trainModel()
    % Train classification model
    %
    % Output:
    % model      Classification model
    % C          Normalization parameter: mean
    % S          Normalization parameter: standard deviation
    % acc        Model accuracy
    
    rng(123);
    images_full = shuffle(imageDatastore("train_images/", "IncludeSubfolders", true, "LabelSource", "foldernames"));
    [trainImages, testImages] = splitEachLabel(images_full, 1500, 800);
    
    trainN = size(trainImages.Labels, 1);
    trainFeatures = zeros(trainN, 5292);
    for i = 1:trainN
        img = imread(trainImages.Files{i});
        trainFeatures(i, :) = getImageFeatures(img);
    end
    disp('Train images features extracted')
    
    testN = size(testImages.Labels, 1);
    testFeatures = zeros(testN, 5292);
    for i = 1:testN
        img = imread(testImages.Files{i});
        testFeatures(i, :) = getImageFeatures(img);
    end
    disp('Test images features extracted')
    
    [~, C, S] = zscore(vertcat(trainFeatures, testFeatures));
    for i = 1:size(C, 2)
        c = C(i);
        s = S(i);
        trainFeatures(:, i) = (trainFeatures(:, i) - c) / s;
        testFeatures(:, i) = (testFeatures(:, i) - c) / s;
    end
    
    model = fitclinear(trainFeatures, trainImages.Labels);
    disp('Training complete')
    results = predict(model, testFeatures);
    correct = results == testImages.Labels;
    acc = nnz(correct) / length(correct);
end