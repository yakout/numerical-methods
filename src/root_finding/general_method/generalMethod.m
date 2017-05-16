%% GeneralMethod: function description
function [roots, iterations, data] = generalMethod(fn)
	%get polynomial function
	fun=taylor(sym(fn),'order',10);

	%parsing coff =[];
	g=sym(fun)
	fx=matlabFunction(g)
	%cofftions=sym2poly(g);
	Max_Iter = 10000
	Start_Point = 100;
	tol =1e5;
	r = randperm(100,50);
	for i=1:50
	    x= r(i);
	    if abs(fn(-x))<abs(fn(x))
			x=-x;
		end 
		if abs(fn(x))< abs(fn(Start_Point))
			Start_Point =x;
	    end

	end 

	x0 = Start_Point
    errors=[];
	%vegevite ()
	%[roots,errors]=vegevite(coff,x0,Max_Iter,tol);
	[roots, iterations, data] = birge_vieta(fx, x0, tol, Max_Iter );
end