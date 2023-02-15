function output = merge_index_BP(varargin)
%features.index = merge_index(record_id, annotation.beat_abp, annotation.beat_ecg, annotation.beat_ppg, annotation.channels);
keySet   =  {'I', 'II', 'III', 'V', 'MCL1', 'aVL', 'aVR', 'aVF'};
valueSet = [1,2,3,5,6,7,8,9];
mapObj   = containers.Map(keySet,valueSet);

output = {};

temp = zeros(size(varargin{2},1), 4);
temp(:,1) = varargin{1};
temp(:,3:4) = varargin{2};

for i=1:numel(varargin{3})
    temp(:,2) = mapObj(varargin{3}{i});
    output{i,1} = temp;
end

output = cell2mat(output);

end