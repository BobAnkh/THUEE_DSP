close all;
clear all;
files = dir('����1');
files = files(3:end);
disp('Use FFT to detect:');
for a=1:length(files)
    [xn,fs] = audioread(['����1/', files(a).name]);
    key = find_key_fft(xn, fs);
    disp(['File Name: ', files(a).name, '  Key: ', key]);
end