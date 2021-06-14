function features = getImageFeatures(img)
    % Extract HOG image features
    %
    % Input:
    % img           Input photo (suggested resolutions are HD or Full HD)
    %
    % Output:
    % features      Calculated HOG features

    hog_bins = 9;
    pix_per_cell = 8;
    cells_per_block = 2;
    
    img = rgb2ycbcr(img);

    hog1 = extractHOGFeatures(img(:, :, 1), "NumBins", hog_bins,...
        'CellSize', [pix_per_cell pix_per_cell], 'BlockSize',...
        [cells_per_block cells_per_block])';
    hog2 = extractHOGFeatures(img(:, :, 2), "NumBins", hog_bins,...
        'CellSize', [pix_per_cell pix_per_cell], 'BlockSize',...
        [cells_per_block cells_per_block])';
    hog3 = extractHOGFeatures(img(:, :, 3), "NumBins", hog_bins,...
        'CellSize', [pix_per_cell pix_per_cell], 'BlockSize',...
        [cells_per_block cells_per_block])';
    features = vertcat(hog1, hog2, hog3)';
end



