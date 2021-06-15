function [lineOut] = transformLineToOriginalImage(line, H, Rout, Translation, cuttingLevel)
    % Transforming a line to the coordinate system in original image
    %
    % Input:
    % line -        input line
    % H -           Homography matrix       
    % Rout -        Spatial referencing information of transformed image
    % Translation - the translation vector to be added to the points
    %               in the output image of getting lanes from area
    %               to be in the coordinates of transformed to bird's eye
    %               view image
    % cutting_level the number of rows of pixels to be cut off
    %               from the top edge of the image
    %               (selected value: 400)
    %
    % Output:
    % lineOut - linein the coordinate system in original image
    
    % Author: Maciej Morawski

    x1 = line.point1(1) + Translation(1);
    x2 = line.point2(1) + Translation(1);
    y1 = line.point1(2) + Translation(2);
    y2 = line.point2(2) + Translation(2);
    
    x1 = x1 + Rout.XWorldLimits(1);
    x2 = x2 + Rout.XWorldLimits(1);
    y1 = y1 + Rout.YWorldLimits(1);
    y2 = y2 + Rout.YWorldLimits(1);
     
    [lineOut.point1(1), lineOut.point1(2)] = transformPointsInverse(H,x1,y1);
    [lineOut.point2(1), lineOut.point2(2)] = transformPointsInverse(H,x2,y2);
     
    lineOut.point1(2) = lineOut.point1(2) + cuttingLevel;
    lineOut.point2(2) = lineOut.point2(2) + cuttingLevel;
end