%  DEPRECATED
% 
% 
function root = fixed_point(xi, epsilon, max_iterations, fx, output_file)
%
% 
% 
% 

    addpath('../');
    tic

    [root, interations, data] = implementation(xi, epsilon, max_iterations, fx, 0, []);


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


function [root, interations, data] = implementation(xi, epsilon, max_iterations, fx, iterations, data)
    addpath('../');

    xii = fx(xi);
    
    %01_STOP CONDITION*************************
    error=abs((xii-xi)/xii);
    iterations = iterations+1;
    data = [data; xii error];
    if(error<=epsilon||iterations>max_iterations)
        root = xii;
        return;
    end
    
    %01_RECURSIVE STEP*************************
    [root, interations, data] = implementation(xii, epsilon, max_iterations, fx, iterations, data);

end

