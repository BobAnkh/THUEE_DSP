% ����������ɸ������ݵ�data.txt�У����ڲ���
% M �Ǹ������ݵĸ���
M=65536;
R = -10 + 20.*rand(1, 2*M);

data_file = fopen('data.txt','w');
fprintf(data_file,'%f %f\n',R);
fclose(data_file);

% �����ݴ���xn��
xn = zeros(1, M);
for k=1:M
    xn(k) = R(2*k-1) + 1i * R(2*k);
end