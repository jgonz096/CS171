%NAME: Jorge Gonzalez
%SID: 861112270
%DATE: 5/28/17
%COURSE: CS171
%PS4
function [Y,dt] = runq1()
%RUNQ1 Summary of this function goes here
%   Detailed explanation goes here
    data = load('banktrain.data');
    
    Y = data(:,size(data,2));
    X = data;
    X(:,size(X,2)) = [];
    
    trainX = X(1:(.65 * size(X,1)),1:size(X,2));
    trainY = Y(1:(.65 * size(Y,1)),1:size(Y,2));
    pruningX = X(.65 * size(X,1):size(X,1),1:size(X,2));
    pruningY = Y(.65 * size(Y,1):size(Y,1),1:size(Y,2));
    
    xsize = size(X);
    ysize = size(Y);
    trainxsize = size(trainX);
    trainysize = size(trainY);
    pruningxsize = size(pruningX);
    pruningysize = size(pruningY);
    
    ftype = [0,12,4,8,3,3,3,2,0,0,0,0,0,3,0,0,0,0,0];
    
    dt = learndt(X,Y,ftype,@scorefn);
    drawdt(dt);
    prunedTree = prunedt(dt,pruningX,pruningY);
    drawdt(prunedTree);
    
    newData = load('banktestX.data');
    testX = newData;
    predictedY = predictdt(prunedTree,testX)
    
    Y = predictedY;
    dt = prunedTree;
    
end

