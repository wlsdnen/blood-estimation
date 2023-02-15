function data = check_size(data)
%CHECKDATASIZE �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ
fields = fieldnames(data);
N = size(fields,1);
data_size = size(data.(fields{1}),1);
num_pick = 50000;

% 50000������ ū ���, �����ϰ� 50000�� �����Ͽ� ����
if data_size > num_pick
    indices = randperm(data_size, num_pick);
    for i=1:N
        data.(fields{i}) = data.(fields{i})(indices,:);
    end
% % 50000������ ���� ���, 50000�� �̻��� �� ������ stack
else
%     num_copy = ceil(num_pick/data_size);
%     for i=1:N
%         arr = repmat(data.(fields{i}), num_copy, 1);
%         data.(fields{i}) = arr(1:num_pick, :);
%     end
end