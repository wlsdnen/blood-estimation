function feature_extractor(record_id)
filename = sprintf('%03d.mat', record_id);
data = load(filename);
disp(filename);

%% Align annotation for getting normal beats
[data.iecg,data.iabp,data.ippg,data.label] = align_signals(data.iecg, data.iabp, data.ippg, data.label);

num_ch = length(data.ecg_ch);
num_beat = 5;

%% make beat annotation
data.iabp = point2beat(data.iabp,num_beat);
data.iecg = point2beat(data.iecg,num_beat);
data.ippg = point2beat(data.ippg,num_beat);
data.abp = data.abp(1:end-num_beat);
data.ecg = data.ecg(1:end-num_beat);
data.ppg = data.ppg(1:end-num_beat);
data.label = data.label(1:end-num_beat,:);

[features.ecg, features.ppg] = wave2beat(data.iecg, data.ippg, data.ecg, data.ppg, num_ch, num_beat);
[features.labp, features.lecg, features.lppg] = get_length(data.iabp, data.iecg, data.ippg, num_ch);

%% label replication
features.systolic       = repmat(data.label(:,1), num_ch, 1);
features.diastolic      = repmat(data.label(:,2), num_ch, 1);

%% index data
features.index          = merge_index(record_id, data.iecg, data.iabp, data.ippg, data.ecg_ch);

%% save
filename = sprintf('%03d_features.mat', record_id);
save (filename,'-struct', 'features', '-v7.3');
fprintf('saved features - %03d\n', record_id);

end