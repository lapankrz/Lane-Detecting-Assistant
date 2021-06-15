function [A, B, C, D] = reference_points()
    % Reference points that represent the corners
    % of a rectangle in transformed image
    % WARNING: these points should define reactangle
    
    % Input:
    % 
    % Output:
    % pa -  top left corner of the reactangle
    % pb -  top right corner of the reactangle
    % pc -  bottom right corner of the reactangle
    % pd -  bottom left corner of the reactangle
    
    % Author: Maciej Morawski
    
    A = [320 1]';           % top left point
    B = [1280-320 1]';      % top right point
    C = [1280-320 720]';    % bottom right point
    D = [320 720]';         % bottom left point
        
end