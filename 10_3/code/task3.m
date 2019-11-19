close all; clear; clc;
Fs=16000; %サンプリング周波数の設定
recObj=audiorecorder(Fs,16,1); %16bitでモノラル

disp('Start Speaking');%録音開始
recordblocking(recObj,2);%recObjに２秒間の録音
disp('End of Recording');%録音終了

s=getaudiodata(recObj,'single');%recObjのデータを単精度配列として変数sに格納

[f,Fs]=audioread('../../white_Noise.wav');%雑音の読み込み
M=length(s);
m=s+f(1:M);

figure(1);
subplot(211)
plot(s);xlabel('Sample');ylabel('Amplitude');%音声信号出力
subplot(212)
plot(m);xlabel('Sample');ylabel('Amplitude');%観測信号出力

S=snr(s,m);