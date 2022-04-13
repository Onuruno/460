function [tf460_internals] = init_tf460()
%INIT_TF460 initialize tf460 transformation query system
%   a constructor like initializer function for the query system to
%   populate the internals. tf460_internals is a struct for storing the
%   fields and other stuff that your system should remember.
    s = struct();
    s.transformations = zeros(11,11,4,4); %contains frame-to-frame transformation matrices
    for i = 1:11
        s.transformations(i,i,:,:) = eye(4);
    end
    s.transformable = eye(11); %for early check
    tf460_internals = s;
end