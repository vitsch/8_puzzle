%
% Nilsson's sequence score for puzzle T
%
function nilsson = trees_nls(T)
% Picking up puzzle tiles in clockwise order from a given puzzle T
Ns = [T(1,:) T(2,3) T(3,3:-1:1) T(2,1)]; % 1D array for 8 tiles

% The right sequence of tiles in Ns is: 1 2 3 4 5 6 7 8
% That is: Ns(2)-Ns(1) = 1, Ns(3)-Ns(2) = 1, …, Ns(8) - Ns(7) 
% Add 2 for each tile which follows in a wrong sequence
nilsson = 0;
for i = 2:8
  if Ns(i) - Ns(i - 1) ~= 1
    nilsson = nilsson + 2;
  end
end
% Add 1 if the centre is not empty
if T(2,2) ~= 0
  nilsson = nilsson + 1;
end
return