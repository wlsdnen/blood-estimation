function [condition] = check_nan(signal)
%CHECK_NAN 이 함수의 요약 설명 위치
%   자세한 설명 위치

sum_signal = sum(signal, 2);
condition = ~isnan(sum_signal);

end