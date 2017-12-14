%NAME: Jorge Gonzalez
%SID: 861112270
%DATE: 5/28/17
%COURSE: CS171
%PS4
function [ output_args ] = findrules(D,smin,amin)
%FINDRULES Summary of this function goes here
%   Detailed explanation goes here
    I = items(D);
    m = numexamples(D);
    L = Apriori(I,D,smin);
    newL = {};
    confidences = {};
    supports = {};
    Xs = {};
    Ys = {};
    
    for i = 1:length(L)
        I = L{i};
        P = perms(I);
        
        num = getcount(I,D);
        support = num/m;
        if(size(P,2) > 1)
            for j = 1:size(P,2)-1
                X = P(:,1:j);
                Y = P(:,(j+1):end);
                revX = Y;
                revY = X;
                numX = [];
                %numY = [];
                numRevX = [];
                %numRevY = [];
                
                for k = 1:size(X,1)
                    numX = [numX;getcount(X(k,1:end),D)];
                end
                %for k = 1:size(Y,1)
                %    numY = [numY;getcount(Y(k,1:end),D)];
                %end
                for k = 1:size(revX,1)
                    numRevX = [numRevX;getcount(revX(k,1:end),D)];
                end
                %for k = 1:size(revY,1)
                %    numRevY = [numRevY;getcount(revY(k,1:end),D)];
                %end
                numX;
                %numY
                numRevX;
                %numRevY
                
                num;
                confidence = num ./ numX;
                revConfidence = num ./ numRevX;
                
                for k = 1:size(confidence,1)
                    
                    if(confidence(k,1) >= amin)
                        Xs = [Xs;X(k,1:end)];
                        Ys = [Ys;Y(k,1:end)];
                        confidences = [confidences;confidence(k,1)];
                        supports = [supports;support];
                        %Xs
                         if(length(Xs) > 1)   
                            if(k > 1)
                                Xs;
                                
                                xvector1 = Xs{length(Xs)};
                                xvector2 = Xs{length(Xs)-1};
                                yvector1 = Ys{length(Ys)};
                                yvector2 = Ys{length(Ys)-1};
                                
                                %Xs(size(Xs,1),1:end)
                                %s(size(Xs,1)-1,1:end)
                                %Ys(size(Ys,1),1:end)
                                %Ys(size(Ys,1)-1,1:end)
                                
                                diff1 = setdiff(xvector1,xvector2);
                                diff2 = setdiff(yvector1,yvector2);
                                difference1 = isempty(diff1);
                                difference2 = isempty(diff2);

                                %delete duplicate Xs and Ys here, maybe do
                                %confidences and supports here also
                                if(difference1 == 1)
                                    if(difference2 == 1)
                                        Xs(length(Xs),:) = [];
                                        Ys(length(Ys),:) = [];
                                        confidences(length(confidences),:) = [];
                                        supports(length(supports),:) = [];

                                    end

                                end
                            end
                         end
                    end
                end
                for k = 1:size(confidence,1)
                    if(revConfidence(k,1) >= amin)
                        
                        Xs = [Xs;revX(k,1:end)];
                        Ys = [Ys;revY(k,1:end)];
                        confidences = [confidences;revConfidence(k,1)];
                        supports = [supports;support];
                        if(length(Xs) > 1)
                            if(k > 1)
                                
                                xvector1 = Xs{length(Xs)};
                                xvector2 = Xs{length(Xs)-1};
                                yvector1 = Ys{length(Ys)};
                                yvector2 = Ys{length(Ys)-1};
                                
                                %Xs(size(Xs,1),1:end);
                                %Xs(size(Xs,1)-1,1:end);
                                %Ys(size(Ys,1),1:end);
                                %Ys(size(Ys,1)-1,1:end);
                                
                                diff1 = setdiff(xvector1,xvector2);
                                diff2 = setdiff(yvector1,yvector2);
                                difference1 = isempty(diff1);
                                difference2 = isempty(diff2);

                                if(difference1 == 1)
                                    if(difference2 == 1)
                                        Xs(length(Xs),:) = [];
                                        Ys(length(Ys),:) = [];
                                        confidences(length(confidences),:) = [];
                                        supports(length(supports),:) = [];
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        
        
        %support = num/m;
        %confidence = num/
        %if()
        %end
    end
    
    toremove = [];
    for i = 1:length(Xs)
        for j = i+1:length(Xs)
            xvector1 = Xs{i};
            xvector2 = Xs{j};
            yvector1 = Ys{i};
            yvector2 = Ys{j};
            
            diff1 = setdiff(xvector1,xvector2);
            diff2 = setdiff(yvector1,yvector2);
            difference1 = isempty(diff1);
            difference2 = isempty(diff2);
            
            
            if(difference1 == 1)
                if(difference2 == 1)
                    %Xs(j,:) = []
                    toremove = [toremove;j];
                    %Ys(j,:) = []
                    %confidences(j,:) = []
                    %supports(j,:) = []
                end
            end
        end
    end
    
    toremove;
    Xs(toremove,:) = [];
    Ys(toremove,:) = [];
    confidences(toremove,:) = [];
    supports(toremove,:) = [];
    
    
    
    
    
    %total = {confidences supports Xs Ys}
    
    %str = rule2str(Xs(1),Ys(1),D)
    %sprintf('%d, %d : %s',confidences(1),supports(1),str)
    total = {};
    total = [total;confidences];
    total = [total,supports,Xs,Ys];
    total = sortrows(total,1);
    
    confidences = total(:,1);
    supports = total(:,2);
    Xs = total(:,3);
    Ys = total(:,4);
    %total(:,1)
    %total(:,2)
    
    %total = [total;Xs]
    
    %length(total)
    %add this loop back when done
    
    for i = 1:length(total)
        xvector = Xs{i};
        yvector = Ys{i};
        str = rule2str(xvector,yvector,D);
        disp(sprintf('%f, %f : %s',confidences{i},supports{i},str))
    end
    
    
    
    
    %{
    display(confidences(1))
    sprintf(',')
    display(supports(1))
    sprintf(':')
    str = rule2str(Xs(1),Ys(1),D)
    display(str)
    %}
    
    %total = [confidences supports Xs Ys]
    %if(size(total,2) > 0)
        %{
        for m = 1:size(Xs,1)
            for n = m+1:size(Xs,1)
                differenceX = setdiff(Xs(m,1),Xs(n,1))
                differenceY = setdiff(Ys(m,1),Ys(n,1))
                if(size(differenceX) == 0)
                    if(size(differenceY) == 0)
                        Xs(n,1:end) = [] 
                        Ys(n,1:end) = []
                        confidences(n,1:end) = []
                        supports(n,1:end) = []
                    end
                end
            end
        end
        
        
        total = [confidences supports Xs Ys]
        %}
        %total = sortrows(total,1)
    %end
    
    %str = rule2str(Xs',Ys',D)
end

