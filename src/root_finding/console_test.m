clear;
clc;

epsilon = 0.00001;
max_iterations = 100;

%f = @(x)(x^2-3*x+2);
f = @(x)(x^3+x^2+x+1);

[root, iterations, data] = fixed_point(0.5, epsilon, max_iterations, f);



disp(root);


