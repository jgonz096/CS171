%NAME: Jorge Gonzalez
%SID: 861112270
%DATE: 5/28/17
%COURSE: CS171
%PS4
function C = AprioriGen(L)
%APRIORIGEN Summary of this function goes here
%   Detailed explanation goes here
    i = size(L,2);
    C = {};%[]
    for j = 1:i
        J = L{j};
        for k = (j+1):i
            K = L{k};
            %if (intersect(L{j},L{k}) == j-2)
            difference = setdiff(J,K);
            %difference = intersect(J,K)
            
            %size(difference);
            if(size(difference,2) == 1)
                %jandk = num2cell(union(L{j},L{k}))
                %temp2 = {jandk}
                jandk = {union(J,K)};
                %C = union(C,jandk)
                C = [C,jandk];
            else
                break
            end
        end
    end
    C;
end

