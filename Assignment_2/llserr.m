
function average = llserr(x,y,w,b)
%LLSERR Summary of this function goes here
%   Detailed explanation goes here
    temp = zeros(size(x,1),1);
    temp(:,1) = 1;
    xtilde = [temp x];
    y;
    w;
    b;
    sum = 0;
    error = 0;
    size(xtilde,1);
    for i = 1:size(xtilde,1)
        %x(i,:)
        error = (y(i,:) - (xtilde(i,:)*w)).^2;
        sum = sum + error;
    end
    average = sum / size(x,1);

end

