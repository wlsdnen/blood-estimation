function noise_remove(record_id)
filename = sprintf('%03d_features.mat', record_id);
load(filename);

%% Check PPG NaN.
condition = check_nan(features.ppg);
features = filterByCondition(condition, features);

%% Check ECG NaN.
condition = check_nan(features.ecg);
features = filterByCondition(condition, features);

%% Check PPG sum.      
condition = check_sum(features.ppg);
features = filterByCondition(condition, features);

%% Check ECG sum.      
condition = check_sum(features.ecg);
features = filterByCondition(condition, features);

%% Remove outliers over 1sigma.
SIGMA = 1;
condition = filterBySigma(features, SIGMA);
features = filterByCondition(condition, features);

%% save
filename = sprintf('%03d_filtered.mat', record_id);
save (filename, 'features', '-v7.3')
fprintf('saved - %03d\n', record_id);
end