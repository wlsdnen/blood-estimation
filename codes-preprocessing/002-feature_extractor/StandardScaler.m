function [out] = StandardScaler(in)
%NORMALIZER �� �Լ��� ��� ���� ��ġ

dims = size(in);

for i=1:dims(2)
    
    in(:,i) = (in(:,i) - nanmean(in(:,i))) / nanstd(in(:,i));
    
end

out = in;

end

