function key = find_key_goertzel(xn, fs)
%find_key_goertzel: 使用goertzel来寻找键值
%   xn: 待测音频序列
%   fs: 采样率
    freq_list = [697, 770, 852, 941, 1209, 1336, 1477, 1633];
    keys = [
    '1', '2', '3', 'A';
    '4', '5', '6', 'B';
    '7', '8', '9', 'C';
    '*', '0', '#', 'D'];
    N = length(xn);
    omega_list = 2 * pi * round(freq_list / fs * N) / N;
    cos_wk = cos(omega_list);

    v0 = zeros(1, 8);
    v1 = zeros(1, 8);
    v = zeros(1, 8);
    for a = 1 : N
        v0 = v1;
        v1 = v;
        v = 2 * cos_wk .* v1 - v0 + xn(a);
    end
    XK = v - v1 .* exp(-1j * omega_list);
    [~, row] = max(abs(XK(1:4)));
    [~, col] = max(abs(XK(5:8)));
    key = keys(row, col);
end

