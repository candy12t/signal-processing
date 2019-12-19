close all; clear ; clc
 
N = 128;
X = imread('../../sample_image/Parrots.jpg', 'jpg'); %カラー画像の読み込み150 × 150画素
S = imresize(X, [N, N]); % 128 × 128画素へ画像サイズの変換
Z = rgb2gray(S); % グレースケール画像変換
Y = imresize(Z, [N, N]); % 画像の切り取り128 × 128
 
imwrite(Y, '../result_image/compParrots1.jpg', 'jpg', 'Quality', 50); % JPEG圧縮(品質=50)書き込み
imwrite(Y, '../result_image/compParrots2.jpg', 'jpg', 'Quality', 20); % JPEG圧縮(品質=20)書き込み
imwrite(Y, '../result_image/compParrots3.jpg', 'jpg', 'Quality', 4); % JPEG圧縮(品質=4)書き込み
Y1 = imread('../result_image/compParrots1.jpg', 'jpg'); % 品質=50画像読み込み
Y2 = imread('../result_image/compParrots2.jpg', 'jpg'); % 品質=40画像読み込み
Y3 = imread('../result_image/compParrots3.jpg', 'jpg'); % 品質=2画像読み込み
 
peaksnr1 = psnr(Y1, Y); % グレースケール画像と品質=50のグレースケール画像とのPSNR
peaksnr2 = psnr(Y2, Y); % グレースケール画像と品質=40のグレースケール画像とのPSNR
peaksnr3 = psnr(Y3, Y); % グレースケール画像と品質=2のグレースケール画像とのPSNR
 
disp(['Quality Factor:50 PSNR = ', num2str(peaksnr1)])
disp(['Quality Factor:40 PSNR = ', num2str(peaksnr2)])
disp(['Quality Factor:4 PSNR = ', num2str(peaksnr3)])
 
 
figure(1)
subplot(2,2,1);
imshow(Y); xlabel('Gray scale image');
subplot(2,2,2);
imshow(Y1); xlabel('JPEG image (Q=50)');
subplot(2,2,3);
imshow(Y2); xlabel('JPEG image (Q=40)');
subplot(2,2,4);
imshow(Y3); xlabel('JPEG image (Q=2)');
