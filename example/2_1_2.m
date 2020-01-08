close all; clear; clc

fs = 16000; % サンプリング周波数
Ts = 1/fs; % サンプリング間隔
N = 256; % サンプル数(偶数N)
tmax = Ts*(N-1); % 時間範囲の最大値

t=0:Ts:tmax; %座標0~tmaxまで、サンプリング間隔の時点(偶数信号)N=128
s=cos(2*pi*1200*t); % 1200[Hz]の余弦波
sd = 7; rng(sd); % 雑音生成の初期値
xn = 0.5*randn(size(t)); % 0.4 雑音レベルの調整
x = s + xn; % 観測信号

h = fir1(40, 0.25, 'low'); % 次数40(フィルタ長41)のLPFの設計(0.25π 窓関数法)
y = filter(h, 1, x); % FIRフィルタによるたたみ込み演算

n = 0:1:N-1; % 0~(N-1)のN展サンプルグリッド(=DFサイズ)
X = fft(x); % DFT(変換)
Xf = X.*conj(X)./N./N; % 振幅正規化パワースペクトル
df = 2*pi/(N-1); % 0~2paiをNf分割
nf = 0:df:2*pi; % 正規化角周波数軸(サンプリング周波数=2π)

Y = fft(y);
Yf = Y.*conj(Y)./N./N; % 処理後の振幅正規化パワースペクトル

figure(1);
subplot(211)
stem(n, x, 'fil', 'MarkerSize', 2);
axis([0, N-1, -2, 2]); % 時間領域ディジタル表示(観測信号)
hold on
plot(n, x, 'r-.');
xlabel('Number of Sample');
ylabel('Amplitude of x(n)');

subplot(212)
stem(n, x, 'fil', 'MarkerSize', 2);
axis([0, N-1, -2, 2]); % 時間領域ディジタル表示(処理信号)
hold on
plot(n, y, 'r-.');
xlabel('Number of Sample');
ylabel('Amplitude of y(n)');

figure(2);
subplot(211)
stem(nf, Xf, 'MarkerSize', 4);
axis([0, 2*pi, 0, 0.25]); % 2πまで表示
xlabel('Normalized Frequency 2*pi [rad/s]');
ylabel('Power Spectrum of X(Ω)');

subplot(212)
stem(nf, Yf, 'MarkerSize', 4);
axis([0, 2*pi, 0, 0.25]); % 2πまで表示
xlabel('Normalized Frequency 2*pi [rad/s]');
ylabel('Power Spectrum of Y(Ω)');

figure(3)
freqz(h, 1); % FIRフィルタの周波数特性