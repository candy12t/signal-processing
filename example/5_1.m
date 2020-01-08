close all; clear; clc;

X = imread('BOAT.jpg', 'jpg'); % モノクロ画像(グレースケール画像)の読み込み
Y = imread('Parrots', 'jpg'); % カラー画像の読み込み

figure(1)
imshow(X) % 読み込みのモノクロ画像の表示

figure(2)
colormap(gray(256));
image(X);
axis image; axis off;

figure(3)
colormap(gray(256));
imagesc(X);
axis image; axis off;

figure(4)
imshow(Y); % 読み込みカラー画像の表示

figure(5)
image(Y);
axis image; axis off;

figure(6)
imagesc(Y);
axis image; axis off;