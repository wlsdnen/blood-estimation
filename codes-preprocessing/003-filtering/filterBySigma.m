function [condition] = filterBySigmaVar(features, coef)
%FILTERBYHAMPEL 이 함수의 요약 설명 위치

fields = fieldnames(features);
N = size(fields,1);
condition = [];

for i=1:N
    if size(features.(fields{i}),2) == 1
        arr = features.(fields{i});
        
        mean_arr = mean(arr);
        std_arr = std(arr)*coef;
        
        idx = (arr<mean_arr+std_arr) & (arr>mean_arr-std_arr);
        
        try condition = and(condition,idx);
        catch, condition = idx; end
    end
end

end

