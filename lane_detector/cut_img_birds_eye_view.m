function [Iout, H] = cut_img_birds_eye_view(Iin, TL, BR)
    % Transform an image to a bird's eye view
    % and cut it to selected area defined by
    % top left (TP) and bottom right (BR) corners
    %
    % Input:
    % Iin           Input photo (suggested resolutions are HD or Full HD)
    % TL            Top left point of selected area
    % BR            Bottom right point of selected area
    %
    % Output:
    % Iout          Output photo (transformed to bird's eye view and cut)
    % H             Homography matrixs
    
    % Author: Maciej Morawski
    
    cutting_level = 400;
    [Iwarp, H, Rout] = transform_to_birds_eye(Iin,cutting_level);
    
    pa = [TL(1), TL(2)-cutting_level]';
    pc = [BR(1), BR(2)-cutting_level]';
    [paT(1), paT(2)] = transformPointsForward(H,pa(1),pa(2));
    [pcT(1), pcT(2)] = transformPointsForward(H,pc(1),pc(2));
 
    [X, Y] = Rout.worldToIntrinsic([paT(1), pcT(1)]', [paT(2), pcT(2)]');
    X = round(X);
    Y = round(Y);    
    
    Iout = Iwarp(Y(1):Y(2), X(1):X(2), :);
end