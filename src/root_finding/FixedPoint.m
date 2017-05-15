function [root, iterations, data] = FixedPoint(x0, tol, nmax, g, output_file)
%
% [ xa, ex ] = fixedpoint(g, x0, tol, nmax, L)
%
% FIXEDPOINT
%   The Fixed Point Method is applied to a given function.
%
% NOTE:
%   Convergence conditions are as followed:
%       f(xa)=0  (=)  xa=g(xa)  => xa[n+1]=g(xn), n=0,1,..
% Input:
%   g - input function as a string
%   x0 - inicial aproximation
%   tol - tolerance
%   nmax - maximum number of iterations
%   L - contractivity constant (Lipschitz)
%
% Output:
%   xa - aproximation
%   ex - error estimate
%
% Example:
%   [ xa, ex ] = fixedpoint('1+atan(xa)', 2.5, 10^-5, 20)
%   
    
    tic
    addpath('../');

    success = false;
    % g = inline(g);
    xa(1) = g(x0);  
    n = 1;
    ex(1) = 1;
    ex(n + 1) = abs(xa(n) - x0);
    while n <= nmax
        if (ex(n)) < tol
			success = true;
            disp(ex(n))
			break
		end
		n = n + 1;
        xa(n) = g(xa(n - 1));
        ex(n + 1) = abs((xa(n) - xa(n - 1))/xa(n));
        success = true;
    end
    xa = [ x0 xa ];
    ex(1) = 0;
    data = [xa(1:n)' ex(1:n)'];

	
	% if ~success
	%    xa = [];
 %       ex = [];
 %       data=[]; % if data is empty the function diverges.
	%    disp('failed to converge to solution')
 %    else
 %        disp('     x      error');
 %        disp(data);
 %    end

    iterations = n;
    root = xa(iterations)
    fileID = fopen(output_file,'w');
    colheadings = {'Approximate root', 'Precision'};
    rowheadings = {};
    for i=1:iterations,
        rowheadings{end+1} = int2str(i);
    end

    fms = {'.4f','.5E'};
    wid = 16;
    displaytable(data, colheadings, wid, fms, rowheadings, fileID, '|', '|');

    timeElapsed = toc
    fprintf(fileID, '\nnumber of iterations: %d\n', iterations);
    fprintf(fileID, 'execution time: %f\n', timeElapsed);
    fclose(fileID);
end