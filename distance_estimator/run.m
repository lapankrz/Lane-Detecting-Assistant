% rng(123)
% 
% images_full = shuffle(imageDatastore("train_images/", "IncludeSubfolders", true, "LabelSource", "foldernames"));
% [trainImages, testImages] = splitEachLabel(images_full, 1500, 800);
% 
% trainN = size(trainImages.Labels, 1);
% trainFeatures = zeros(trainN, 5292);
% for i = 1:trainN
%     img = imread(trainImages.Files{i});
%     trainFeatures(i, :) = getImageFeatures(img);
% end
% disp('Train images features extracted')
% 
% testN = size(testImages.Labels, 1);
% testFeatures = zeros(testN, 5292);
% for i = 1:testN
%     img = imread(testImages.Files{i});
%     testFeatures(i, :) = getImageFeatures(img);
% end
% disp('Test images features extracted')
% 
% [~, C, S] = zscore(vertcat(trainFeatures, testFeatures));
% for i = 1:size(C, 2)
%     c = C(i);
%     s = S(i);
%     trainFeatures(:, i) = (trainFeatures(:, i) - c) / s;
%     testFeatures(:, i) = (testFeatures(:, i) - c) / s;
% end
% 
% model = fitclinear(trainFeatures, trainImages.Labels);
% disp('Training complete')
% results = predict(model, testFeatures);
% figure;
% confusionchart(removecats(testImages.Labels), removecats(results));
% correct = results == testImages.Labels;
% acc = nnz(correct) / length(correct);
% disp(acc);

n = 64;
topOffset = 0.45;
bottomOffset = 0.1;
window_overlap = 0.75;
ratios = [1 0.9 0.8 0.7 0.6 0.5 0.4]; %[1 0.9 0.8 0.7 0.6 0.5 0.4];

test_images = imageDatastore("test_images/");
testCount = size(test_images.Files, 1);
threshold = 3;
images = cell([3 * testCount]);

for i = 1:testCount
    I = readimage(test_images, i);
    I = imresize(I, [720, 1280]); % HD resolution
    I_cropped = I((size(I,1) * topOffset):(size(I,1) * (1 - bottomOffset)), :, :);
    [annotated, heatmap, binary_map] = findCars(model, I_cropped, n, ratios, window_overlap, threshold, C, S);
    
    bounds = regionprops('table', binary_map, 'BoundingBox').BoundingBox;
    if (size(bounds, 1) > 0)
        
        bounds = splitMergedBounds(heatmap, bounds);
        bounds = removeRoad(I, bounds);
        bounds(:, 2) = bounds(:, 2) + topOffset * 720;
        annotated2 = insertObjectAnnotation(I, 'rectangle', bounds, "Car",...
            'LineWidth', 3, 'FontSize', 18);
        images{3 * i - 2} = annotated2;
        
        bounds = getCarInFront(bounds);
        if (size(bounds,1) > 0)
            annotated3 = insertObjectAnnotation(I, 'rectangle', bounds, "Car",...
                'LineWidth', 3, 'FontSize', 18);
            images{3 * i - 1} = annotated3;
            
            [Iout, dist] = getDistanceToCar(I, bounds);
%             images{3 * i} = Iout;
            x = bounds(1) + bounds(3) / 2;
            y = bounds(2) + bounds(4);
            annotated3 = insertObjectAnnotation(I, 'circle', [x y 5], dist,...
                'LineWidth', 3, 'FontSize', 24);
            images{3 * i} = annotated3;
        end
    end
    disp(i)
end

figure;
montage(images, 'Size', [testCount 3]);
