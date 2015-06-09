% Classical search problem 
% 8 Puzzle Matlab Illustration       
%
% A* search tree algorithm for solving 8 puzzle problem
%
% trees_main(puzzle_ind,print_f,nls)
% Inputs:
%   puzzle_ind = 1:30
%   print_f = 0/1, 1 to show the step solutions 
%   nls = 0/1, 1 to Nilsson Score
%
% Calls functions: 
%   trees (A* search)
%   trees_gm (Generate moves)
%   trees_mh (Manhattan metrics)
%   trees_nls (Nilsson sequence)
%
% Uses:
%   combinations.mat (30 resolvable puzzle combinations)
%
