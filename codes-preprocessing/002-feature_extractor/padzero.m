function out = padzero(in, NUM_OF_BEATS)
%PADZERRO 이 함수의 요약 설명 위치
DATA_SIZE = 200 * NUM_OF_BEATS;
PAD_SIZE = 25;
SIGNAL_SIZE = DATA_SIZE - (PAD_SIZE * 2);
offset = 1;

N = length(in);
diff = SIGNAL_SIZE - N;
remainder = mod(diff, 2);

out = zeros(DATA_SIZE,1);

switch remainder
    case 0
        idx = PAD_SIZE + (diff/2) + offset;
        out(idx:idx+N-1) = in;
    case 1
        idx = PAD_SIZE + (diff-1)/2 + offset;
        out(idx:idx+N-1) = in;
end

end