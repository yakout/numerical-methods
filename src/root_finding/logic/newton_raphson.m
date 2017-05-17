function [root, iterations, data] = newton_raphson(x0,epsilon, max_iterations, fx)
    addpath('./utilities');
    tic
    
    disp('success');

    %obtain function derivative
    syms x;
    z = diff(fx(x));
    fxp = inline(char(z));
    
    [root, iterations, data] = implementation(x0, epsilon, max_iterations, fx, fxp, 0, []);
    timeElapsed = toc;
    
    
    disp('root : ');
    disp(root);
    

    % display results in table in output file
    date_ = strrep(datestr(clock),':','_');
    output_file = strcat('./root_finding/outputs/newton_raphson_', date_,'.txt');
    
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


function [root, iterations, data] = implementation(xi, epsilon, max_iterations, fx, fxp, iterations, data)
    
    xii = xi - (fx(xi)/fxp(xi));
    
    %01_STOP CONDITION*************************
    error=abs((xii-xi)/xii);
    iterations = iterations+1;
    data = [data; xii error];
    if(error<=epsilon||iterations>max_iterations)
        root = xii;
        return;
    end
    
    %01_RECURSIVE STEP*************************
    [root, iterations, data] = implementation(xii, epsilon, max_iterations, fx, fxp, iterations, data);
    

end