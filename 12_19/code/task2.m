close all; clear; clc

X0 = imread('../../sample_image/Parrots.jpg'); % 画像読み込み
X = imresize(X0, [128, 128]); % 画像サイズの設定
YX = rgb2ycbcr(X); % RGB色空間からYCbCr色空間に変換
YO = YX(:,:,1); % グレースケール画像(Y成分画像)
[C, R] = size(YO); % 画像の縦横サイズ取得(Cは縦、Rは横)

K = 3; % マスクサイズ(フィルタサイズ)
delta = fix(K/2); % マスク中心位置調整用の変数(その要素以下の最も近い整数)

H = [-1,-1,-1; -1,8,-1; -1,-1,-1;]; % エッジ抽出フィルタ係数(3×3行列)

YF = mask(YO, delta, C, R, H); % 局所マスク関数

N = 128;
th = 120; % 画像の濃淡を黒と白の2値化するための初期化
BY = zeros(N, N); % 2値化画像を格納する配列の初期化
for i=1:N
    for j=1:N
        if YF(i, j) >= th
            BY(i, j) = 1; % 2値化(白)
        else
            BY(i, j) = 0; % 2値化(黒)
        end
    end
end

figure(1)
imshow(uint8(YO)); xlabel('Original image'); % 元画像表示
figure(2)
imshow(uint8(YF)); xlabel('Filtered image'); % フィルタ処理画像表示
figure(3)
imshow(BY); xlabel('Binary image');


