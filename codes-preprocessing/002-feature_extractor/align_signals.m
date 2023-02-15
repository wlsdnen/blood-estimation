function [out_ECG, out_ABP, out_PPG, out_Labels] = align_signals(ann_ECG, ann_ABP, ann_PPG, Labels)
% Beat to beat index
ann_ECG(:,2:4) = 1;
ann_ABP(:,2:4) = 2;
ann_PPG(:,2:4) = 3;
ann_ABP(:,3:4) = Labels;

ann = sortrows([ann_ECG; ann_ABP; ann_PPG], 1);
merged = zeros(size(ann));
numOfElement = 0;
% ECG/ABP/PPG 순서로 정렬되어 있는 annotation만 저장
for i=1:length(merged)-2
    if isequal(ann(i, 2), 1) & isequal(ann(i+1, 2), 2) & isequal(ann(i+2, 2), 3)
        merged(numOfElement+1:numOfElement+3, :) = ann(i:i+2, :);
        numOfElement = numOfElement + 3;
    end
end
merged     = merged(1:numOfElement, :);
% ECG annotation
out_ECG    = merged(merged(:,2) == 1, 1);
% ABP annotation
out_ABP    = merged(merged(:,2) == 2, 1);
% PPG annotation
out_PPG    = merged(merged(:,2) == 3, 1);
% ABP Labels
out_Labels = merged(merged(:,2) == 2, 3:4);

end