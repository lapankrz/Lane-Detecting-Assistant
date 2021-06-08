function [Iout, H, Rout] = transform_to_birds_eye(Iin, cutting_level)
    % Transform an image to a bird's eye view
    % based on arbitrarily selected points
    %
    % Input:
    % Iin           Input photo (suggested resolutions are HD or Full HD)
    % cutting_level the number of rows of pixels to be cut off
    %               from the top edge of the image
    %               (selected value: 400)
    %
    % Output:
    % Iout          Output photo (transformed to bird's eye view)
    % H             Homography matrix       
    % R             Spatial referencing information of transformed image
    %
    % Author: Maciej Morawski
    
    hd_resolution = [720 1280];
    img = imresize(Iin, hd_resolution);
    
    % Cutting image
    img = img(cutting_level+1:end,:,:);
    
    % Transforming image
    [pa, pb, pc, pd] = arbitrarily_selected_points();
    [A, B, C, D] = reference_points();
    
    pin = [pa pb pc pd]; % 2xN matrix of inputs
    pout = [A B C D]; % 2xN matrix of output
    
    H = fitgeotrans(pin',pout', 'projective');
    Rin = imref2d(size(img));
    [Iout, Rout] = imwarp(img, Rin, H);
end