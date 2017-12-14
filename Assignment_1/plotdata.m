
function x = plotdata3( fdata )
%PLOTDATA Summary of this function goes here
%   Detailed explanation goes here
    %fileID = fopen(fdata,'r');
    %formatSpec = '%f';
    %data = fscanf(fileID,formatSpec);
    hold on;
    data = load(fdata);
    %x = figure;
    %figure(x);
    %n = 1;
    rows = size(data,1);
    cols = size(data,2);
    
    y = data(:,cols);
    
    for j = 1:(cols - 1)
        subplot(4,4,j)
        x = data(:,j);
        
        %for i = 1:size(data,1)
           %subplot(3,5,j)
           %scatter(data(i,1),data(i,14),'b') 
           scatter(x,y,'b');
        %end
    end
end

