%% map each record to its subject.
clc; clear;
list = dlmread('subject.txt');
subject_id = unique(list(:,2));

subject = [];

for iter=1:length(list)
    rid = list(iter,1);
    sid = list(iter,2);
    infile = sprintf('%03d_filtered.mat', rid);
    
    features = load(infile);
    subject = merge_record(subject, features);
    
    if iter == length(list) || sid ~= list(iter+1,2) 
        
        outfile = sprintf('subject%03d.mat', sid);
        save(outfile, 'subject','-v7.3');

        subject = [];
    end
    
end
