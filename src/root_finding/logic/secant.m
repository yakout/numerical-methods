function [root, iterations, data] = secant(xi, xii, epsilon, max_iterations, fx)
    addpath('./utilities');
    
    tic
    [root, iterations, data] = implementation(xi, xii, epsilon, max_iterations, fx, 0, []);
    timeElapsed = toc;
    
    disp('root : ');
    disp(root);
    


    % output the results in file in table format.
    date_ = strrep(datestr(clock),':','_');
    output_file = strcat('./root_finding/outputs/secant_', date_,'.txt');
    
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


function [root, iterations, data] = implementation(xi, xii, epsilon, max_iterations, fx, iterations, data)

    xiii = xii - (fx(xii)*(xi-xii))/(fx(xi)-fx(xii));
    
    %01_STOP CONDITION*************************
    error=abs((xiii-xii)/xiii);
    iterations = iterations+1;
    data = [data; xiii error];
    if(error<=epsilon||iterations>max_iterations)
        root = xiii;
        return;
    end
    
    %01_RECURSIVE STEP*************************
    [root, iterations, data] = implementation(xii, xiii, epsilon, max_iterations, fx, iterations, data);
end