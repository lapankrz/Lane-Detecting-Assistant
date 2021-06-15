function [dist, bounds] = estimateDistance(I, model, C, S)
    % Find car in front and estimate distance to it
    %
    % Input:
    % I             Input photo (suggested resolutions are HD or Full HD)
    % model         Classification model
    % C             Normalization parameter: mean
    % S             Normalization parameter: standard deviation
    %
    % Output:
    % dist          Distance to the car in front
    % bounds        Bounding box of the car in front
    
    n = 64; % image size (width equal to height)
    topOffset = 0.45;
    bottomOffset = 0.1;
    window_overlap = 0.75;
    ratios = [1 0.9 0.8 0.7 0.6 0.5 0.4];
    threshold = 3;
    
    I_cropped = I((size(I,1) * topOffset):(size(I,1) * (1 - bottomOffset)), :, :);
    [~, heatmap, binary_map] = findCars(model, I_cropped, n, ratios, window_overlap, threshold, C, S);

    bounds = regionprops('table', binary_map, 'BoundingBox').BoundingBox;
    if (size(bounds, 1) > 0)
        bounds = splitMergedBounds(heatmap, bounds);
        bounds = removeRoad(I, bounds);
        bounds(:, 2) = bounds(:, 2) + topOffset * 720;
        bounds = getCarInFront(bounds);
        if (size(bounds,1) > 0)
            [~, dist] = getDistanceToCar(I, bounds);
        else
            dist = -1;
        end
    end
end