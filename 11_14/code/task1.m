close all; clear; clc
Mx = 8; % パルス波形の幅
M = 8;
Nb = 32; % パルスの個数(=ビット数)
sd = 5; rng(sd); % 乱数生成の初期値
Nr = randi([0, M-1], 1, Nb); % M段階のNb個のパルス列生成(整数乱数)
Nx = Mx * Nb; % パルス列信号の長さ(総サンプル数)
n = 0:1:Nx-1; % パルス列信号のサンプル軸ベクトル

PuluS = zeros(1, Nx); % パルス列信号の初期化
for k=1:Nb
    PuluS((k-1)*Mx+1:k*Mx) = Nr(k); % 所定の振幅値のパルス列信号の生成
end

figure(1)
plot(n, PuluS);
axis([1, Nx, -1, 8]);
xlabel('Number of Sample');
ylabel('Amplitude');
saveas(gcf,'task1.png')