function [condition] = check_nan(signal)
%CHECK_NAN �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ

sum_signal = sum(signal, 2);
condition = ~isnan(sum_signal);

end