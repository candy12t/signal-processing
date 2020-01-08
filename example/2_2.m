close all; clear; clc;%変数の初期化
fs=16000;%サンプリング周波数の設定
Ts=1/fs;%サンプリング周間隔
N=256;%サンプル数（偶数N）
tmax=Ts*(N-1);%時間範囲の最大値

t=0:Ts:tmax;%座標0~tmaxまで、サンプリング間隔の時点(偶数信号数)N=128
s=cos(2*pi*1200*t);%1200[Hz]の余弦波
sd=7;rng(sd);%雑音生成の初期値
xn=0.5*randn(size(t));%0.4 雑音レベルの調整
x=s+xn;%観測信号

n=0:1:N-1;%0~(N-1)のN点サンプルグリッド(=DFTサイズ)
X=fft(x);%k観測信号のDFT
Xf=X.*conj(X)./N./N;%振幅正規化パワースペクトル
df=2*pi/(N-1);%0~2piをNf分割
nf=0:df:2*pi;%正規化角周波数軸（サンプリング周波数=2π）

XN=fft(xn);%雑音のDFT
absX=abs(X);%観測信号の振幅スペクトル
absN=abs(XN);%雑音の振幅スぺクトル
Y=(ones(1,N)-absN./absX).*X;%スペクトル・サブストラクション

y=ifft(Y);%雑音除去後の信号のIDFT
