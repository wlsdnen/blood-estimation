function noise_remove_ch2(record_id)
filename = sprintf('%03d_features.mat', record_id);
data = load(filename);

%% Check PPG NaN.
condition = check_nan(data.ppg);
data = filterByCondition(condition, data);

%% Check ECG NaN.
condition = check_nan(data.ecg);
data = filterByCondition(condition, data);

%% Check PPG sum.      
condition = check_sum(data.ppg);
data = filterByCondition(condition, data);

%% Check ECG sum.      
condition = check_sum(data.ecg);
data = filterByCondition(condition, data);

%% Check blood pressure noise.
condition = check_SAI(data.systolic, data.diastolic, data.systolic - data.diastolic);
data = filterByCondition(condition, data);

%% Remove outliers over 1sigma.
SIGMA = 1;
condition = filterBySigma(data, SIGMA);
data = filterByCondition(condition, data);

%% save
filename = sprintf('%03d_filtered.mat', record_id);
save (filename, '-struct', 'data', '-v7.3')
fprintf('saved - %03d\n', record_id);

end