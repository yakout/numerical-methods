function solutions = gauss_jordan(coeff_matrix, constants_matrix, num_of_unknowns)
    tic
    system_matrix = create_system_matrix(coeff_matrix, constants_matrix);
    %num_of_unknowns = length(constants_matrix);


    solutions=forward_elimination(system_matrix, num_of_unknowns);
    solutions=back_substitution(solutions, num_of_unknowns);
    timeElapsed = toc;


    % % output the results in file in table format.
    % output_file = strcat('./outputs/gauss_jordan_', datestr(clock),'.txt');
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

    % fms = {'.4f','.4f', '.4f','.4f','.4f', '.4f'};
    % wid = 16;
    % displaytable(data, colheadings, wid, fms, rowheadings, fileID, '|', '|');

    % timeElapsed = toc;
    % fprintf(fileID, '\nnumber of iterations: %d\n', iterations);
    % fprintf(fileID, 'execution time: %f\n', timeElapsed);
    % fclose(fileID);

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





