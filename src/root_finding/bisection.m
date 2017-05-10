function root = bisection(xl,xu,epsilon, max_iterations, fx)

    if(fx(xl)*fx(xu)>0)
        return;
    end
    
    root = implementation(xl, xu, xu, epsilon, max_iterations, fx, 0);
    

end


function root2 = implementation(xl, xu, xr_old, epsilon, max_iterations, fx, iterations)

    xr = (xl+xu)/2;
    
    %01_STOP CONDITION*************************
    error=abs((xr-xr_old)/xr);
    iterations = iterations+1;
    if(error<=epsilon||iterations>max_iterations)
        root2 = xr;
        return;
    end
    
    %01_RECURSIVE STEP*************************
    if(fx(xr)*fx(xl)<0)
        root2 = implementation(xl, xr, xr, epsilon, max_iterations, fx, iterations);
        return;
    else
        root2 = implementation(xr, xu, xr, epsilon, max_iterations, fx, iterations);
        return;
    end
    

end
