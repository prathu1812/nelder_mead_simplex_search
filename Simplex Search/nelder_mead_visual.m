function [xmin, fmin, iter] = nelder_mead_visual(f, x0, tol, maxiter)

    if nargin < 3
        tol = 1e-6;
    end

    if nargin < 4
        maxiter = 1000;
    end

    n = length(x0);

    % Check if the function is 2D for visualization
    if n ~= 2
        error('Visualization only supports 2D functions.');
    end

    alpha = 1.0;   % Reflection
    gamma = 2.0;   % Expansion
    rho = 0.5;     % Contraction
    sigma = 0.5;   % Shrink

    % Initialize the simplex around the starting point
    S = zeros(n, n+1);
    S(:, 1) = x0;

    for i = 2:(n+1)
        v = x0;
        if x0(i-1) == 0
            v(i-1) = 0.00025;
        else
            v(i-1) = v(i-1) + 0.05;
        end
        S(:, i) = v;
    end

    % Visualization: Setup the contour plot using a fixed range
    [X, Y] = meshgrid(linspace(-5, 5, 100), ...
                  linspace(-5, 5, 100));
    Z = arrayfun(@(x,y) f([x;y]), X, Y);
    levels = linspace(min(Z(:)), max(Z(:)), 100);
    contour(X, Y, Z, levels);
    colorbar;
    colormap jet;  % or try 'hot', 'parula', etc.

    hold on;
    h = plot(S(1, :), S(2, :), 'ro-', 'MarkerSize', 6, 'LineWidth', 2);
    % Before the optimization loop, plot optimum as a star:

    known_optimum = [-1; -1]; % Replace x_opt and y_opt with the coordinates of the known optimum
    plot(known_optimum(1), known_optimum(2), 'p', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g');
    
    % Initialize GIF
    filename = 'nelder_mead_visualization.gif';
    
    for iter = 1:maxiter
        fvals = arrayfun(@(i) f(S(:, i)), 1:n+1);
        
        [fvals, order] = sort(fvals);
        S = S(:, order);

        if std(fvals) <= tol
            break;
        end

        centroid = mean(S(:, 1:n), 2);
        xref = centroid + alpha * (centroid - S(:, end));
        fref = f(xref);

        if fref < fvals(1)
            xexp = centroid + gamma * (xref - centroid);
            fexp = f(xexp);
            
            if fexp < fvals(1)
                S(:, end) = xexp;
            else
                S(:, end) = xref;
            end
        else
            if fref < fvals(n)
                S(:, end) = xref;
            else
                xcont = centroid + rho * (S(:, end) - centroid);
                fcont = f(xcont);
                
                if fcont < fvals(end)
                    S(:, end) = xcont;
                else
                    for j = 2:n+1
                        S(:, j) = S(:, 1) + sigma * (S(:, j) - S(:, 1));
                    end
                end
            end
        end
        
        % Visualization: Update the plot
        set(h, 'XData', S(1, :), 'YData', S(2, :));
        drawnow;
         % Capture the plot as an image 
        frame = getframe; 
        im = frame2im(frame); 
        [imind,cm] = rgb2ind(im,256);
        
         % Write to the GIF File 
        if iter == 1 
            imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime', 0.2); 
        else 
            imwrite(imind,cm,filename,'gif','WriteMode','append', 'DelayTime', 0.2); 
        end 
        
        pause(0.3);  % pause for 0.1 seconds to visualize, adjust if needed
    end

    xmin = S(:, 1);
    fmin = fvals(1);
    
    
    hold off;
end
