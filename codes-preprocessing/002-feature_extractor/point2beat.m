function [beats] = point2beat(annotation, N)
len = size(annotation,1);
beats = zeros(len-N,2);

for i=1:len-N
    beats(i,:) = [annotation(i,1), annotation(i+N)];
end

end
