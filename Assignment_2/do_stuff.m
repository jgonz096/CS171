function [w,b,lambda,error] = do_stuff(X,Y)
%DO_STUFF Summary of this function goes here
%   Detailed explanation goes here

    size1 = size(X,1)/2;
    size2 = size(X,2);
    size3 = (size(X,1)/2) + 1;
    size4 = size(X,1);
    size5 = (size(Y,1)/2);
    
    testX = zeros(size(X,1)/2,size(X,2));
    testX = X(1:size1,1:size2);
    
    validX = zeros(size(X,1)/2,size(X,2));
    validX = X(1:size1,1:size2);
    
    testY = zeros(size1/2,1);
    testY = Y(1:size1,1:1);
    
    validY = zeros(size1/2,1);
    validY = Y(size3:size4,1:1);
    
    lambda1 = 1
    lambda2 = 10
    lambda3 = 100
    
    [w1,b1] = ridgells(testX,testY,lambda1);
    rerr1 = llserr(testX,testY,w1,b1);
    sterr1 = llserr(validX,validY,w1,b1);
    
    [w2,b2] = ridgells(testX,testY,lambda2);
    rerr2 = llserr(testX,testY,w2,b2);
    sterr2 = llserr(validX,validY,w2,b2);
    
    [w3,b3] = ridgells(testX,testY,lambda3);
    rerr3 = llserr(testX,testY,w3,b3);
    sterr3 = llserr(validX,validY,w3,b3);
    
    if sterr1 <= sterr2 && sterr1 <= sterr3
        w = w1;
        b = b1;
        lambda = lambda1;
        error = sterr1;
    elseif sterr2 <= sterr1 && sterr2 <= sterr3
        w = w2;
        b = b2;
        lambda = lambda2;
        error = sterr2;
   elseif sterr3 <= sterr1 && sterr3 <= sterr2
        w = w3;
        b = b3;
        lambda = lambda3;
        error = sterr3;
    end

end

