%
% BISECTION METHOD:
%
% Pors:
%   - Easy
%   - always converges
%   - the number of iterations required to attain an absolute error can be computer a priori.
% 
% Cons:
%   - Slower compared to other methods.
%   - Need to find inital guess Xl and Xu.
%   - No account is taken of the fact that if f(xl) is closer to zero, it's likely that root is 
%      closer to Xl.
%     
% 
% Drawbacks:
%   - If the function f(x) touches the x-axis it will be unable to find the initial
%      values, since there is no upper and lower points that have different sings.
%   - Function changes sign but roots does not exist e.g f(x) = 1/x.
% 
function [root, iterations, data] = bisection(xl, xu, epsilon, max_iterations, fx)
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


    addpath('./utilities');
    tic

    if(fx(xl)*fx(xu)>0)
        return;
    end

    [root, iterations, data] = implementation(xl, xu, xu, epsilon, max_iterations, fx, 0, []);
    
    disp(root);
    timeElapsed = toc;
    
    %output the results in file in table format.t
    date_ = strrep(datestr(clock),':','_');
    output_file = strcat('./root_finding/outputs/bisection_', date_,'.txt');
    %output_file = './root_finding/outputs/bisection.txt';
    
    %disp(output_file);
    %pwd
    fileID = fopen(output_file,'w');
    colheadings = {'xu', 'xl', 'Approximate root', 'Precision'};
    rowheadings = {};
    for i=1:iterations,
        rowheadings{end+1} = int2str(i);
    end

    fms = {'.4f','.4f', '.4f', '.4f'};
    wid = 16;
    displaytable(data, colheadings, wid, fms, rowheadings, fileID, '|', '|');

    fprintf(fileID, '\nnumber of iterations: %d\n', iterations);
    fprintf(fileID, 'execution time: %f\n', timeElapsed);
    fclose(fileID);
end


function [root, iterations, data] = implementation(xl, xu, xr_old, epsilon, max_iterations, fx, iterations, data)
    xr = (xl + xu) / 2;
    
    %01_STOP CONDITION*************************
    error = abs((xr - xr_old) / xr);
    iterations = iterations + 1;
    data = [data; xl, xu, xr, error];
    if(error <= epsilon || iterations >= max_iterations)
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
