function [data,time,siginfo] = concat_record(id)
% 파일을 순차적으로 읽으면서, data, time array에 concatenate한다.
% 일반적으로 75000개씩 쌓이지만, 마지막 record 파일은 75000개보다 개수가 적다.
init    = sscanf(strcat(num2str(id), sprintf('00001')), '%d');
last    = sscanf(strcat(num2str(id), sprintf('01000')), '%d');

data = {};
time = {};

% Merge signal data
for i = init:last
    filename = sprintf('%08dm', i);
    try
        %   mat파일 읽고 signal 데이터 array에 저장.
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

