function root = fixed_point(xi, epsilon, max_iterations, fx)
    root = implementation(xi, epsilon, max_iterations, fx, 0);
end


function root2 = implementation(xi, epsilon, max_iterations, fx, iterations)
    addpath('../');

    xii = fx(xi)+xi;
    
    %01_STOP CONDITION*************************
    error=abs((xii-xi)/xii);
    iterations = iterations+1;
    if(error<=epsilon||iterations>max_iterations)
        root2 = xii;
        return;
    end
    
    %01_RECURSIVE STEP*************************
    root2 = implementation(xii, epsilon, max_iterations, fx, iterations);
    

end

