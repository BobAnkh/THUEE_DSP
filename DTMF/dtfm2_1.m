close all;
clear all;
files = dir('¸½¼þ1');
files = files(3:end);
disp('Use FFT to detect:');
for a=1:length(files)
    [xn,fs] = audioread(['¸½¼þ1/', files(a).name]);
    key = find_key_fft(xn, fs);
    disp(['File Name: ', files(a).name, '  Key: ', key]);
end