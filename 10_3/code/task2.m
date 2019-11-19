close all; clear; clc

fs=16000; %サンプリング周波数
recObj=audiorecorder(fs,16,1); %16bitでモノラル

disp('Start Speaking');%録音開始
recordblocking(recObj,2);%recObjに２秒間の録音
disp('End of Recording');%録音終了

record=getaudiodata(recObj,'single');%recObjのデータを単精度配列として変数recordに格納

audiowrite('output.wav',record,fs);%recObjの数値データをwavファイルとして保存
[recspeech,fs]=audioread('output.wav');% waveファイルとサンプリング周波数を変数へ読み込み格納
sound(recspeech,fs);%再生

[onsei,fs]=audioread('output.wav');%音声ファイルを選択、読み込み
s=onsei';%横ベクトルに変換

M=length(s); %もとの音声波形の信号長
n=4096; %信号の切り出し窓の長さ(FFTのサイズ)
a=3600; %音声波形sの主要部a~a+(N-1)までの切り出す開始位置

win=rectwin(n); %窓関数の選定
w=zeros(1,M); %窓関数の初期化
w(a:a+n-1)=win; %窓関数の開始位置と範囲の指定

x=s.*w; %窓関数による切り出し

S=fft(s); %窓関数無しのFFT
Xs=S.*conj(S)./M./M; %振幅正規化パワースペクトルの計算
X=fft(x); %窓関数をかけた信号のFFT
Xp=X.*conj(X)./M./M; %振幅正規化パワースペクトル(窓かけ信号)の計算
fn=linspace(0,fs,M); %周波数軸ベクトルの生成


figure(1);
plot(record);%音声波形の表示
xlabel('Sample Number');ylabel('Amplitude')

figure(2);
subplot(211)
plot(s);xlabel('Sample');ylabel('Amplitude');%窓関数なし音声波形表示（軸は配列番号）   
subplot(212)
plot(x);xlabel('Sample');ylabel('Amplitude');%窓関数を掛けた音声波形表示（軸は配列番号）

figure(3)
subplot(211)
plot(fn,Xs);axis([0 fs/2 0 1.0*10^(-4)]);
xlabel('Frequency [Hz]');ylabel('Power Spectrum'); %パワースペクトルの表示
subplot(212)
plot(fn,Xp);axis([0 fs/2 0 1.0*10^(-6)]);
xlabel('Frequency [Hz]');ylabel('Power Spectrum'); %パワースペクトルの表示

sound(s,fs) %音声サウンド可聴サンプリング周波数fsでsの音声をスピーカから再生