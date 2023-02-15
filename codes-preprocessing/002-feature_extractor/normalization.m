function out = normalization(record)
%Normalize ECG and PPG data.
record.ECG = StandardScaler(record.ECG);
record.PPG = StandardScaler(record.PPG);
out = record;
end
