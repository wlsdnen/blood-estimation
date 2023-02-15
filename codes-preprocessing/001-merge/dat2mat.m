function dat2mat(rid)
% % % % % % % % % % % % % % % % % % %
% %           .dat -> .mat        % %
% % % % % % % % % % % % % % % % % % %

cd (sprintf('%03d', rid));

% 시작& 끝 인덱스 저장
startIdx = 1;
lastIdx  = 500;

for i = startIdx:lastIdx
    
    filename = sprintf('%03d%05d',rid,i);
    % .dat파일 mat파일로 변환
    if exist(strcat (filename, '.dat'), 'file') && ~exist(strcat (filename, 'm.mat'), 'file')    
        wfdb2mat(filename);
    end
    
end

cd ..

end