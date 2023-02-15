function [varargout] = fixed_waveform(varargin)
%WAVE2BEAT 이 함수의 요약 설명 위치
% varargin{1}: ECG annotation
% varargin{2}: PPG annotation
% varargin{3}: ECG singal
% varargin{4}: PPG signal
FS = 125;
DATA_SIZE = FS * varargin{5};
signal1 = zeros(size(varargin{1},1), DATA_SIZE);
signal2 = zeros(size(varargin{1},1), DATA_SIZE);

for i=1:size(varargin{1}, 1)
    init1 = varargin{1}(i)-DATA_SIZE+1; last1 = varargin{1}(i);
    init2 = varargin{2}(i)-DATA_SIZE+1; last2 = varargin{2}(i);
    signal1(i,:) = varargin{3}(init1:last1);
    signal2(i,:) = varargin{4}(init2:last2);
end

% cell2mat -> varargout assign
varargout{1} = signal1;
varargout{2} = signal2;
end