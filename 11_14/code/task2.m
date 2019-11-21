close all; clear; clc

tmax = 2.0; % 時間長区間
ts = 0.001; % 時間刻み幅(サンプリング間隔)
fs = 1/ts; % サンプリング周波数
t = 0:ts:tmax-ts; % 時間軸ベクトル

% 送信側 %
fr = 50; % 搬送は周波数[Hz]
cw = sin(2*pi*fr*t); %搬送波
A0 = 0.3; % 変調の振幅A0(ビット0)
A1 = 1.0; % 変調の振幅(ビット1)

fp = 10; % 送信パルスの周波数[Hz]
BT = 1/fp; % 送信パルスの周期(1パルスの時間軸[s])
SL = BT/ts; % 1パルスのサンプル数
Nb = tmax/BT; % 送信ビット数
sd = 5; rng(sd); % 乱数生成の初期値
SXbit = randi([0, 1], 1, Nb); % 送信ビット列生成

Damp = zeros(1, Nb); % ASKの振幅値の配列の初期化
for c=1:Nb
    if SXbit(1, c) == 0
        Damp(1, c) = A0; % ビット0の時のASKの振幅値
    else
        Damp(1, c) = A1; % ビット1の時のASKの振幅値
    end
end
spls = repelem(SXbit, SL);
mpls = repelem(Damp, SL); % 振幅変調値の送信パルス列信号生成

% ASK変調 %
ASK = cw.*mpls; % ASK変調波
F_ASK = fft(ASK);
N = length(ASK); % 変調波の信号長(サンプル数)
nf = 0:fs/(N-1):fs; % 周波数軸ベクトル生成

frn = 60;
[nis, Fs] = audioread('../../audio/white_Noise.wav');
wn = nis';
wnoise = wn(1:length(cw));
nnoise = cos(2*pi*frn*t);
ASKn = ASK + 1.5*wnoise + 0.2*nnoise;

% 受信側 %
AbASK = abs(ASKn); % ASK変調波の絶対値

% 周波数領域LPF %
FT_AbASK = fft(AbASK); % FFT
H = zeros(1, N); % LPF初期化
H(1:round(N/16)) = 1; % 通過帯域がfs/16のLFP
H(N+2-round(N/16):N) = 1; % 通過帯域がfs/16のLFP
Env_AbASK = FT_AbASK.*H; % 平滑化(LPF)処理特性
rpls = ifft(Env_AbASK); % IFFT(パルス列包絡線検波)

% 包絡線の判定処理%
th = abs((A0-A1)/2); % ビット判定のしきい値(整流)
RXbit = zeros(1, Nb); % 還元パルスの中央値のしきい値判定
for d=1:Nb
    RXbit(1, d) = rpls(1, (d-1)*SL+SL/2) >= th; % 中央値「真」なら1
end
dpls = repelem(RXbit, SL); % 受信判定還元パルス信号

BER = (sum(xor(SXbit, RXbit))/Nb); %BER算出
disp([num2str(Nb), 'bit送信'])
disp(['送信bit列', num2str(SXbit)]) % 送信ビット列表示
disp(['受信bit列', num2str(RXbit)]) % 受信ビット列表示
disp(['BER=', num2str(BER), '% [誤りbit数/送信bit数]'])


figure(1)
subplot(311)
plot(t, cw); % 搬送波
axis([0, tmax, -1.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(312)
plot(t, spls);
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(313)
plot(t, ASK); % ASK変調波
axis([0, tmax, -1.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
% saveas(gcf,'../result_image/figure1.png')

figure(2)
subplot(311)
plot(t, rpls);
axis([0, tmax, -0.0 1.0]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(312)
plot(t, dpls);
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(313)
plot(t, spls);
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');

% saveas(gcf,'../result_image/figure2.png')