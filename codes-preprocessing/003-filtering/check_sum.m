function [condition] = check_sum(signal)
%CHECK_NAN 이 함수의 요약 설명 위치
%   자세한 설명 위치

sum_signal = sum(abs(signal), 2);
condition = sum_signal > 0;

end