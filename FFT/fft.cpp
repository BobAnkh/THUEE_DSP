/*** 
 * @Author       : BobAnkh
 * @Github       : https://github.com/BobAnkh
 * @Date         : 2020-11-03 09:12:22
 * @LastEditTime : 2020-11-07 11:16:22
 * @Description  : 
 */
#include <string>
#include <iostream>
#include <fstream>
#include <cmath>
#include <complex>
#include <ctime>
#include <vector>
using namespace std;

const double PI = 3.14159265358979323846;

int main(){
    // 从data.txt中读取数据,每行表示一个复数,实部虚部以空格分隔
    ifstream infile("data.txt", ios_base::in);
    string s;
    int line_cnt = 0;   // 用于统计数据量
    vector<complex<double>> c_x; // 定义了复数类型的vector容器用于存放原始数据
    while(getline(infile, s)){
        line_cnt++;
        int space_place=s.find(" ");
        string s1 = s.substr(0, space_place);
        string s2 = s.substr(space_place + 1);
        c_x.push_back(complex<double> (stod(s1), stod(s2)));
    }
    infile.close();
    if (line_cnt == 0){
        cout<<"There is no data!"<<endl;
        return 1;
    }
    // 将数据末补零到2的幂次
    int m = ceil(log(line_cnt)/log(2));
    int N = 1<<m;
    for(int i=c_x.size(); i < N; i++){
        c_x.push_back(complex<double> (0,0));
    }
    cout<<N<<"-Point DFT/FFT"<<endl;

    // DFT
    vector<complex<double>> X_DFT; // 定义了复数类型的vector容器用于存放直接DFT的结果
    complex<double> W = polar(1.0, -2 * PI / N);
    int dft_start_time = clock();
    for (int i = 0; i < N; i++){
        complex<double> dft_tmp(0,0);
        for (int j = 0; j < N; j++){
            dft_tmp = dft_tmp + c_x[j] * pow(W, i * j);
        }
        X_DFT.push_back(dft_tmp);
    }
    int dft_end_time = clock();

    // 打印DFT结果
    // cout<<"DFT:"<<endl;
    // for (int i = 0; i < N; i++){
    //     cout<<X_DFT[i]<<endl;
    // }
    
    // 向文件中写入DFT结果
    ofstream outfile1("dft_result.txt", ios_base::out);
    for (int i = 0; i < N; i++){
        outfile1<<real(X_DFT[i])<<" "<<imag(X_DFT[i])<<endl;
    }
    outfile1.close();
    cout<<"DFT Time:"<<dft_end_time-dft_start_time<<endl;

    // DIT_FFT
    // 得到调整顺序后的输入序列(实现倒位序)
    vector<complex<double>> X_DIT_FFT(N); // 定义了复数类型的vector容器用于存放DIT-FFT的结果
    for (int i = 0; i < N; i++){
        int rev_seq = 0;
        int tmp_d = i;
        for (int j = m - 1; j >= 0 ; j--){
            int tmp = tmp_d % 2;
            tmp_d = tmp_d / 2;
            rev_seq = rev_seq + (1<<j) * tmp;
        }
        X_DIT_FFT[i] = c_x[rev_seq];
    }

    // 输出调整顺序后的输入序列
    // for(int i = 0; i < N; i++){
    //     cout<<X_DIT_FFT[i]<<endl;
    // }

    // DIT-DFT运算
    int fft_start_time = clock();
    // 每一级运算
    for (int i = 0; i < m; i++){
        // 每一组蝶形块运算
        for(int j = 0; j < N; j=j + (1<<(i+1))){
            int bf_num = 1<<i;
            // 每个最小蝶形计算
            for (int k = 0; k < bf_num; k++){
                complex<double> input1 = X_DIT_FFT[j + k];
                complex<double> input2 = X_DIT_FFT[j + k + bf_num] * pow(polar(1.0, -2 * PI / (1<<(i+1))), k);
                X_DIT_FFT[j + k] = input1 + input2;
                X_DIT_FFT[j + k + bf_num] = input1 - input2;
            }
        }
    }
    int fft_end_time = clock();
    cout<<"FFT Time:"<<fft_end_time-fft_start_time<<endl;
    // 打印DIF-FFT结果
    // cout<<"DIT_FFT:"<<endl;
    // for(int i = 0; i < N; i++){
    //     cout<<X_DIT_FFT[i]<<endl;
    // }

    // 向文件中写入FFT结果
    ofstream outfile2("fft_result.txt", ios_base::out);
    for (int i = 0; i < N; i++){
        outfile2<<real(X_DIT_FFT[i])<<" "<<imag(X_DIT_FFT[i])<<endl;
    }
    outfile2.close();
    return 0;
}