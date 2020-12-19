clear all;
close all;
% 生成待处理信号及其数据
% fs是采样率
fs = 256;
% M是采样点数同时也是变换点数
M = 512;
t = [0:1/fs:(M-1)/fs];
xn = 0.8*sin(2*pi*103*t)+sin(2*pi*107*t)+0.1*sin(2*pi*115*t);
% 选择切比雪夫窗
wn = chebwin(M, 45);
xw = xn.*wn';
% 将待测信号采样的结果输出到data.txt中供C++程序DFT/FFT进行变换
data_file = fopen('data.txt','w');
fprintf(data_file,'%f 0\n',xw);
fclose(data_file);

% 通过获取输入的方式暂停MATLAB程序,等待使用C++程序完成变换
ch = input("等待FFT处理完毕\n若处理完毕请输入Y进行后续处理,中止请输入其他字符:", 's');
if ch ~= 'Y'
    disp("FFT处理失败");
else
    result_file = fopen('fft_result.txt', 'r');
    fft_r = fscanf(result_file, '%f %f', [2 inf]);
    XN = zeros(1, M);
    % 将输出到数据文件中的结果转换回复数数组
    for k=1:M
        XN(k) = complex(fft_r(1,k),fft_r(2,k));
    end
    %将横坐标转化，显示为频率f
    f = (0:length(XN)-1)*fs/length(XN);
    plot(f, abs(XN));
    title('FFT Spectrum');
    xlabel('f/Hz');
end