function solutions = gauss_jordan(coeff_matrix, constants_matrix)

    system_matrix = create_system_matrix(coeff_matrix, constants_matrix);
    num_of_unknowns = length(constants_matrix);


    solutions=forward_elimination(system_matrix, num_of_unknowns);
    solutions=back_substitution(solutions, num_of_unknowns);

end


function new_system = forward_elimination(system_matrix, num_of_unknowns)
    
    result=system_matrix;

    for pivot_index=1:num_of_unknowns
        
        %normalize
        pivot=result(pivot_index, pivot_index);
        for col=1:num_of_unknowns+1
            result(pivot_index, col)=result(pivot_index, col)/pivot;
        end
       
        %apply elimination
        for row=1:num_of_unknowns
            if row==pivot_index
                continue;
            end
            row_pivot=result(row,pivot_index);
            for col=pivot_index:num_of_unknowns+1
               result(row,col)=result(row,col)-row_pivot*result(pivot_index,col); 
            end
           
        end
       
    end
    
    %disp(result);
    new_system=result;
    
end


function result = back_substitution(system_matrix, num_of_unknowns)

    solutions=[0,0];
    
    for i=1:num_of_unknowns
        solutions(i)=system_matrix(i, num_of_unknowns+1);
    end
    
    result=solutions;

end



function system_matrix = create_system_matrix(coeff_matrix, constants_matrix)
    result=coeff_matrix;
    for index=1:length(constants_matrix)
        result(index, length(constants_matrix)+1)=constants_matrix(index);
    end
    
    system_matrix=result;
    
end





