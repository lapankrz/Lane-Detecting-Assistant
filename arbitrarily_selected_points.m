function [pa, pb, pc, pd] = arbitrarily_selected_points()
    % Arbitrialy selected points on untransoformed image,
    % that represent the corners of a rectangle in the real world
    % WARNING: points selected in the image with the upper half cut off
    
    % Input:
    % 
    % Output:
    % pa -  top left corner of the reactangle
    % pb -  top right corner of the reactangle
    % pc -  bottom right corner of the reactangle
    % pd -  bottom left corner of the reactangle
    %
    % Author: Maciej Morawski
    
    pa = [576 1]';          % top left point
    pb = [670 1]';          % top right point
    pc = [1100 200]';       % bottom right point 
    pd = [212 200]';        % bottom left point
        
end