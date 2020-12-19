close all;
clear all;
clc;
prompt = 'ÇëÊäÈë°´¼üÖµ£º';
str = '';
fs = 8000;
t = 0.2;
while 1
    str = input(prompt,'s');
    if length(str) ~= 1
        continue
    end
    if str == '1' || str == '2' || str == '3' || str == '4' ...
            || str == '5' || str == '6' || str == '7' || str == '8' ...
            || str == '9' || str == '*' || str == '0' || str == '#' ...
            || str == 'A' || str == 'B' || str == 'C' || str == 'D'
        break
    end
end
signal = generate_dtmf(str, fs * t, fs);
plot(0:1/fs:t-1/fs, signal);
xlabel('time (s)');
title(['Key ', str]);

