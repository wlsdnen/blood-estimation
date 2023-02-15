function feature_extractor_original(record_id)
filename = sprintf('%03d.mat', record_id);
load(filename);

num_CH = size(annotation.channels, 2);

%% make beat annotation
annotation.beat_abp = point2beat(annotation.abp);
annotation.beat_ecg = point2beat(annotation.ecg);
annotation.beat_ppg = point2beat(annotation.ppg);
annotation.abp = annotation.abp(1:end-1);
annotation.ecg = annotation.ecg(1:end-1);
annotation.ppg = annotation.ppg(1:end-1);
annotation.label_abp = annotation.label_abp(1:end-1,:);

%% PTT
% features.PTT      = time_difference(annotation.ecg, annotation.ppg, record.TIME, num_CH);

%% beat to beat data extraction
% [features.beat_bp_ecg, features.beat_bp_ppg] = wave2beat(annotation.beat_abp, num_CH, record.ECG, record.PPG);
[features.beat_ecg, features.beat_ppg] = wave2beat(annotation.beat_ecg, num_CH, annotation.beat_ppg, record.ECG, record.PPG);

%% PIR
% features.PIR = getMinMaxDiff(features.beat_ppg, false);

%% get length of beat signals
[features.abp_length, features.ecg_length, features.ppg_length] = getLength(annotation.beat_abp, annotation.beat_ecg, annotation.beat_ppg, num_CH);
% features.abp_length     = getLengthBP(annotation.beat_abp, num_CH);

%% label replication
features.systolic       = repmat(annotation.label_abp(:,1), num_CH, 1);
features.diastolic      = repmat(annotation.label_abp(:,2), num_CH, 1);
features.pulse_pressure = repmat(annotation.label_abp(:,1)-annotation.label_abp(:,2), num_CH, 1);

%% index data
features.index          = merge_index(record_id, annotation.beat_ecg, annotation.beat_abp, annotation.beat_ppg, annotation.channels);

filename = sprintf('%03d_features.mat', record_id);
save (filename, 'features','-v7.3');
fprintf('saved - %03d\n', record_id);
end