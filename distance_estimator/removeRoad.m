

function new_bounds = removeRoad(I, bounds)
    threshold = 25;
    diff_percentage = 0.2;
    new_bounds = bounds(:, :);
    for i = 1:size(bounds, 1)
        b = bounds(i,:);
        img = imcrop(I, b);
        [rows, cols, ~] = size(img);
        if (rows < 5)
            continue;
        end
        bottom = img((end-4):end, :, :);
        r_median = median(bottom(:, :, 1), 'all');
        g_median = median(bottom(:, :, 2), 'all');
        b_median = median(bottom(:, :, 3), 'all');
        for j = (rows-4):-1:1
            line = img(j, :, :);
            count = 0;
            for k = 1:cols
                pixel = line(:, k, :);
                r = pixel(1, 1, 1);
                g = pixel(1, 1, 2);
                b = pixel(1, 1, 3);
                if (r < r_median - threshold || r > r_median + threshold ||...
                    g < g_median - threshold || g > g_median + threshold ||...
                    b < b_median - threshold || b > b_median + threshold)
                    count = count + 1;
                end
            end
            if (count > diff_percentage * cols)
                new_bounds(i, 4) = j;
                break;
            end
        end
    end
end