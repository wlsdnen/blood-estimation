function features = filterByCondition(varargin)

condition = varargin{1};
features = varargin{2};
fields = fieldnames(varargin{2});

for i=1:size(fields,1)
    arr = features.(fields{i});
    features.(fields{i}) = arr(condition,:);
end

end