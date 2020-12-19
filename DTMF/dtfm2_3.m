close all;
clear all;

[xn,fs] = audioread('附件2/data.wav');
[start, finish] = segment(xn);
% 绘制分段结果
plot(xn, '-k');
hold on;
stem(start,ones(length(start)), '-or');
stem(finish,ones(length(finish)), '-ob');
title('分段结果(红色点表示开始，蓝色点表示结束)', 'FontSize', 12);


% 寻找序列各分段的key
num_key = length(start);
fft_keys = zeros(1, num_key);
goertzel_keys = zeros(1, num_key);
for a = 1:num_key
    fft_keys(a) = find_key_fft(xn(start(a):finish(a)), fs);
    goertzel_keys(a) = find_key_goertzel(xn(start(a):finish(a)), fs);
end
fft_keys = char(fft_keys);
goertzel_keys = char(goertzel_keys);
disp(['FFT result:      ', fft_keys]);
disp(['Goertzel result: ', goertzel_keys]);

function [start, finish] = segment(xn)
% segment: 切分出DTMF信号，返回起点和终点的位置数组
%   xn: 时域信号
threshold = 0.1 * max(xn);
win_len = 100;
frame = 1;

xn_len = length(xn);
start = [];
finish = [];
silence = true;

while frame <= xn_len
    if xn(frame) > threshold && silence
        start = [start, frame];
        silence = false;
    end
    if sum(xn(frame:min(xn_len, frame + win_len)) > threshold) == 0 && ~silence
        finish = [finish, frame];
        silence = true;
    end
    frame = frame + 1;
end
if length(start) - length(finish) == 1
    finish = [finish, xn_len];
end

end