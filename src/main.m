clear;
clc;

epsilon = 0.001;
max_iterations = 20;

addpath('./system_of_equations')
addpath('./root_finding')

%system_matrix=[1,1,-1,-3; 6,2,2,2; -3,4,1,1];
%initial_guess=[0,0,0];

fx_coeff = [1, -9, -2, 120, -130];

y = birge_vieta(fx_coeff, -3, epsilon, max_iterations );
%y = naive_gauss(system_matrix, 3);

%disp(y);

%% f: function x
function [outputs] = f(x)
	outputs = x^4  + 3*x -4;
end

false_position(0, 3, 0.00001, 100, @f, 'output2.txt');
bisection(0, 3, 0.00001, 100, @f, 'output1.txt');

% syms x;
% f1 = '2x^2-sin(x)';
% f11 = inline(f1);

% disp(f11);

