clear all;
close all;
% ���ɴ������źż�������
% fs�ǲ�����
fs = 256;
% M�ǲ�������ͬʱҲ�Ǳ任����
M = 512;
t = [0:1/fs:(M-1)/fs];
xn = 0.8*sin(2*pi*103*t)+sin(2*pi*107*t)+0.1*sin(2*pi*115*t);
% ѡ���б�ѩ��
wn = chebwin(M, 45);
xw = xn.*wn';
% �������źŲ����Ľ�������data.txt�й�C++����DFT/FFT���б任
data_file = fopen('data.txt','w');
fprintf(data_file,'%f 0\n',xw);
fclose(data_file);

% ͨ����ȡ����ķ�ʽ��ͣMATLAB����,�ȴ�ʹ��C++������ɱ任
ch = input("�ȴ�FFT�������\n���������������Y���к�������,��ֹ�����������ַ�:", 's');
if ch ~= 'Y'
    disp("FFT����ʧ��");
else
    result_file = fopen('fft_result.txt', 'r');
    fft_r = fscanf(result_file, '%f %f', [2 inf]);
    XN = zeros(1, M);
    % ������������ļ��еĽ��ת���ظ�������
    for k=1:M
        XN(k) = complex(fft_r(1,k),fft_r(2,k));
    end
    %��������ת������ʾΪƵ��f
    f = (0:length(XN)-1)*fs/length(XN);
    plot(f, abs(XN));
    title('FFT Spectrum');
    xlabel('f/Hz');
end