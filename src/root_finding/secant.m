function root = secant(x0, epsilon, max_iterations, fx)

    a = x0;
    b = x0+0.0001;
    root = implementation(a, b, epsilon, max_iterations, fx, 0);

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