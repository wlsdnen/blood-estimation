function feature_extractor_ch2(record_id)

filename = sprintf('%03d.mat', record_id);
data = load(filename);

%% Align annotation for getting normal beats
[data.index_ecg,data.index_abp,data.index_ppg,data.label] = align_signals(data.index_ecg, data.index_abp, data.index_ppg, data.label);

%% beat to beat data extraction
fs = 125; 
sec = 30;
idx = data.index_ecg > (fs*sec);
data.index_ecg = data.index_ecg(idx);
data.index_abp = data.index_abp(idx);
data.index_ppg = data.index_ppg(idx);
data.label = data.label(idx,:);
[features.ecg, features.ppg] = fixed_waveform(data.index_ecg, data.index_ppg, data.ECG, data.PPG, sec);

%% label replication
features.systolic       = data.label(:,1);
features.diastolic      = data.label(:,2);

%% index data
features.index          = merge_index(record_id, data.index_ecg, data.index_abp, data.index_ppg);

%% save
filename = sprintf('%03d_features.mat', record_id);
save (filename,'-struct', 'features','-v7.3');
fprintf('saved features - %03d\n', record_id);

end