
% bisection method:
%
% Pors:
%   1- Easy
%   2- always converges
%   3- the number of iterations required to attain an absolute error can be computer a priori.
% 
% Cons:
%   1- Slower compared to other methods.
%   2- Need to find inital guess Xl and Xu.
%   3- No account is taken of the fact that if f(xl) is closer to zero, it's likely that root is 
%      closer to Xl.
%     
% 
% Drawbacks:
%   1- If the function f(x) touches the x-axis it will be unable to find the initial
%      values, since there is no upper and lower points that have different sings.
%   2- Function changes sign but roots does not exist e.g f(x) = 1/x.
% 

%
% default value of epsilon = 0.00001
% default value of max_iterations = 50
%
function root = bisection(xl, xu, epsilon, max_iterations, fx, output_file)
    addpath('../'); % to use displaytable function
    tic
    if(fx(xl)*fx(xu)>0)
        return;
    end

    [root, iterations, data] = implementation(xl, xu, xu, epsilon, max_iterations, fx, 0, []);
    disp(iterations);
    disp(data);

    fileID = fopen(output_file,'w');
    colheadings = {'Xr', 'Precision'};
    rowheadings = {};
    for i=1:iterations,
        rowheadings{end+1} = int2str(i);
    end

    fms = {'.4f','.5E'};
    wid = 16;
    displaytable(data, colheadings, wid, fms, rowheadings, fileID, '|', '|');

    timeElapsed = toc
    fprintf(fileID, '\nnumber of iterations: %d\n', iterations);
    fprintf(fileID, 'execution time: %f\n', timeElapsed);
    fclose(fileID);
end


function [root, iterations, data] = implementation(xl, xu, xr_old, epsilon, max_iterations, fx, iterations, data)
    xr = (xl + xu) / 2;
    
    %01_STOP CONDITION*************************
    approximate_relative_error = abs((xr - xr_old) / xr);
    iterations = iterations + 1;
    data = [data; xr, approximate_relative_error];
    if(approximate_relative_error <= epsilon || iterations >= max_iterations)
        root = xr;
        return;
    end
    
    %01_RECURSIVE STEP*************************
    if(fx(xr) * fx(xl) < 0)
        [root, iterations, data] = implementation(xl, xr, xr, epsilon, max_iterations, fx, iterations, data);
        return;
    else
        [root, iterations, data] = implementation(xr, xu, xr, epsilon, max_iterations, fx, iterations, data);
        return;
    end

end
