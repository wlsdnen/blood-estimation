function [output] = merge_index(varargin)

output = zeros(size(varargin{2},1), 5);
output(:,1) = varargin{1};
output(:,2) = varargin{2};
output(:,3) = varargin{3};
output(:,4) = varargin{4};
output(:,5) = varargin{5};

end