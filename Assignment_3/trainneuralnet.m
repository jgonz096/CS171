%{
    Name: Jorge Gonzalez
    SID: 861112270
    Date: 5/13/2017
    Course: CS171
    ASSN: PS3
%}



function [W1,W2] = trainneuralnet(X,Y,nhidden,lambda)
%TRAINNEURALNET Summary of this function goes here
%   Detailed explanation goes here
X;
Y;
nhidden;
lambda;
eta = 0.1;
iterations = 1000000;
count = 0;

ones_column = zeros(size(X,1),1);
ones_column(:,1) = 1;
gridX = getgridpts(X);
ones_column2 = zeros(size(gridX,1),1);
ones_column2(:,1) = 1;
my_gridX = [ones_column2 gridX];
newX = [ones_column X];


%newX(:);
random1 = [randn(nhidden,size(newX,2))];
random2 = [randn(1,nhidden + 1)];

W1 = random1;
W2 = random2;

for i = 1:iterations
    weighted_sum1 = zeros(size(W1,1),size(W1,2));
    weighted_sum2 = zeros(size(W2,1),size(W2,2));
    %total_loss = 0
    
    
    transX = transpose(newX);
    a1 = W1*transX;
    z1 = [1 ./ (1 + exp(-a1))];
    temp = zeros(1,size(z1,2));
    temp(1,:) = 1;
    z1 = [temp;z1];
    af = W2*z1;
    zf = [1 ./ (1 + exp(-af))];
    
    df = (zf - transpose(Y));
    sigmatemp = [1 - z1];
    sigs = z1.*sigmatemp;
    temp2 = [transpose(W2)*df];
    d1 = sigs .* temp2;
    d1(1,:) = [];
    
    %transpose(df)
    %transpose(z1)
    %temp3 = [transpose(df) transpose(df)];
    %dwf = df*transpose(z1);
    %dwf = temp3.*(transpose(z1));
    %weighted_sum2 = weighted_sum2 + sum(dwf,1);
    dwf = df*(transpose(z1));
    weighted_sum2 = weighted_sum2 + dwf;
    dw1 = d1*transpose(transX);
    weighted_sum1 = weighted_sum1 + dw1;
    %{
    for j = 1:size(newX,1)
        W1;
        W2;
        xj = newX(j,:);
        xj = transpose(xj);
        
        a1 = W1*xj;
        z1 = [1 ./ (1 + exp(-a1))];
        z1 = [1;z1];
        
        af = W2*z1;
        zf = [1 ./ (1 + exp(-af))];
        
        df = zf - Y(j,1);
        gtemp = 1 - z1;
        gz = z1.*gtemp;
        temp = [transpose(W2)*df];
        
        d1 = gz.*temp;
        d1(1,:) = [];
        
        %dwf = (eta)*(df)*(transpose(z1))
        dwf = (df)*(transpose(z1));
        weighted_sum2 = weighted_sum2 + dwf;
        %dw1 = (eta)*(d1)*(transpose(xj))
        dw1 = (d1)*(transpose(xj));
        weighted_sum1 = weighted_sum1 + dw1;
        
        
        %break
    end
    %}
    %total_loss = total_loss / size(newX,1)
    weighted_sum1 = weighted_sum1 / size(newX,1);
    weighted_sum2 = weighted_sum2 / size(newX,1);
    weighted_sum1 = weighted_sum1 + (2 * lambda * W1);
    weighted_sum2 = weighted_sum2 + (2 * lambda * W2);
    
    maximum_sum1 = max(max(abs(weighted_sum1)));
    maximum_sum2 = max(max(abs(weighted_sum2)));
    
    maximum_sum = [maximum_sum1 maximum_sum2];
    maximum = max(maximum_sum);
    if(maximum < .0001)
        break
    end
    
    %{
    if (maximum_sum1 < .0001)
        if (maximum_sum2 < .0001)
            break
        end
    end
    %}
    
    
    W1 = W1 - ((eta).*weighted_sum1);
    W2 = W2 - ((eta).*weighted_sum2);
    count = count + 1;
    
    status = mod(i,1000);
    if (status == 0)
        maximum
        gridY = zeros(size(gridX,1),1);
        
        transGridX = transpose(my_gridX);
        gridA1 = W1*transGridX;
        gridZ1 = [1 ./ (1 + exp(-gridA1))];
        temp4 = zeros(1,size(gridZ1,2));
        temp4(1,:) = 1;
        gridZ1 = [temp4;gridZ1];
        gridAf = W2*gridZ1;
        gridZf = [1 ./ (1 + exp(-gridAf))];
        gridY = gridY + transpose(gridZf);
        
        gridY(gridY > 0.5) = 1;
        gridY(gridY <= 0.5) = 0;
        gridY;
        %gridXXX = gridX(:,2:end);
        plotdecision(X,Y,gridX,gridY)
        drawnow
        %}
    end
    
    %break
end
W1
W2
count

gridY = zeros(size(gridX,1),1);
        
transGridX = transpose(my_gridX);
gridA1 = W1*transGridX;
gridZ1 = [1 ./ (1 + exp(-gridA1))];
temp4 = zeros(1,size(gridZ1,2));
temp4(1,:) = 1;
gridZ1 = [temp4;gridZ1];
gridAf = W2*gridZ1;
gridZf = [1 ./ (1 + exp(-gridAf))];
gridY = gridY + transpose(gridZf);

gridY(gridY > 0.5) = 1;
gridY(gridY <= 0.5) = 0;
gridY;
%gridXXX = gridX(:,2:end);
plotdecision(X,Y,gridX,gridY)
drawnow

end

