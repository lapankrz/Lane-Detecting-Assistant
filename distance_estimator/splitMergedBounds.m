function new_bounds = splitMergedBounds(heatmap, bounds)
    max_width = 250;
    limit_threshold = 0.4;
    new_bounds = double.empty(0,4);
    for i = 1:size(bounds, 1)
        b = bounds(i, :);
        if (b(3) <= max_width)
            new_bounds = [new_bounds; b];
        else
            cropped = imcrop(heatmap, b);
            values = unique(nonzeros(cropped));
            limit = int32(size(values,1) * limit_threshold);
            limit = values(limit); % n-th smallest pixel value
            cropped = max(cropped - limit, 0);
            
            binary_map = cropped;
            binary_map(binary_map > 0) = 1;
            binary_map = imbinarize(binary_map);
            
            split_bounds = regionprops('table', binary_map, 'BoundingBox').BoundingBox;
            for j = 1:size(split_bounds, 1)
                new_b = split_bounds(j, :);
                if (new_b(3) > 5 && new_b(4) > 5)
                    new_b = [b(1) + new_b(1), b(2) + new_b(2), new_b(3), new_b(4)];
                    new_bounds = [new_bounds; new_b];
                end
            end
        end
    end
end