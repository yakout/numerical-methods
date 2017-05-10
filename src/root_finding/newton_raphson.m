function root = newton_raphson(x0,epsilon, max_iterations, fx)

    %obtain function derivative
    syms x;
    z = diff(fx(x));
    fxp = inline(z);
    
    
    root = implementation(x0, epsilon, max_iterations, fx, fxp, 0);
    
end


function root2 = implementation(xi, epsilon, max_iterations, fx, fxp, iterations)

    xii = xi - (fx(xi)/fxp(xi));
    
    %01_STOP CONDITION*************************
    error=abs((xii-xi)/xii);
    iterations = iterations+1;
    if(error<=epsilon||iterations>max_iterations)
        root2 = xii;
        return;
    end
    
    %01_RECURSIVE STEP*************************
    root2 = implementation(xii, epsilon, max_iterations, fx, fxp, iterations);
    

end