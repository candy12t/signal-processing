close all; clear; clc %初期化

[audio, fs]=audioread('../audio/speech/A_a.wav'); %音声ファイルを選択し、読み込み
s=audio'; %横ベクトルに変換
[noise, fs]=audioread('../audio/white_Noise.wav'); %音声ファイルを選択し、読み込み
n=noise'; %横ベクトルに変換

M=length(s); %元の音声波形の信号長をMに代入(1*13824)
n=n(1:M); %雑音の行列の次元を音声に合わせる
x=s+n; %観測信号=音声+雑音

S=fft(s); %音声のDFT
Xs=S.*conj(S)./M./M; %振幅正規化パワースペクトル
fn=linspace(0,fs,M); %周波数軸ベクトルの生成

X=fft(x); %観測信号のDFT
Xn=fft(n); %雑音のDFT
absX=abs(X); %観測信号の振幅スペクトル
absN=abs(Xn); %雑音の振幅スペクトル
Y=(ones(1,M)-absN./absX).*X; %スペクトル・サブトラクション

y=ifft(Y); %雑音除去後の信号のIDFT

before_snr=snr(s,x); %雑音除去前のSNR
after_snr=snr(s,y); %雑音除去後のSNR

% コマンドに表示
disp(['雑音除去前のSNRは', num2str(before_snr), '[dB]です。']);
disp(['雑音除去後のSNRは', num2str(after_snr), '[dB]です。']);


%音声の波形の表示
figure(1);
plot(s); axis([0 14000 -1.0 1.0]);
xlabel('Smaple'); ylabel('Amplitude');

%正規化振幅パワースペクトルの表示
figure(2);
plot(fn,Xs); axis([0 fs/2 0 1.0*10^(-4)]);
xlabel('Frequency [Hz]'); ylabel('Power Spectrum');

%音声信号及び雑音信号、雑音除去後の音声信号の表示
figure(3);
subplot(311)
plot(s); axis([0 14000 -1.0 1.0]);
xlabel('音声信号s'); ylabel('s(n)');
subplot(312)
plot(x); axis([0 14000 -1.0 1.0]);
xlabel('観測信号x'); ylabel('x(n)');
subplot(313)
plot(y); axis([0 14000 -1.0 1.0]);
xlabel('雑音除去後の音声信号y'); ylabel('y(n)');