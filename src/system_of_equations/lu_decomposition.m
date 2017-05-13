function solution = lu_decomposition(coeff_matrix, constants_matrix, num_of_unknowns)
    
    %decomposition
    [lower_matrix, upper_matrix] = decomposition(coeff_matrix, num_of_unknowns);
    %solve for Y
    y_matrix=obtain_y_matrix(lower_matrix, constants_matrix, num_of_unknowns);
    %solve for X
    solution=obtain_x_matrix(upper_matrix, y_matrix, num_of_unknowns);
    
end


function [lower_matrix, upper_matrix] = decomposition(coeff_matrix, num_of_unknowns)
    
    result=coeff_matrix;
    result2=eye(num_of_unknowns);

    for pivot_index=1:num_of_unknowns-1
       
       for row=pivot_index+1:num_of_unknowns
           
           row_pivot=result(row,pivot_index)/result(pivot_index,pivot_index);
           result2(row, pivot_index)=row_pivot;
           for col=pivot_index:num_of_unknowns
              result(row,col)=result(row,col)-row_pivot*result(pivot_index,col);
           end
           
       end
       
    end

    upper_matrix=result;
    lower_matrix=result2;
    
end


function y = obtain_y_matrix(lower_matrix, constants_matrix, num_of_unknowns)

    system_matrix=create_system_matrix(lower_matrix, constants_matrix);
    
    solutions=[0,0];
    
    for row=1:num_of_unknowns
       a=system_matrix(row, row);
       d=system_matrix(row, num_of_unknowns+1);
       
       summation=0;
       index=1;
       for col=1:row-1 %num_of_unknowns:-1:row+1
           summation = summation + solutions(index)*system_matrix(row, col);
           index = index+1;
       end
       
       answer = (1/a)*(d-(summation));
       solutions(index)=answer;
       
    end
    
    y=solutions;

end


function x = obtain_x_matrix(upper_matrix, y_matrix, num_of_unknowns)

    system_matrix=create_system_matrix(upper_matrix, y_matrix);
    
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
    
    x=solutions;

end


function system_matrix = create_system_matrix(coeff_matrix, constants_matrix)
    result=coeff_matrix;
    for index=1:length(constants_matrix)
        result(index, length(constants_matrix)+1)=constants_matrix(index);
    end
    
    system_matrix=result;
    
end
