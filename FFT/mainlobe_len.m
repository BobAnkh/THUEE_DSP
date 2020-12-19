% 绘制切比雪夫窗幅度谱
M=512;  % 窗长
r=45;    % 旁瓣抑制比例系数
win=[chebwin(M,r);zeros(7*M,1)];
semilogy(0:8*M-1, abs(fft(win)));
