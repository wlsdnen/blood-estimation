clc; clear all;
list = dlmread('subject.txt');
record_id = list(:,1);

for i=1:length(list)
        
    infile = sprintf('%03d.mat', record_id(i));
    data = load(infile);

    
    ABP = data.record.ABP;
    
    outfile_ABP = sprintf('%03d_ABP.mat', record_id(i));
    
    save(outfile_ABP,'ABP','-v7.3');
         
%     ECG = data.record.ECG;
%     PPG = data.record.PPG;
%     
%     outfile_ECG = sprintf('%03d_ECG.mat', record_id(i));
%     outfile_PPG = sprintf('%03d_PPG.mat', record_id(i));
%     
%     save(outfile_ECG,'ECG','-v7.3');
%     save(outfile_PPG,'PPG','-v7.3');

end