function new_bounds = getCarInFront(bounds)
    % Get the bounding box of the car in front
    %
    % Input:
    % bounds        Bounding boxes containing cars
    %
    % Output:
    % new_bounds    Bounding box of the car in front
    
    leftMargin = 550;
    rightMargin = 730;
    new_bounds = [];
    for i = 1:size(bounds,1)
        leftEnd = bounds(i,1);
        rightEnd = bounds(i,1) + bounds(i,3);
        if (leftEnd > leftMargin && leftEnd < rightMargin) || ...
            (rightEnd < rightMargin && rightEnd > leftMargin)
            new_bounds = [new_bounds; bounds(i,:)];
        end
    end
    if size(new_bounds,1) > 1
        img_center = 1280 / 2;
        best_idx = 1;
        for i = 2:size(new_bounds,1)
            best_center = new_bounds(best_idx,1) + new_bounds(best_idx,3) / 2;
            new_center = new_bounds(i,1) + new_bounds(i,3) / 2 ;
            if abs(img_center - new_center) < abs(img_center - best_center)
                best_idx = i;
            end
        end
        new_bounds = new_bounds(best_idx, :);
    end
end