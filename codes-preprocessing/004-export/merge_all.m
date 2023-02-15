%% map each record to its subject.
clc; clear all;
list = dlmread('subject.txt');
subject_id = unique(list(:,2));
filelist = [];
cursor = 1;

for iter=1:length(list)
            
    idx = list(iter,1);
    infile = sprintf('%03d_filtered.mat', idx);
    load(infile);
    
    try
        subject = merge_record(subject, features);
    catch
        fields = fieldnames(features);
        N = size(fields,1);
        
        num_pick = 50000;
        data_size = size(features.abp_length,1);
        indices = randperm(data_size, num_pick);
        subject = features;
        
        for i=1:N
            arr = features.(fields{i})(indices,:);
            subject.(fields{i}) = arr;
        end
    end
end

