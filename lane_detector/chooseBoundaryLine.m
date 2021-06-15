function [line] = chooseBoundaryLine(lines, side)
    % Select the border line in the image from the set of detected lines
    %     
    % Input:
    % lines -   lines detected in the image
    % side -    from which side to search for the line
    % 
    % Output:
    % line -    border line found on the side specified by the side variable
    %           if there is no line found, then:
    %               line.point1 = [0 0]
    %               line.point2 = [0 0]
    
    % Author: Maciej Morawski

    if isempty(lines)
        line.point1 = [0, 0];
        line.point2 = [0, 0];
        return;
    end
    
    line.point1 = lines(1).point1;
    line.point2 = lines(1).point2;
    
    if length(lines) == 1
        return;
    end
    
    foundX = (line.point1(1) + line.point2(1)) / 2;
    
    for k = 2:length(lines)
       if(side == "Right" && foundX < (lines(k).point1(1) + lines(k).point2(1))/2 ||...
               side == "Left" && foundX > (lines(k).point1(1) + lines(k).point2(1))/2)
           line.point1 = lines(k).point1;
           line.point2 = lines(k).point2;
           foundX = (lines(k).point1(1) + lines(k).point2(1))/2;
       end
    end
end