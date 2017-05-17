epsilon = 0.0001;
max_iterations = 50;

%test case 1
%coeff_matrix=[2,1,4; 1,2,3; 4,-1,2];
%constants_matrix=[1,1.5,2];

%test case 2
coeff_matrix=[12,3,-5; 1,5,3; 3,7,13];
constants_matrix=[1,28,76];


initial_guess=[1,0,1];


addpath('./logic');
[solution, iterations, data] = gauss_siedel(coeff_matrix, constants_matrix, initial_guess, max_iterations, epsilon);

disp(solution);