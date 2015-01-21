An Empirical algorithm for minimization lines for segments list

For example, we have a segments list 
[(0,1), (1,5), (2,4), (4,5)]
where each (x, y) pair contains 
   x - left coordinate of segment and 
   y - right coordinate of segment
   
The goal is to place all these segments on separate lines so
all segments on each line do not intersect each other and
total count of required lines will be minimal.

For our example above the solution may be:
minimal lines count is 2
[[(0, 1), (1,5)], [(2,4), (4,5)]]



