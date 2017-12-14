%NAME: Jorge Gonzalez
%SID: 861112270
%DATE: 5/28/17
%COURSE: CS171
%PS4
function [score] = scorefn(examples)
%SCOREFN Summary of this function goes here
%   Detailed explanation goes here
    score = 0;
    for i = 1:size(examples,2)
        update = examples(i) * (1 - examples(i));
        score = score + update;
    end
    
    score;

end

