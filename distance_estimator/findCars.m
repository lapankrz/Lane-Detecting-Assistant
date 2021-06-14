function [image_to_show, heatmap, binary_map] = findCars(model, I, n, ratios,...
        window_overlap, threshold, C, S)
    % Detect cars in an image using sliding window algorithm
    %
    % Input:
    % model            Trained classification model
    % I                Input photo (suggested resolutions are HD or Full HD)
    % n                Image size (width equal to height)
    % ratios           Scale fractions for sliding window algorithm
    % window_overlap   Fractional sliding window overlap
    % threshold        Minimal detection frequency for detected cars
    % C                Normalization parameter: mean
    % S                Normalization parameter: standard deviation
    %
    % Output:
    % image_to_show    Output photo
    % heatmap          Heatmap of detected cars
    % binary_map       Binarized version of heatmap

    image_to_show = I;
    base_I = I;
    window_offset = int32(n * (1 - window_overlap));
    [baseRows, baseCols, ~] = size(I);
    heatmap = zeros(baseRows, baseCols);
    
    for i = 1:size(ratios, 2)
        scale = ratios(i);
        I = imresize(base_I, scale);
        [rows, columns, ~] = size(I);
        y = 1;
        while (y <= rows)
            x = 1;
            old_y = y;
            if (y + n > rows)
                y = rows - n;
            end
            while (x <= columns)
                old_x = x;
                if (x + n > columns)
                    x = columns - n;
                end
                image = I(y:(y+n), x:(x+n), :);
                features = double(getImageFeatures(image));
                features = (features - C) ./ S; % features normalization
                label = predict(model, features);
                if (label == 'vehicles')
                    bounds = int32([x / scale, y / scale, n / scale, n / scale]);
                    image_to_show = insertObjectAnnotation(image_to_show, 'rectangle',...
                        bounds, "Car", 'LineWidth', 2, 'FontSize', 11);
                    for yIndex = bounds(2):(bounds(2)+bounds(4))
                        for xIndex = bounds(1):(bounds(1)+bounds(3))
                            if (yIndex <= baseRows && xIndex <= baseCols)
                                heatmap(yIndex, xIndex) = heatmap(yIndex, xIndex) + 1;
                            end
                        end
                    end
                end
                x = old_x + window_offset;
            end
            y = old_y + window_offset;
        end
    end
    
    heatmap(heatmap < threshold) = 0;
    binary_map = heatmap;
    binary_map(binary_map > 0) = 1;
    binary_map = imbinarize(binary_map);
    maxVal = max(heatmap,[],'all');
    heatmap = uint8(heatmap * 255 / maxVal);
end