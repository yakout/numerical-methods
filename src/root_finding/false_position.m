% 
% FALSE POSITION:
% 
% 
% FALSE POSITION:
% 
% Pros:
%   - Faster convergence than bisection.
%   - Always converges for a single root.
% 
% Cons:
%   - May be slower than bisection method for some cases.
%   - There are times this method may converge very very slow.
%     f(x) = x^4 + 3x - 4
% 
% Pitfalls of this methos:
%   - One sided nature of false position when there one bound that is stuck.
%     when this occurs we can use the formula xr = (xl + xu)/2.
% 
function root = false_position(xl,xu,epsilon, max_iterations, fx, output_file)
% Find root between xl and xu using false position.
% 
% Input
% 
% xl: lower initial point.
% xu: upper initial point.
% epsilon: stopping condition for the algorithm.
% max_iterations: another stopping condition for the algorithms.
% fx: the function that this method will find a root for.
% output_file: (string) path for the output file that will contains the method results.
% 
% 
% Output
% 
% the found root.
% 
    addpath('../');
    tic

    if(fx(xl)*fx(xu)>0)
        return;
    end
    
    [root, iterations, data] = implementation(xl, xu, xu, epsilon, max_iterations, fx, 0, []);

    fileID = fopen(output_file,'w');
    colheadings = {'Approximate root', 'Precision'};
    rowheadings = {};
    for i=1:iterations,
        rowheadings{end+1} = int2str(i);
    end

    fms = {'.4f','.5E'};
    wid = 16;
    displaytable(data, colheadings, wid, fms, rowheadings, fileID, '|', '|');

    timeElapsed = toc;
    fprintf(fileID, '\nnumber of iterations: %d\n', iterations);
    fprintf(fileID, 'execution time: %f\n', timeElapsed);
    fclose(fileID);
end


function [root, iterations, data] = implementation(xl, xu, xr_old, epsilon, max_iterations, fx, iterations, data)

    xr = (xl*fx(xu)-xu*fx(xl))/(fx(xu)-fx(xl));
    
    %01_STOP CONDITION*************************
    error=abs((xr-xr_old)/xr);
    iterations = iterations+1;
    data = [data; xr, error];
    if(error<=epsilon||iterations>max_iterations)
        root = xr;
        return;
    end
    
    %01_RECURSIVE STEP*************************
    if(fx(xr)*fx(xl)<0)
        [root, iterations, data] = implementation(xl, xr, xr, epsilon, max_iterations, fx, iterations, data);
        return;
    else
        [root, iterations, data] = implementation(xr, xu, xr, epsilon, max_iterations, fx, iterations, data);
        return;
    end
    

end
