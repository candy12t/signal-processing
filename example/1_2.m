close all; clear; clc
N = 2^14; % 信号数(N=16384)
tmax = 2.0; % 時間間隔0~2 [s]
ts = tmax/(N-1); % サンプリング間隔(間隔数:N-1)

t = linspace(0, tmax, N); % 時間軸ベクトルの生成
y1 = 0.5*cos(2*pi*1000*t);
y2 = sin(2*pi*2000*t + pi/4);
y3 = 0.8*cos(2*pi*400*t - pi*3/4);
y = y1+y2+y3; % 狭帯域アナログ信号

save signal.mat y; % 変数yの値をsignalという名前のmatファイルに保存
s = load('signal'); % matファイルからsignalのデータを読み込み構造体sに代入(変数名y)
z = s.y; % 構造体sの変数yをzに代入(yと同じ値)

figure(1);
plot(t, y);
xlabel('Time [sec]');
ylabel('Amplitude');
axis([0 0.01*tmax -3 3]); %波形の表示範囲

Y = fft(y); % FFT高速フーリエ変換
Yp = Y.*conj(Y)./N./N; % 正規化パワースペクトル

fs = 1/ts; % サンプリング周波数
nf = (0:1/(N-1):1) * fs; % 周波数軸ベクトルの生成

figure(2);
plot(nf, Yp);
xlabel('Frequency');
ylabel('Amplitude'); % スペクトルの表示範囲
axis([0 fs/2 0 0.3 ]);