close all; clear; clc;

X = imread('Parrots.jpg', 'jpg'); % カラー画像の読み込み150×150画素
S = imresize(X, [128, 128]); % 128×128画素へ画像サイズの変換
Z = rgb2gray(S); % グレースケール画像変換

figure(1)
imshow(S);
xlabel('Color image'); % 元画像のカラー表示

figure(2)
subplot(2,1,1); imshow(Z); colorbar; xlabel('Gray scale image') % 元画像のグレースケール表示
subplot(2,1,2); histogram(Z, 32); xlabel('Gray scale histogram') % グレー画像ヒストグラム(32ビン)

figure(3)
subplot(2,1,1); imshow(Z); colorbar; xlabel('Gray scale image') % 元画像のグレースケール表示
subplot(2,1,2); imhist(Z, 32); xlabel('Gray scale image histogram') % グレー画像ヒストグラム
