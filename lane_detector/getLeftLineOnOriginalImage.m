function leftLineOriginal = getLeftLineOnOriginalImage(img)
    % Getting the coordinates of the left line (border right)
    % in the input photo which is the left side of the driver's view
    %
    % Input:
    % img -     image showing left side of driver's view
    % 
    % Output:
    % leftLineOriginal -    coordinates of the found line
    
    % Author: Maciej Morawski

    [Iwarp, H, Rout] = transform_to_birds_eye(img,400);
    [leftImg, TransLeft] = getBinaryLanesFromArea(Iwarp, [550, round(Rout.YWorldLimits(2))], [round(-Rout.XWorldLimits(1)), round(-Rout.XWorldLimits(1))+1280/2], 1);
    leftLines = getLines(leftImg);
    leftLine = chooseBoundaryLine(leftLines, "Right");
    leftLineOriginal = transformLineToOriginalImage(leftLine, H, Rout, TransLeft, 400);
end