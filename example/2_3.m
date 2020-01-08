close all; clear;clc
fs=16000;%サンプリング周波数
Ts=1/fs;%サンプリング間隔
N=128;%窓枠(偶数N)
win=rectwin(N);%窓関数の種類
S=N/2;%窓の重なり量(移動前後での窓の重なり量)
M=10;%全体の時間長を決める変数（窓長のM倍の目安）
tmax=Ts*(N-1)*M;%全体の時間長

t=0:Ts:tmax;%座標0~tmaxまで、サンプリング間隔の時点(偶数信号数)N=128
s=cos(2*pi*1200*t);%1200[Hz]の余弦波
sd=7;rng(sd);%雑音生成の初期値
xn=0.5*randn(size(t));%0.4 雑音レベルの調整
x=s+xn;%観測信号
n=0:1:M*(N-1);%観測信号のサンプル軸(N-1)*M点

Xtf=stft(x,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
rx=istft(Xtf,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
[fnum, tnum]=size(Xtf);
Ntf=stft(xn,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
absXtf=abs(Xtf);
absNtf=abs(Ntf);
Y=(ones(fnum,tnum)-absNtf./absXtf).*Xtf;

y=istft(Y,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
ny=0:1:length(y)-1;

Yft=stft(y,fs,'Window',win,'OverlapLength',S,'FFTLength',N);

figure(1)
subplot(211)
stem(n,x,'fil','MarkerSize',2);axis([0,3*N-1,-2,2]);
hold on; plot(n,x,'r-.');xlabel('Number of Sample');ylabel('Amplitude of x(n)');
subplot(212)
stem(ny,y,'fil','MarkerSize',2);axis([0,3*N-1,-2,2]);
hold on; plot(ny,y,'r-.');xlabel('Number of Sample');ylabel('Amplitude of x(n)');

figure(2)
subplot(211)
stft(x,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
subplot(212)
stft(y,fs,'Window',win,'OverlapLength',S,'FFTLength',N);

figure(3)
subplot(211)
stft(x,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
title('Observed single'); view(-45,65); colormap parula
subplot(212)
stft(y,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
title('Observed single'); view(-45,65); colormap parula