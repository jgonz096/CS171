function W = runq1()
%RUNQ1 Summary of this function goes here
%   Detailed explanation goes here
    data = load('phishing.dat');
    
    Y = data(:,size(data,2));
    X = data;
    X(:,size(X,2)) = [];
    temp = zeros(size(X,1),1);
    temp(:,1) = 1;
    X = [temp X];
    
    newX = X .^ X
    newY = Y .^ Y
    
    [w1,b1,lambda1,error1] = do_stuff(X,Y)
    [w2,b2,lambda2,error2] = do_stuff(newX,newY)
    
     
     if error1 <= error2
         W = learnlogreg(X,Y,lambda1)
     elseif error2 < error1
         W = learnlogreg(newX,newY,lambda2)
     end
     %size(newX)
     %size(newY)
         %{
    newX = X
    temp2 = []
    change = 0
    for i = 1:size(X,1)
        temp = []
        for j = i:size(X,2)
            val = []
            for k = j:size(X,2)
                term = X(i,j) * X(j,k)
                val = [val term]
            end
            temp = [temp val]
            if change == 0
                temp2 = zeros(size(X,1),size(temp,2));
                for n = 1:size(temp2,2)
                    temp2(i,n) = temp(i,n);
                end
                %temp2(i,:) = temp
                change = 1
            else
                for n = 1:size(temp,2)
                    temp2(i,n) = temp(1,n);
                end
                %temp2(i,:) = temp
            end
            %newX(i,:) = [newX(i,:) temp]
        end
        %newX(i,:) = [newX(i,:) temp]
    end
    temp2
    %}
    %W = learnlogreg(X,Y,lambda)
end

