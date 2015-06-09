%
% A* search
%
% Parameters: 
%   T is the Puzzle
%   print_f = 0/1 
%
function [T,no_nodes,no_moves] = trees(T,print_f)
global Tg L1 N1 np n 
np = 0;       % parent node's pointer (for the root node it is 0)
L1 = cell(1); % define list L1 of the tested combinations
L1{1} = T;    % put the start state to list L1
N1 = [];  % define list N1 describing the relations between nodes:
%   1) parent pointer
%   2) Manhattan metrics
%   3) Number of children
%   4:7) indexes for up 4 children nodes
%   8) hierarchy's level

% Run the loop while T is not Tg 
while sum(sum(T == Tg)) ~= 9 
  % Generate possible moves as 3x3 matrices for current state T
  if np == 0 || N1(np,3) == 0 % if root node or a node with no children yet
    [L,n] = trees_gm(T); % make n non-repeated children nodes
    
    % Add the children nodes and their indeces into lists L1 and N1
    n0 = size(L1,2); % number of nodes tested (the index of the last tested node)
    L1 = [L1 L];     % add new children nodes 
    C = zeros(1,4);  % set indexes for maximal number of children nodes
    for i = 1:n
      C(i) = n0 + i;
    end
    
    if np == 0    % the root node
       Mh = trees_mh(L1(1)); % Manhattan metrics for the root node
       N1(1,:) = [0 Mh n C 0]; % create the first row in N1 
       np = 1;     % assign the node pointer to 1
    else
       N1(np,3:7) = [n C]; % n children nodes are assigned to its parent node
    end
    
    [Mh,lev] = trees_mh(L);  % Call Manhattan for children from list L
    for i = 1:n % Add the n children nodes to N1
      N1 = [N1; [np Mh(i) 0 0 0 0 0 lev]];
    end
  else
    n = N1(np,3); % n is the number of children nodes
  end
  
  if n == 0 % all the children nodes are repeated
    N1(np,3) = -1; % avoid choosing this node again
    np = N1(np,1); % move up to the parent of the node np 
  end
  
    % Make best move on Manhattan_distance + level_cost
    A = find(N1(:,3) == 0); % find the indeces of nodes with 0 children nodes
    [mmin,mi] = min(sum(N1(A,[2 8])')); % the best node
    np = A(mi); % assign node pointer to a new node   
    if print_f
      % Print: number of nodes, Manhattan, last best manhattan+level value,
      % and number of moves
      fprintf('%6i, %2i, %4i, %2i \n',size(N1,1),N1(np,2),mmin,N1(np,8))
    end
    T = L1{np}; % update the current state T with the selected move
end
no_nodes = size(N1,1); % num of nodes created and tested
no_moves = N1(np,8); % num of moves made
return
