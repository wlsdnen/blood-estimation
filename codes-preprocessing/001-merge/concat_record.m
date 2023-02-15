function [data,time,siginfo] = concat_record(id)
% ������ ���������� �����鼭, data, time array�� concatenate�Ѵ�.
% �Ϲ������� 75000���� ��������, ������ record ������ 75000������ ������ ����.
init    = sscanf(strcat(num2str(id), sprintf('00001')), '%d');
last    = sscanf(strcat(num2str(id), sprintf('01000')), '%d');

data = {};
time = {};

% Merge signal data
for i = init:last
    filename = sprintf('%08dm', i);
    try
        %   mat���� �а� signal ������ array�� ����.
        [tm, signal, ~, siginfo] = rdmat(filename);
        data = [data; signal];
        time = [time; tm'];
    catch
        break;
    end
end

data = cell2mat(data);
time = cell2mat(time);

end

