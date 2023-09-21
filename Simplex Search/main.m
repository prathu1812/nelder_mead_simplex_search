%Objective Function- Shifted Sphere 
Objfun = @(x) sum((x+1).^2);

%Starting Solution 
x0 = [3,4];

%Nelder-mead Visualization
%Default value of star is set to -1, one can change the value of star based
%on requirements
[xmin, fmin, iter] = nelder_mead_visual(Objfun, x0)