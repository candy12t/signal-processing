close all; clear; clc

fs=16000;
recObj=audiorecorder(fs,16,1); %16bitでモノラル

disp('Start Speaking'); %録音開始
recordblocking(recObj,2); %recObjに２秒間の録音
disp('End of Recording'); %録音終了

record=getaudiodata(recObj,'single');%recObjのデータを単精度配列として変数recordに格納

audiowrite('output.wav',record,fs);%recObjの数値データをwavファイルとして保存
[recspeech,fs]=audioread('output.wav');% waveファイルとサンプリング周波数を変数へ読み込み格納
sound(recspeech,fs);%再生

[onsei, fs]=audioread('output.wav'); %音声ファイルを選択、読み込み
s=onsei; %横ベクトルに変換

M=length(s); %もとの音声波形の信号長
N=4096; %信号の切り出し窓の長さ(FFTのサイズ)
a=3600; %音声波形sの主要部a~a+(N-1)までの切り出す開始位置

S=fft(s); %FFT
Xf=S.*conj(S)./N./N; %振幅正規化パワースペクトルの計算
fn=linspace(0,fs,M); %周波数軸ベクトルの生成


figure(1); %音声波形の表示
plot(s);
xlabel('Sample');ylabel('Amplitude')

figure(2) %パワースペクトルの表示
plot(fn,Xf);
xlabel('Frequency [Hz]');ylabel('Power Spectrum')