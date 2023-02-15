fileFirst = 39;
fileLast = 485;

parfor i = fileFirst:fileLast
    dirname = sprintf('%03d', i);
    if exist(dirname, 'dir')
        % convert .dat to .mat format
%         dat2mat(i);
        % merge each record into a single record
%         
%         merge_signal(i);
        if exist(strcat(dirname, '.mat'), 'file')
            feature_extractor(i);
            noise_remove_ch2(i);
        end
    end
end

disp('finish');