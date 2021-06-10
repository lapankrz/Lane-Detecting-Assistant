
function [Iout, dist] = getDistanceToCar(I, bounds)
    [Iout, H, Rout] = transform_to_birds_eye(I, 400);
    
    x = bounds(1) + bounds(3) / 2;
    y = bounds(2) + bounds(4) - 400;
    [new_x, new_y] = transformPointsForward(H, x, y);
    
    new_x = new_x - Rout.XWorldLimits(1);
    new_y = new_y - Rout.YWorldLimits(1);
    
    pixel_to_meters_y = 0.0544;
    pixel_to_meters_x = 0.0074;
    [observer_y, observer_x, ~] = size(Iout);
    observer_x = observer_x / 2;
    dist_x = pixel_to_meters_x * (observer_x - new_x);
    dist_y = pixel_to_meters_y * (observer_y - new_y);
    dist = sqrt(dist_x^2 + dist_y^2);
    
    Iout = insertObjectAnnotation(Iout, "circle", [new_x new_y 10], dist);
    Iout = Iout;
end