function [out] = StandardScaler(in)
%NORMALIZER 이 함수의 요약 설명 위치

dims = size(in);

for i=1:dims(2)
    
    in(:,i) = (in(:,i) - nanmean(in(:,i))) / nanstd(in(:,i));
    
end

out = in;

end

