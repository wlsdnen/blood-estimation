function [idx_abp, idx_ecg, idx_ppg] = get_length(abp, ecg, ppg, num_ch)

data_size = size(abp,1);

idx_abp = zeros(data_size,1);
idx_ecg = zeros(data_size,1);
idx_ppg = zeros(data_size,1);

for i=1:data_size
    idx_abp(i) = numel(abp(i,1):abp(i,2));
    idx_ecg(i) = numel(ecg(i,1):ecg(i,2));
    idx_ppg(i) = numel(ppg(i,1):ppg(i,2));
end

idx_abp = repmat(idx_abp, num_ch, 1);
idx_ecg = repmat(idx_ecg, num_ch, 1);
idx_ppg = repmat(idx_ppg, num_ch, 1);

end