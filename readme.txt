Assignment 1 :

The folder contains plot2DMap.m, map1.mat and a_star.m files

The map1.mat is the original matrix that determined the environment

a_star.m is a function that determined a path in a matrix from a start point to a goal :

path = a_star(matrix, start, goal)

matrix is in this assignment mat1.mat
start is the starting point in an array format : [x, y]
goal is the ending point in the same format : [x, y]
path is a matrix describing the shortest path from start to goal in matrix m

To plot the result we can use the plot2DMap function

plot2DMap(matrix, path)
matrix is in this situation mat1.mat
path is the a_star result

So for example with a starting point in [10, 40] and a goal of [90, 90] just write this line in the terminal :

plot2DMap(map1, a_star(map1, [10, 40], [90, 90]))

