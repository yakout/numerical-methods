function [roots, iterations, data] = birge_vieta(fx, x0, epsilon, max_iterations,mode)
    % data [approx error]

    %symbolic_function=poly2sym(fx_coeff)
    
    %disp(fx);
    
    %disp(fx(100))
    
    g=sym(fx);
    fx_coeff = sym2poly(g); 
    
    %disp(fx_coeff);
    
    %result= zeros(length(fx_coeff)-1, 'int8');
    result=[];
    current_eqn=fx_coeff;
    index=1;
    
    for root=1:length(fx_coeff)-1
        
        [current_root, next_eq] = newton_horner(current_eqn, x0, epsilon, max_iterations);

        if(abs(fx(current_root))>0.01)
            continue;
        end
        
        
        result(index)=current_root;
        index=index+1;
        current_eqn=next_eq;
    end
    
    disp(result);
    roots = result;
    iterations=[];
    data=[];

end



function [root, new_coeffs] = newton_horner(fx_coeff, x0, epsilon, max_iterations)

    %initialize horner table
    xi=x0;
    iterations=0;
    horner_table=initilize_horner_table(fx_coeff);

    while(true)
        %01_create horner table new coefficients
        for index=2:length(fx_coeff)
            horner_table(index, 3)=horner_table(index, 2)+xi*horner_table(index-1, 3);
            horner_table(index, 4)=horner_table(index, 3)+xi*horner_table(index-1, 4);
        end
        %disp(horner_table(length(fx_coeff), 3));
        %disp(xi);
        %disp(horner_table);
        %disp(horner_table());
        %02_calculate new xi
        fx_value=horner_table(length(fx_coeff), 3);
        fxp_value=horner_table(length(fx_coeff)-1, 4);
        xii = xi - fx_value/fxp_value;
        err=abs(xii-xi)/abs(xii);
        %03_stopping condition
        iterations = iterations+1;
        if(iterations>max_iterations)||(err<epsilon)
            root = xii;
            %disp(root);
            new_coeffs=obtain_new_coefficients(horner_table, length(fx_coeff));
            %disp(new_coeffs);
            return;
        end
        
        xi=xii;
    end
    
end




function table = initilize_horner_table(fx_coeff)

    result= [1,2,3; 4,3,5];
    
    result(1,1)=length(fx_coeff)-1;
    result(1,2)=1; result(1,3)=1; result(1,4)=1; 
    
    for index=2:length(fx_coeff)
        result(index, 1)=length(fx_coeff)-index;
        result(index, 2)=fx_coeff(index);
        %fx new values
        result(index, 3)=0;
        result(index, 4)=0;
    end
    
    table=result;

end


function coeffs = obtain_new_coefficients(horner_table, fx_length)
  
    result=[1,2];
    for index=1:fx_length-1
        result(index)=horner_table(index, 3);
    end
    %disp(result);
    coeffs=result;

end









