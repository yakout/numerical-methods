%% GeneralMethod: function description
function [roots, iterations, data] = general_method(fn)
	%get polynomial function
	fun=taylor(sym(fn),'order',40);
    
    disp(fun);

	%parsing coff =[];
	g=sym(fun);
	
    fx=matlabFunction(g);
	
    %fx_coeff=sym2poly(g);
    
    
    x0=obtain_initial_value(fn);
    %disp(x0);
    [roots, iterations, data] = birge_vieta(fx, 1, 0.0001, 100,2);
	
    
    %Max_Iter = 1000;
	%Start_Point = 100;
	%tol =1e5;
	

	%x0 = Start_Point
    %errors=[];
	%vegevite ()
	%[roots,errors]=vegevite(coff,x0,Max_Iter,tol);
	%[roots, iterations, data] = birge_vieta(fx_coeff, x0, tol, Max_Iter );
end



function initial = obtain_initial_value(fn)

    start_point=100;
    %r = randperm(100,50);
	for i=0:1000
        x= i;
	    if abs(fn(-x))<abs(fn(x))
			x=-x;
        end
        
        if abs(fn(x))< abs(fn(start_point))
			start_point =x;
	    end

    end 
    
    initial=start_point;
    
    
    
    
    

end








