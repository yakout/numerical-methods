function root = secant(xi, xii, epsilon, max_iterations, fx, output_file)

    root = implementation(xi, xii, epsilon, max_iterations, fx, 0);


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


function root2 = implementation(xi, xii, epsilon, max_iterations, fx, iterations)

    xiii = xii - (fx(xii)*(xi-xii))/(fx(xi)-fx(xii));
    
    %01_STOP CONDITION*************************
    error=abs((xiii-xii)/xiii);
    iterations = iterations+1;
    if(error<=epsilon||iterations>max_iterations)
        root2 = xiii;
        return;
    end
    
    %01_RECURSIVE STEP*************************
    root2 = implementation(xii, xiii, epsilon, max_iterations, fx, iterations);
    

end