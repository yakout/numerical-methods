function solutions = naive_gauss(coeff_matrix, constants_matrix, num_of_unknowns)

    tic
    system_matrix = create_system_matrix(coeff_matrix, constants_matrix);
    %num_of_unknowns = length(constants_matrix);
    
    solutions=forward_elimination(system_matrix, num_of_unknowns);
    solutions=back_substitution(solutions, num_of_unknowns);
    solutions=fliplr(solutions);
    timeElapsed = toc;


    % % output the results in file in table format.
    % output_file = strcat('./outputs/naive_gauss_', datestr(clock),'.txt');
    % fileID = fopen(output_file, 'w');


    % % fill the colheadings
    % colheadings = {};
    % % fill the x's x1, x2, x3 ..
    % for i=1:num_of_unknowns,
    %     colheadings{end+1} = strcat('x',int2str(i));
    % end
    % % fill the errors Err_x1 ..
    % for i=1:num_of_unknowns,
    %     colheadings{end+1} = strcat('Err_x',int2str(i));
    % end
    
    % % fill the rowheadings
    % rowheadings = {};
    % for i=1:iterations,
    %     rowheadings{end+1} = int2str(i);
    % end

    % fms = {};
    % wid = 16;
    % displaytable(data, colheadings, wid, fms, rowheadings, fileID, '|', '|');

    % timeElapsed = toc;
    % fprintf(fileID, '\nnumber of iterations: %d\n', iterations);
    % fprintf(fileID, 'execution time: %f\n', timeElapsed);
    % fclose(fileID);
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





