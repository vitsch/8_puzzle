% 
% Generate chidren nodes for puzzle T.
% Return array Z of n non-repeated children nodes.
%
function [Z,n] = trees_gm(T)
global L1
A = trees_fb(T); % to find a row A(1) and coulumn A(2) of the blank in T

% Possible blank's positions
M = [];             % coordinates of possible blank's positions
if A(1) < 3
  M = [M; [A(1) + 1, A(2)]]; % the blank gets down
end
if A(1) > 1
  M = [M; [A(1) - 1, A(2)]]; % the blank gets up
end
if A(2) < 3
  M = [M; [A(1), A(2) + 1]]; % the blank gets right
end
if A(2) > 1
  M = [M; [A(1), A(2) - 1]]; % the blank gets left
end

n = size(M,1); % number of children nodes
Tc2 = cell(n,1); % set an array of n children nodes
for i = 1:n
  Tc = T;   % copy T
  tn = Tc(M(i,1),M(i,2)); % get a tile number to be moved
  Tc(A(1),A(2)) = tn; % insert tn in blank's place
  Tc(M(i,1),M(i,2)) = 0; % insert 0 in tn  
  Tc2{i} = Tc; % copy the new move to the array
end

% Remove repeating nodes
len1 = size(L1,2); 
k = 0;
Z = []; % array for non-repeated chidren nodes
for i = 1:n
  f = 1;      % flagging a non-repeated node
  for j = 1:len1
    if sum(sum(Tc2{i} == L1{j})) == 9 % repeated node 
      f = 0;
      break;
    end
  end
  if f == 1
    k = k + 1;
    Z{1,k} = Tc2{i};
  end
end
n = size(Z,2);
return

function A = trees_fb(T)
% Find blank tile in a puzzle T 
% A are the coordinates of the blank tile
% Example:
%  1 2 3
%  8 4 0 => z = 8 => A(1) = 8 - 6 = 2 => A(2) = ceil(8/3) = 3 
%  7 6 5
z = find(T == 0); % z = 1:9 
A(1) = mod(z,3); % the blank's raw
if A(1) == 0
  A(1) = 3;
end
A(2) = ceil(z/3); % the blank's column
return