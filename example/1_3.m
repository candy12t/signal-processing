close all; clear; clc
[onsei,fs]=audioread('A_a.wav');%音声ファイルを選択し、読み込み
s=onsei';%横ベクトルに変換

M=length(s);%元の音声波形の信号長
N=4096;%信号の切り出し窓の長さ（信号長=FFTのサイズ）
a=4500;%音声波形sの主要部+a~a+(N-1)までを切り出す開始位置

win=hamming(N)';%win=rectwin(N)';%窓関数の指定
w=zeros(1,M);%窓関数の初期化
w(a:a+N-1)=win;%窓関数の開始位置と範囲の指定

x=s.*w;%窓関数による切り出し

figure(1);
subplot(211)
plot(s);xlabel('Sample');ylabel('Amplitude');%窓関数なし音声波形表示（軸は配列番号）
subplot(212)
plot(x);xlabel('Sample');ylabel('Amplitude');%窓関数を掛けた音声波形表示（軸は配列番号）

S=fft(s);%窓関数なし信号のFFT
Xs=S.*conj(S)./M./M;%振幅正規化パワースペクトルの計算(0~20kHz)
X=fft(x);%窓関数を掛けた信号のFFT
Xp=X.*conj(X)./M./M;%振幅正規化パワースペクトル（窓掛け信号）の計算(0~20kHz)
fn=linspace(0,fs,M);%周波数軸ベクトルの生成(0~fs/2)

figure(2)
subplot(211)
plot(fn,Xs);axis([0 fs/20 0 1.0*10^(-4)]);
xlabel('Frequency [Hz]');ylabel('Power Spectrum');%パワースペクトルの表示
subplot(212)
plot(fn,Xp);axis([0 fs/10 0 1.0*10^(-4)]);
xlabel('Frequency [Hz]');ylabel('Power Spectrum');%パワースペクトルの表示

sound(s,fs)%音声サウンド可聴サンプリング周波数fsでsの音声をスピーカから再生