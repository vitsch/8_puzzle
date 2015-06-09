%
% Manhattan metrics + Hierarchy' Level (Nielsson sequence) for new nodes
% in the list L
%
function [Mh,lev] = trees_mh(L) 
global T0 T1 np N1 nls_f
n = size(L,2);
Mh = zeros(1,n);
for k = 1:n
  T = L{k};  
  for i = 1:3      % columns
    for j = 1:3     % rows
      t = T(i,j);   % t is the tile number
      if t ~= 0 % except the blank
        ti = find(T1 == t);    
        A = T0(ti,:);
        man1 = abs(i - A(1)) + abs(j - A(2));
        Mh(k) = Mh(k) + man1;      
      end
    end
  end
  if nls_f
     nls = trees_nls(T);
     Mh(k) = Mh(k) + 3*nls;
  end
end

% Count hierarchy's Level (or the cost of getting the node np) 
lev = 0;
np1 = np;
while np1 ~= 0 % not the root node
  lev = lev + 1;
  np1 = N1(np1,1); % get a parent of node np1
end
return
