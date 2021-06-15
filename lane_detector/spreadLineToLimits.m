function [lineOut] = spreadLineToLimits(line, ymin, ymax)
    % Extending the line to the given limits for the variable y coordinate
    %
    % Input:
    % line -    input line
    % ymin -    lower limit of y coordinate in extended line
    % ymax -    upper limit of y coordinate in extended line
    %
    % Output:
    % lineOut - extended line
    
    % Author: Maciej Morawski

    coefficients = polyfit([line.point1(1), line.point2(1)], [line.point1(2), line.point2(2)], 1);
    a = coefficients (1);
    b = coefficients (2);
    
    xmin = (ymin - b)/a;
    xmax = (ymax - b)/a;
    
    lineOut.point1 = [xmin ymin];
    lineOut.point2 = [xmax ymax];
    
    
end