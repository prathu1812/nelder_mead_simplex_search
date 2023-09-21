
![Nelder-Mead Simplex Search](https://github.com/prathu1812/nelder_mead_simplex_search/blob/main/Simplex%20Search/nelder_mead_visualization.gif)

=====:Nelder-Mead Simplex Method for Optimization:====

The Nelder-Mead method is a direct search optimization technique that approximates the optimum of a function. This repository contains an educational implementation of the method, complete with visualization to aid understanding.

What is the Nelder-Mead Simplex Method?

The Nelder-Mead method is a numerical optimization algorithm used for finding the minimum of an objective function. It is especially useful for functions for which derivatives may not be computed easily. The algorithm uses the concept of a simplex, which is a polytope of n+1 vertices in n-dimensions, to probe the function landscape. The Nelder-Mead method is popular for its simplicity and efficacy in high-dimensional optimization problems. However, finding the global minimum for non-convex functions is not guaranteed.

How Does It Work?

The algorithm starts with an initial simplex, which evolves through a series of transformations to approximate the minimum of the objective function. The main steps involved in one iteration are: 

Reflection: Reflect the worst point in the simplex away from the other points.

Expansion: If the reflection point is better than the best point so far, then expand the simplex in the direction of the reflection.

Contraction: If the reflected point is not an improvement, contract the simplex towards the best point.

Shrink: If contraction fails to improve the worst point, then shrink the simplex toward the best point.


Applications
The Nelder-Mead method has wide-ranging applications, including Engineering design, Machine learning hyperparameter tuning, Computational biology, Financial modeling

License
This code is intended for educational purposes and is free to use and modify.
