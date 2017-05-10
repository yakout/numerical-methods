function solution = gauss_siedel(coeff_matrix, constants_matrix, initial_guess, max_iterations, epsilon)

    system_matrix = create_system_matrix(coeff_matrix, constants_matrix);
    num_of_unknowns = length(constants_matrix);

    solution = implementation(system_matrix, initial_guess, num_of_unknowns, max_iterations, 0, epsilon);

end



function solution = implementation(system_matrix, previous_solutions, num_of_unknowns, max_iterations, iterations, epsilon)
        
    current_solutions=previous_solutions;

    for row=1:num_of_unknowns
        
        a=system_matrix(row, row);
        d=system_matrix(row, num_of_unknowns+1);
        %disp(d);
        
        summation=0;
        index=1;
        for col=1:num_of_unknowns
            if(row==col)
                index = index+1;
                continue;
            end
            %disp(col);
            %disp(system_matrix(row, col));
            summation = summation + system_matrix(row, col)*previous_solutions(index);
            index = index+1;
        end
       
        answer = (1/a)*(d-(summation));
        %disp(answer);
        current_solutions(row)=answer;
        
    end
    
    %disp(current_solutions);
    
    iterations = iterations+1;
    stop_algorithm = stop_condition_test(previous_solutions, current_solutions, max_iterations, iterations, epsilon);
    if(stop_algorithm==true)
        solution = current_solutions;
        return;
    end
    
    solution=implementation(system_matrix, current_solutions, num_of_unknowns, max_iterations, iterations, epsilon);


end



function test = stop_condition_test(previous_solutions, current_solutions, max_iterations, iterations, epsilon)

    if iterations>=max_iterations
        test=true;
        return;
    end


    for index=1:length(current_solutions)
        error = (current_solutions(index)-previous_solutions(index))/current_solutions(index);
        if(error>=epsilon)
            test=false;
            return;
        end
            
    end

    
    
    
end



function system_matrix = create_system_matrix(coeff_matrix, constants_matrix)
    result=coeff_matrix;
    for index=1:length(constants_matrix)
        result(index, length(constants_matrix)+1)=constants_matrix(index);
    end
    
    system_matrix=result;
    
end






