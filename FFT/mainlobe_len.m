% �����б�ѩ�򴰷�����
M=512;  % ����
r=45;    % �԰����Ʊ���ϵ��
win=[chebwin(M,r);zeros(7*M,1)];
semilogy(0:8*M-1, abs(fft(win)));
