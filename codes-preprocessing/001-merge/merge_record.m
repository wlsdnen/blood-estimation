function [s] = merge_record(s, data)

if isempty(s)
    s = data;
else
    fields = fieldnames(s);
    N = size(fields,1);
    
    for i=1:N
        arr = data.(fields{i});
        s.(fields{i}) = [s.(fields{i}); arr];
    end
end

end