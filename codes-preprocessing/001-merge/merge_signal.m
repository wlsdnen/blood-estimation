function merge_signal(record_id)
% 데이터 시작 & 끝 인덱스 저장.
cd (sprintf('%03d', record_id));

% merge each record into the single record
[signal,time,siginfo] = concat_record(record_id);
fprintf('merged - %03d\n',record_id);

% record table로 저장
[abp, ecg, ppg, ecg_ch] = separate_signals(signal,siginfo);

if ~isempty(ecg)
    rid = record_id;
    ann_name = sprintf('%03d', record_id);
    
    % Load annotations, 'abp' for blood pressure, 'qrs' for ECG, 'ple' for PPG
    [iabp,~,~,~,~,comments_abp] = rdann(ann_name ,'abp');
    iecg = rdann(ann_name ,'qrs');
    ippg = rdann(ann_name ,'ple');
    
    % 혈압 annotation 숫자값으로 변환하여 저장
    label= zeros(size(comments_abp, 1), 2);
    for k = 1:size(label, 1)
        label(k, :) = sscanf(comments_abp{k},'%d/%d', [1 2]);
    end
    
    cd ..
    filename = sprintf('%03d.mat', rid);
    save (filename, 'rid', 'abp', 'ecg', 'ppg', 'iabp', 'iecg','ippg', 'time', 'ecg_ch', 'label', '-v7.3', '-nocompression')
    fprintf('merged data saved - %03d\n', rid);
    

else
    cd ..
end

end