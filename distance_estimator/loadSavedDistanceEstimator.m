function [model, C, S] = loadSavedDistanceEstimator()
    % Load saved distance estimation model with normalization parameters
    % Output:
    % model         Classification model
    % C             Normalization parameter: mean
    % S             Normalization parameter: standard deviation
    
    model = load("model.mat").model;
    C = load("C.mat").C;
    S = load("S.mat").S;
end