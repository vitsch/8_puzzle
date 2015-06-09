%
% A* search tree algorithm for solving 8 puzzle problem
% Inputs:
%   puzzle_ind = 1:30
%   print_f = 0/1, 1 to show the step solutions 
%   nls = 0/1, 1 to Nilsson Score
% Calls: 
%   trees (A* search)
%   trees_gm (Generate moves)
%   trees_mh (Manhattan metrics)
%   trees_nls (Nilsson sequence)
% Uses:
%   combinations.mat (30 resolvable puzzle combinations)
%
function trees_main(puzzle_ind,print_f,nls)
global Tg T0 T1 nls_f % These variables are visible in all functions
nls_f = nls;
Tg = [1 2 3; 8 0 4; 7 6 5]; % Goal sequence
% Coordinates (row and column) of tiles in a puzzle
T0 = [1 1; 1 2; 1 3; 2 1; 2 2; 2 3; 3 1; 3 2; 3 3]; 
T1 = [1 2 3 8 0 4 7 6 5];
load combinations Cmb

if puzzle_ind >= 1 && puzzle_ind <= 30 
  P = Cmb{puzzle_ind};  % assign the Puzzle
  [T,n1,n2] = trees(P,print_f); % call A* search function
  fprintf('\nPuzzle:\n')
  fprintf('% 1i %1i %1i\n',Cmb{puzzle_ind}')
  fprintf('Solution:\n')
  fprintf('% 1i %1i %1i\n',T') 
  fprintf('Number of nodes = %4i\nNumber of moves = %2i\n\n',n1,n2)
end
trees_plot(puzzle_ind); % statistics
return

function trees_plot(pind)
global N1 nls_f
M = (N1(:,[2 8])');
n = size(M,2);
plot(1:n,M)
xlabel('Number of Tested Nodes')
ylabel('Metrics (without cost)')
if nls_f == 0
  s1 = 'No';
else
  s1 = 'Yes';
end
title(sprintf('Puzzle Index %2i, NSS %s',pind,s1))
axis([1 n 0 max(M(1,:))+1])
grid on
text(5,15,'Level (Cost)')
return
