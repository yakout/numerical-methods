clear;
clc;

epsilon = 0.001;
max_iterations = 10;

addpath('./linear_systems/logic')
addpath('./root_finding/logic')
addpath('./utilities')

%system_matrix=[1,1,-1,-3; 6,2,2,2; -3,4,1,1];
%initial_guess=[0,0,0];

fx_coeff = [2, 1, 4 ; 1, 2, 3 ; 4, -1, 2];
constants = [1, 1.5, 2];

% y = birge_vieta(fx_coeff, -3, epsilon, max_iterations)
gauss_siedel(fx_coeff, constants, [0, 0, 0], max_iterations, epsilon);

%y = naive_gauss(system_matrix, 3);

%disp(y); 

%% f: function x
function [outputs] = f(x)
	% outputs = x^4  + 3*x -4;
	outputs = exp(-x) - x;
	% outputs = x^3 - 0.165*x^2 + 3.993*10^-4;
end


% **** N O T E ****
pkg load symbolic; % this line is only neccessary for octave users like me :P (yakout)

% secant(0, 1.0, epsilon, max_iterations, @f);
% fixed_point(0, epsilon, max_iterations, @f);
% false_position(0, 3, 0.00001, 100, @f);
% bisection(0, 3, 0.00001, 100, @f);
% newton_raphson(0, epsilon, max_iterations, @f);

% syms x;
% f1 = '2x^2-sin(x)';
% f11 = inline(f1);

% disp(f11);
