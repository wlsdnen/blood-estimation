%% map each record to its subject.
clc; clear all;
list = dlmread('subject.txt');
subject_id = unique(list(:,2));
filelist = [];
cursor = 1;
for iter=1:length(list)
    ii = list(iter,1);
    jj = list(iter,2);
    infile = sprintf('%03d_filtered.mat', ii);
    load(infile);
    if exist(sprintf('subject%03d', jj), 'var')
        eval(sprintf('subject%03d = merge_record(subject%03d, features);', jj, jj));        
    else
        eval(sprintf('subject%03d = features;', jj));
    end
end

for i=1:length(subject_id)
    
    filename = sprintf('subject%03d.mat',subject_id(i));
    varname = sprintf('subject%03d',subject_id(i));
    subject = varname;
    
    eval(sprintf('%s = check_size(%s);',varname,varname));
    
    save(filename, subject,'-v7.3')
    clearvars subject
    
end