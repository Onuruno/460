function [tf460_internals, result] = insert_tf460(tf460_internals, from, to, T)
%INSERT_TF460 insert a transformation between indices
%   This function inserts a 4x4 3D homogeneous transformation T to the
%   query system, which represents pose of "to" with respect to "from". If
%   there is a previous entry or the relationship is implied from other
%   transforms, the operation should be rejected.
%   "from" and "to" are integers from 0 to 10.
%   result is false if the operation is rejected and true otherwise.
%   tf460_internals value is a struct for storing the internals
%   of the query system. MATLAB does not support call by reference, so we
%   have to explicitly return it.


% structs in matlab are similar to javascript objects. Just assign a
% value to a field and voila.
    if (tf460_internals.transformable(from+1,to+1) == 1)
        result = false;
    else
        tf460_internals.transformations(from+1,to+1,:,:) = T;
        tf460_internals.transformable(from+1,to+1) = 1;
        tf460_internals.transformations(to+1,from+1,:,:) = inv(T);
        tf460_internals.transformable(to+1,from+1) = 1;
    
        %after this point i implemented side effects of inserting
        indices1 = [];
        for k = 1:11
            if (tf460_internals.transformable(from+1,k) == 1)
                indices1(end+1) = k;
            end
        end
        indices2 = [];
        for k = 1:11
            if (tf460_internals.transformable(to+1,k) == 1)
                indices2(end+1) = k;
            end
        end  
        for i = indices1
            for j = indices2
                if (tf460_internals.transformable(i,j) == 1)
                    % do nothing
                else
                    tf460_internals.transformations(i,j,:,:) = reshape(tf460_internals.transformations(to+1,j,:,:),4,4)...
                        * T * reshape(tf460_internals.transformations(i,from+1,:,:),4,4);
                    tf460_internals.transformable(i,j) = 1;
                    tf460_internals.transformations(j,i,:,:) = inv(reshape(tf460_internals.transformations(i,j,:,:),4,4));
                    tf460_internals.transformable(j,i) = 1;
                end
            end
        end
        result = true;
    end
end