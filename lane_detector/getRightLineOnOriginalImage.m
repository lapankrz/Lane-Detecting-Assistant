function rightLineOriginal = getRightLineOnOriginalImage(img)
    % Getting the coordinates of the right line (border left)
    % in the input photo which is the right side of the driver's view
    %
    % Input:
    % img -     image showing right side of driver's view
    % 
    % Output:
    % rightLineOriginal -    coordinates of the found line
    
    % Author: Maciej Morawski

    [Iwarp, H, Rout] = transform_to_birds_eye(img,400);
    [rightImg, TransRight] = getBinaryLanesFromArea(Iwarp, [550, round(Rout.YWorldLimits(2))], [round(-Rout.XWorldLimits(1))+1280/2, round(-Rout.XWorldLimits(1))+1280], 1);
    rightLines = getLines(rightImg);
    rightLine = chooseBoundaryLine(rightLines, "Left");
    rightLineOriginal = transformLineToOriginalImage(rightLine, H, Rout, TransRight, 400);
end