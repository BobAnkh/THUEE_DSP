% 用于随机生成复数数据到data.txt中，用于测试
% M 是复数数据的个数
M=65536;
R = -10 + 20.*rand(1, 2*M);

data_file = fopen('data.txt','w');
fprintf(data_file,'%f %f\n',R);
fclose(data_file);

% 将数据存于xn中
xn = zeros(1, M);
for k=1:M
    xn(k) = R(2*k-1) + 1i * R(2*k);
end