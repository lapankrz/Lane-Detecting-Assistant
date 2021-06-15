function [Iout, Translation] = getBinaryLanesFromArea(Iwarp, vlimits, hlimits, scale)
    % Extraction of road lines from a selected part
    % of an image transformed to a bird's eye view
    %     
    % Input:
    % Iwarp -   image transformed to bird's eye view
    % vlimits - boundaries of the cut area in the image vertical variable
    % hlimits - boundaries of the cut area in the image horizontal variable
    % scale -   scale of the output image in relation to the input image
    % 
    % Output:
    % Iout -        image with extracted road lines
    % Translation - the translation vector to be added to the points
    %               in the output image to be in the coordinates
    %               of the input image
    
    % Author: Maciej Morawski
    Img = Iwarp(vlimits(1):vlimits(2), hlimits(1):hlimits(2), :);
    Img = imresize(Img, scale);
    [Iout, ~] = segmentLanes(Img);
    Translation = [hlimits(1), vlimits(1)];
end