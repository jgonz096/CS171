function [k,lnorm] = cvknn(Xtrain,Ytrain,Xvalid,Yvalid,maxk)
% 
% a starting shell
% your solution should find the best k (from 1 to maxk, skipping even values)
% and lnorm (1 = Manhattan distance, 2 = Euclidean distance) combination
% for k-nearest neighbor using the supplied training and validation sets
%
% In doing so, it should generate a plot (do *not* call "figure" -- the
% calling function will set up for the right figure window to be active).
% The plot should be as described and illustrated in the problem set. 
%maxk = 20

calculations = zeros(maxk,4)
mismatches = zeros(maxk,4)
Euclid_validations = zeros(1,maxk)

step_size = 2
for i = 1:step_size:maxk
    %my_sum = 0
    valid_Euclid = 0
    valid_Manhattan = 0
    for m = 1:size(Xvalid,1)
        holdXtrain = Xtrain
        for j = 1:size(Xvalid,1)
            holdXtrain(j,:) = (holdXtrain(j,:) - Xvalid(j,:));
            holdXtrain(j,:) = holdXtrain(j,:).^2;
        end
        my_sum = sum(holdXtrain,2);
        root = sqrt(my_sum);

        Euclidean_Dist = [root Ytrain]
        Euclidean_Dist = sortrows(Euclidean_Dist)
        
        holdXtrain = Xtrain
        for j = 1:size(Xvalid,1)
            holdXtrain(j,:) = (holdXtrain(j,:) - Xvalid(j,:));
            holdXtrain(j,:) = abs(holdXtrain(j,:));
        end
        my_sum = sum(holdXtrain,2);
        Manhattan_Dist = [my_sum Ytrain]
        Manhattan_Dist = sortrows(Manhattan_Dist)
        
        matching_euclid = 0
        matching_manhattan = 0
        count = 0
        for n = 1:i
            if Euclidean_Dist(n,size(Euclidean_Dist,2)) == Yvalid(j)
                matching_euclid = matching_euclid + 1;
            end
            if Manhattan_Dist(n,size(Manhattan_Dist,2)) == Yvalid(j)
                matching_manhattan = matching_manhattan + 1;
            end
            count = count + 1;
        end
        Euclid_error_rate = (count - matching_euclid)/count
        Manhattan_error_rate = (count - matching_manhattan)/count
        calculations(i,1) = i
        mismatches(i,1) = i
        mismatches(i,2) = count - matching_euclid
        mismatches(i,3) = count - matching_manhattan
        mismatches(i,4) = count
        calculations(i,3) = Euclid_error_rate
        calculations(i,4) = Manhattan_error_rate
        
        if matching_euclid < i/2
            valid_Euclid = valid_Euclid + 1
        end
        
    end
    Euclid_validations(1,i) = valid_Euclid / size(Xvalid,1)
end
%k_Euclid = min(min(Euclid_validations(1:step_size:maxk)))
k_Euclid = [calculations(1,1) calculations(1,3)]
k_Manhattan = [calculations(1,1) calculations(1,4)]

for i = 1:step_size:maxk
    if (calculations(i,3) < k_Euclid(2))
        k_Euclid = [calculations(i,1) calculations(i,3)]
    end
    if (calculations(i,4) < k_Manhattan(2))
        k_Manhattan = [calculations(i,1) calculations(i,4)]
    end
end

if k_Euclid(2) < k_Manhattan(2)
    k = k_Euclid(1)
    lnorm = 2
else
    k = k_Manhattan(1)
    lnorm = 1
end
%{
for i = 1:step_size:maxk
    if k_Euclid == Euclid_validations(i)
        k = i
        lnorm = 2
        break
    end
end
%}
Euclid_validations
calculations

calculations(:,1) = flipud(calculations(:,1))
calculations(:,3) = flipud(calculations(:,3))

calculations(:,4) = flipud(calculations(:,4))

euclid_div = mismatches(:,2)./mismatches(:,4)
manhattan_div = mismatches(:,3)./mismatches(:,4)
mismatches = [mismatches euclid_div manhattan_div]
fifty1 = mismatches(:,2)./35
fifty2 = mismatches(:,3)./35

mismatches = [mismatches fifty1 fifty2]

mismatches

Euclidean_Dist;
Yvalid;
Euclid_validations
hold on;
%plot((1:step_size:maxk),Euclid_validations(1:step_size:maxk,3),'b')
%plot((1:step_size:maxk),calculations(1:step_size:maxk,3),'b')
%plot((1:step_size:maxk),calculations(1:step_size:maxk,4),'r')
plot((1:step_size:maxk),mismatches(1:step_size:maxk,7),'b')
plot((1:step_size:maxk),mismatches(1:step_size:maxk,8),'r')
xlabel('k')
ylabel('error rate')
legend('Euclidean','Manhattan')
hold off;
end


    %Euclid_matrix = get_euclid_matrix(Xtrain,Xvalid)