close all; clear; clc
X = double(imread('Parrots.jpg'));
N = 128; % 画像サイズ
S = imresize(X, [N N]);
XY = rgb2ycbcr(S);
XY1 = XY(:,:,1);
YF = fft2(XY1); % グレースケール画像の2D-DFT
NYF = fftshift(YF); %原点中心変換
% フィルタの作成(原点中心LPFフィルタ)

G = 20; % 係数を1にする領域の広さ
Gminus = N/2-G;
Gplus = N/2+G;
H = zeros(N, N);
for i=1:N % 縦ループループ
    for j=1:N % 横方向ループ
        if i >= Gminus && i <= Gplus && j >= Gminus && j <= Gplus % 共通領域
            H(i,j) = 1; % 通過域=1
        end
    end
end
NZY = H.*NYF; % フィルタリング
ZY = ifftshift(NZY); % 四隅に原点を移動(IFFT2適用のため)
Z = ifft2(ZY); % 2D-IDFTで空間領域変換
ZR = real(Z); % 空間領域画像の実部

ZRF = fft2(ZR); % LPF後画像の2次元FFT
SZRF = fftshift(ZRF); % スペクトルの中心移動
PZR = SZRF.*conj(SZRF); % パワースペクトル算出(LPF画像)
PNYF = NYF.*conj(NYF); % パワースペクトル算出(元画像)

% HPF
G = 5; % 係数を0にする領域の広さ(G=0~N/2の値を設定)
Gminus = N/2-G;
Gplus = N/2+G;
H = ones(N, N);
for i=1:N % 縦ループループ
    for j=1:N % 横方向ループ
        if i >= Gminus && i <= Gplus && j >= Gminus && j <= Gplus % 共通領域
            H(i,j) = 0; % 通過域=0
        end
    end
end

% 2D-SS
absYF=abs(YF);
absNIF=abs(NIF);
SY=zeros(N,N);
for k=1:N
    for l=1:N
        SY(k,l)=(1-(absNIF(k,l)/absYF(k,l)))*YF(k,l);
    end
end