function [tb_record, ECG_channels] = record2table(signal,time,siginfo)

ECG = [];
ABP = [];
PPG = [];
VariableNames = {'ECG', 'ABP', 'PPG', 'TIME'};
VariableUnits = {'mV', 'mmHg', 'mV', ''};
ECG_channels = [];

% save into table ¿˙¿Â
for i = 1:length(siginfo)
    category = siginfo(i).Description;
    switch category
%         case {'I', 'II', 'III', 'V', 'MCL1', 'aVL', 'aVR', 'aVF'}
        case 'II'
            ECG = signal(:,i);
            ECG_channels = category;
        case 'ABP'
            ABP = signal(:,i);
        case 'PLETH'
            PPG = signal(:,i);
    end   
end

tb_record = table(ECG, ABP, PPG, time, 'VariableNames', VariableNames);
tb_record.Properties.VariableUnits = VariableUnits;

end

