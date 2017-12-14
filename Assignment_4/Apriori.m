%NAME: Jorge Gonzalez
%SID: 861112270
%DATE: 5/28/17
%COURSE: CS171
%PS4
function [L] = Apriori(I,D,smin)
%APRIORI Summary of this function goes here
%   Detailed explanation goes here
    
    m = numexamples(D);
    F = {};
    for i = 1:length(I)
        %I(i)
        num = getcount(I(i),D);
        if((num/m) >= smin)
            F = [F I(i)];
        end
    end
    L = F;
    
    
    %C = AprioriGen(F(1,1:(length(F)-1)))
    
    while(length(F) > 0)
        C = AprioriGen(F(1,1:(length(F)-1)));
        F = {};
        
        length(C);
        for c = 1:length(C)
            num = getcount(C{c},D);
            if((num/m) >= smin)
                %F = union(F,C(c))
                F = [F,C{c}];
            end
        end
        
        L = [L,F];
        %break
        
    end
    %}
    L;
end

