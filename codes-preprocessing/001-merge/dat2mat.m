function dat2mat(rid)
% % % % % % % % % % % % % % % % % % %
% %           .dat -> .mat        % %
% % % % % % % % % % % % % % % % % % %

cd (sprintf('%03d', rid));

% ����& �� �ε��� ����
startIdx = 1;
lastIdx  = 500;

for i = startIdx:lastIdx
    
    filename = sprintf('%03d%05d',rid,i);
    % .dat���� mat���Ϸ� ��ȯ
    if exist(strcat (filename, '.dat'), 'file') && ~exist(strcat (filename, 'm.mat'), 'file')    
        wfdb2mat(filename);
    end
    
end

cd ..

end