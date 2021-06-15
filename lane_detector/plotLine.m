function [] = plotLine(line)
    % Plot line
    %
    % Input:
    % line -        input line
    %
    % Output:
    
    % Author: Maciej Morawski
     if line.point1(1) == 0 && line.point1(2) == 0 && line.point2(1) && line.point2(2)
         return;
     end
     xy = [line.point1; line.point2];
     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
end