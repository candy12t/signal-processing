close all; clear; clc
tmax = 2.0; %時間長区間
ts = 0.001; %時間刻み幅(サンプリング間隔)
fs = 1/ts; %サンプリング周波数
t = 0:ts:tmax-ts; %時間軸ベクトル

% 搬送波生成
fr = 50; %搬送波周波数
cw = sin(2*pi*fr*t); %搬送波生成

% 送信パルス列の生成
fp = 10; %送信パル列の周波数[Hz]
BT = 1/fp; %送信パルスの周期
SL = BT/ts; %1パルスのサンプル数
Nb = tmax/BT; %送信ビット数
sd = 5; rng(sd); %乱数生成の初期値
Sb = randi([0, 1], 1, Nb); %送信ビット列生成
spls = repelem(Sb, SL); % ビットパルス列信号

% 一次変調波の生成
A0 = -1.0; %ビット0→振幅-1.0(ビット0)
A1 = 1.0; %ビット1→振幅1.0(ビット1)
Damp = zeros(1, Nb); %一次変調(パルス振幅変調)配列の初期化
for c = 1:Nb
    if Sb(1, c) == 0
        Damp(1, c) = A0; %ビット0のときPSKの0[rad]
    else
        Damp(1, c) = A1;%ビット1のときPSKの0[rad]
    end
end
mpls = repelem(Damp, SL); %振幅変調値の送信パルス列信号

% PSK変調
PSK = cw.*mpls;

% SS変調
alpha = 20; %拡散比 ビット列パルス周波数のalpha倍
Nbs = Nb * alpha; %拡散信号のビット数(alpha倍)
SLs = SL/alpha; %拡散信号1パルスのサンプル数

rng(8); %乱数の初期値シード
MX = 2*randi([0, 1], 1, Nbs)-1; %拡散変調用-1, +1の乱数生成
sspls = repelem(MX, SLs); %拡散変調用乱数パルス列

% SS変調
SS = sspls.*PSK; %変調波(拡散信号と送信パルス列の乗算)

% 受信側(相関検出)
spls0 = A0*cw; % ビット0のときの変調波(基準)
spls1 = A1*cw; % ビット1のときの変調波(基準)
COR0 = PSK.*spls0; % 受信変調波とビット0変調波の乗算(相関)
COR1 = PSK.*spls1; % 受信変調波とビット1変調波の乗算(相関)
SPSK0 = reshape(COR0, [SL, Nb]); % ビット単位に相関の整列
SPSK1 = reshape(COR1, [SL, Nb]); % ビット単位に相関の整列

DC0 = zeros(1, Nb); % ビット0との相関値の配列の初期化
DC1 = zeros(1, Nb); % ビット1との相関値の配列の初期化
Rb = zeros(1, Nb); % 相関の強弱の判定の配列初期化
for e=1:Nb
    DC0(1, e) = sum(SPSK0(:,e))/SL; % ビット0との正規化相関値
    DC1(1, e) = sum(SPSK1(:,e))/SL; % ビット1との正規化相関値
    Rb(1, e) = DC1(1, e) >= DC0(1, e); % 相関値の判定
end
dpls = repelem(Rb, SL); % 受信判定復元パルス列信号

BER = (sum(xor(Sb, Rb))/Nb); %BER算出
disp([num2str(Nb), 'bit送信']) % 送信ビット数表示
disp(['送信bit列', num2str(Sb)]) % 送信ビット列表示
disp(['受信bit列', num2str(Rb)]) % 受信ビット列表示
disp(['BER=', num2str(BER), '% [誤りbit数/送信bit数]'])

figure(1)
subplot(311)
plot(t, spls); %送信ビットパルス列信号
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(312)
plot(t, PSK); %1次変長パルス列信号
axis([0, tmax, -1.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(313)
plot(t, SS); %2次変調波高速パルス信号
axis([0, tmax, -1.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
saveas(gcf,'../result_image/figure1.png')

figure(2)
subplot(211)
plot(t, dpls) % 受信ビットパルス列信号
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(212)
plot(t, spls) % 送信ビット列信号
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
saveas(gcf,'../result_image/figure2.png')