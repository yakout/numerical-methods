function [root, iterations, data] = fixed_point(xi, epsilon, max_iterations, fx)
    addpath('../');

    tic
    [root, iterations, data] = implementation(xi, epsilon, max_iterations, fx, 0, []);
    timeElapsed = toc;
    
    
    % output the results in file in table format.
    output_file = strcat('./outputs/fixed_point_', datestr(clock),'.txt');
    fileID = fopen(output_file,'w');
    colheadings = {'Approximate root', 'Precision'};
    rowheadings = {};
    for i=1:iterations,
        rowheadings{end+1} = int2str(i);
    end

    fms = {'.4f','.5E'};
    wid = 16;
    displaytable(data, colheadings, wid, fms, rowheadings, fileID, '|', '|');

    fprintf(fileID, '\nnumber of iterations: %d\n', iterations);
    fprintf(fileID, 'execution time: %f\n', timeElapsed);
    fclose(fileID);
end


function [root, iterations, data] = implementation(xi, epsilon, max_iterations, fx, iterations, data)
    xii = fx(xi);
    
    %01_STOP CONDITION*************************
    error = abs( (xii - xi) / xii);
    iterations = iterations + 1;
    data = [data; xii error];
    if(error<=epsilon||iterations>=max_iterations)
        root = xii;
        return;
    end
    
    %01_RECURSIVE STEP*************************
    [root, iterations, data] = implementation(xii, epsilon, max_iterations, fx, iterations, data);
end

