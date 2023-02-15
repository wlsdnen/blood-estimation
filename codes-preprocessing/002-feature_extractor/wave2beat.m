function [varargout] = wave2beat(varargin)
%WAVE2BEAT 이 함수의 요약 설명 위치
DATA_SIZE = 200 * varargin{end};
PAD_SIZE = 50;

signal1 = cell(varargin{end-1},1);
signal2 = cell(varargin{end-1},1);

for i=1:varargin{end-1}
    signal1{i} = zeros(size(varargin{1},1), DATA_SIZE);
    signal2{i} = zeros(size(varargin{1},1), DATA_SIZE);
end

for i=1:size(varargin{1}, 1)
    for j=1:varargin{end-1}
        init1 = varargin{1}(i,1); last1 = varargin{1}(i,2);
        init2 = varargin{2}(i,1); last2 = varargin{2}(i,2);
        % check length
        if numel(init1:last1) <= DATA_SIZE - PAD_SIZE && numel(init2:last2) <= DATA_SIZE - PAD_SIZE
            signal1{j}(i,:) = padzero(varargin{3}(init1:last1), varargin{end});
            signal2{j}(i,:) = padzero(varargin{4}(init2:last2), varargin{end});
        end
    end
end

% cell2mat -> varargout assign
varargout{1} = cell2mat(signal1);
varargout{2} = cell2mat(signal2);

end