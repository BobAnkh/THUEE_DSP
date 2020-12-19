function signal = generate_dtmf(key, N, fs)
switch key
    case '1'
        omega = [697, 1209];
    case '2'
        omega = [697, 1336];
    case '3'
        omega = [697, 1477];
    case '4'
        omega = [770, 1209];
    case '5'
        omega = [770, 1336];
    case '6'
        omega = [770, 1477];
    case '7'
        omega = [852, 1209];
    case '8'
        omega = [852, 1336];
    case '9'
        omega = [852, 1477];
    case '*'
        omega = [941, 1209];
    case '0'
        omega = [941, 1336];
    case '#'
        omega = [941, 1477];
    case 'A'
        omega = [697, 1633];
    case 'B'
        omega = [770, 1633];
    case 'C'
        omega = [852, 1633];
    case 'D'
        omega = [941, 1633];
end
signal = generate_sin(2*pi*omega(1)/fs, N) + generate_sin(2*pi*omega(2)/fs, N);
end

function signal = generate_sin(omega, N)
%generate_sin 根据频率使用数字正弦振动器生成正弦信号
%   omega 频率
%   N 信号长度
yc_init = cos(omega);
ys_init = -sin(omega);
signal = zeros(1, N);
ycys = [yc_init;ys_init];
for a=1:N
    ycys = [cos(omega), -sin(omega); sin(omega), cos(omega)]*ycys;
    signal(a) = ycys(2);
end
end

