function [E_average M_average] = checker(E_distance,M_distance,Yvalid,rng1,rng2)
%CHECKER Summary of this function goes here
%   Detailed explanation goes here

E_check = 0;
M_check = E_check;

E_average = 0;
M_average = E_average;

for i = 1:rng1
    if(E_distance(i,size(E_distance,2)) == Yvalid(rng2))
        E_check = E_check + 1;
    end
    if(M_distance(i,size(M_distance,2)) == Yvalid(rng2))
        M_check = M_check + 1;
    end
end

if E_check < rng1/2
   E_average = E_average + 1
end
if M_check < rng1/2
    M_average = M_average + 1
end

