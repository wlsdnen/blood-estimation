function data = check_size(data)
%CHECKDATASIZE 이 함수의 요약 설명 위치
%   자세한 설명 위치
fields = fieldnames(data);
N = size(fields,1);
data_size = size(data.(fields{1}),1);
num_pick = 50000;

% 50000개보다 큰 경우, 랜덤하게 50000개 선택하여 저장
if data_size > num_pick
    indices = randperm(data_size, num_pick);
    for i=1:N
        data.(fields{i}) = data.(fields{i})(indices,:);
    end
% % 50000개보다 작은 경우, 50000개 이상이 될 때까지 stack
else
%     num_copy = ceil(num_pick/data_size);
%     for i=1:N
%         arr = repmat(data.(fields{i}), num_copy, 1);
%         data.(fields{i}) = arr(1:num_pick, :);
%     end
end