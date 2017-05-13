function solutions = naive_gauss(coeff_matrix, constants_matrix)

    system_matrix = create_system_matrix(coeff_matrix, constants_matrix);
    num_of_unknowns = length(constants_matrix);
    
    
    solutions=forward_elimination(system_matrix, num_of_unknowns);
    solutions=back_substitution(solutions, num_of_unknowns);
    
end

function new_system = forward_elimination(system_matrix, num_of_unknowns)
    
    result=system_matrix;

    for pivot_index=1:num_of_unknowns-1
       
       for row=pivot_index+1:num_of_unknowns
           
           row_pivot=result(row,pivot_index)/result(pivot_index,pivot_index);
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
    
    for row=num_of_unknowns:-1:1
       a=system_matrix(row, row);
       d=system_matrix(row, num_of_unknowns+1);
       
       summation=0;
       index=1;
       for col=num_of_unknowns:-1:row+1
           summation = summation + solutions(index)*system_matrix(row, col);
           index = index+1;
       end
       
       answer = (1/a)*(d-(summation));
       solutions(index)=answer;
       
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





