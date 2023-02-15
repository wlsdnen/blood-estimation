function [ABP, ECG, PPG, ECG_CH] = separate_signals(signal,siginfo)

ECG = [];
ABP = [];
PPG = [];
ECG_CH = [];

keySet   =  {'I', 'II', 'III', 'V', 'MCL1', 'aVL', 'aVR', 'aVF'};
valueSet = [1,2,3,5,20,11,12,13];
mapObj   = containers.Map(keySet,valueSet);

% save into table ¿˙¿Â
for i = 1:length(siginfo)
    category = siginfo(i).Description;
    switch category
        case {'II'}
            ECG = [ECG, signal(:,i)];
            ECG_CH = [ECG_CH, mapObj(category)];
        case 'ABP'
            ABP = signal(:,i);
        case 'PLETH'
            PPG = signal(:,i);
    end   
end

end

