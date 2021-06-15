function [lines] = getLines(Img)
    % Line detection in the image using the canny algorithm
    % and Hough transform
    %
    % Input:
    % Img -   input image
    % 
    % Output:
    % lines - detected lines
    
    % Author: Maciej Morawski
    BW = edge(Img,'canny', 'vertical');
    [H,theta,rho] = hough(BW, 'RhoResolution', 1, 'Theta',-15:0.5:15);
    P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
    lines = houghlines(BW,theta,rho,P,'FillGap',50,'MinLength',20);
end