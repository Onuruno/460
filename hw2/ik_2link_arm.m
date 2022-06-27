function [solns] = ik_2link_arm(d, x, y)
%IK_2LINK_ARM calculate IK for 2-link arm
%   returns a 2xn matrix solns containing joint variables, with each row
%   being [theta_1 theta_2] (defined visually in the hw text) for the
%   global position (x, y) of the end effector.
%   If there is no solution, solns is an empty array.
%   d is the length of a single link.

if(sqrt(x^2+y^2) > 2*d)
    solns = [];
    return
end

gamma = atan2(y,x);

beta = acos(1-(x^2+y^2)/(2*d^2));

alpha = acos((x^2+y^2)/(2*d*sqrt(x^2+y^2)));

if(beta ~= pi)
    solns = [(gamma-alpha), (pi-beta) ; (gamma+alpha), (beta-pi)];
else
    solns = [(gamma-alpha), (pi-beta)];
end

end
