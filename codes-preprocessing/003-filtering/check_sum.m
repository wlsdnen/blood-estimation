function [condition] = check_sum(signal)
%CHECK_NAN �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ

sum_signal = sum(abs(signal), 2);
condition = sum_signal > 0;

end