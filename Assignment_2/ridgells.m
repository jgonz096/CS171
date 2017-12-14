function [w,b] = ridgells( x,y,lambda )
%RIDGELLS Summary of this function goes here
%   Detailed explanation goes here
    

    temp = zeros(size(x,1),1);
    temp(:,1) = 1;
    xtilde = [temp x];
    
    xt = transpose(xtilde);
    m = size(x,1);
    n = size(x,2);
    I = eye(size(xtilde,2));
    I(1,1) = 0;
    temp2 = (xt*xtilde) + (lambda*I);
    w = inv(temp2) * xt * y;
    
    b = w(1,1);
    
    %w = inverse(xt*x)*xt*y;
    %wtilde = inverse(transpose(xtilde)*xtilde)*transpose(xtilde)*y;
    %fofx = transpose(wtilde)*xtilde;
    %b = fofx - (transpose(w)*x);
    
    
    
   % b = lambda ;%temporary, gotta figure this out still
    
end

