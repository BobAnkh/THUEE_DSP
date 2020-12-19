function key = find_key_fft(xn, fs)
%find_key_fft: 使用fft来寻找键值
%   xn: 待测音频序列
%   fs: 采样率
    keys = [
    '1', '2', '3', 'A';
    '4', '5', '6', 'B';
    '7', '8', '9', 'C';
    '*', '0', '#', 'D'];
    len_x = length(xn);    
    N = 2 ^ nextpow2(len_x);
    X = fft(xn, N);
    X_abs = abs(X(1 : round(2000 / fs * N)));
    [~, locs] = findpeaks(X_abs, 'MinPeakHeight', max(X_abs) * 0.01, 'MinPeakDistance', floor(200 / fs * N), 'SortStr','descend','MinPeakProminence',10);
    if length(locs) < 2
        key = 'X';
    else
        freq1 = (min(locs(1:2)) - 1) / N * fs;
        freq2 = (max(locs(1:2)) - 1) / N * fs;
        if freq1 > 677 && freq1 < 717
            row = 1;
        elseif freq1 > 750 && freq1 < 790
            row = 2;
        elseif freq1 > 832 && freq1 < 872
            row = 3;
        elseif freq1 > 921 && freq1 < 961
            row = 4;
        else
            row = -1;
        end

        if freq2 > 1189 && freq2 < 1229
            col = 1;
        elseif freq2 > 1316 && freq2 < 1356
            col = 2;
        elseif freq2 > 1457 && freq2 < 1497
            col = 3;
        elseif freq2 > 1613 && freq2 < 1653
            col = 4;
        else
            col = -1;
        end
        if row == -1 || col == -1
            key = 'X';
        else
            key = keys(row, col);
        end
    end   
end
