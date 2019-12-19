close all; clear; clc
 
mycam = webcam; % webカメラの起動・オブジェクトを作成
preview(mycam); % webカメラ試し撮り、ウインドウ消去まで表示
frames = 100; % 取得するフレーム数を指定
% 100フレーム目に取得した画像を表示(1秒30フレーム→約3.3秒後に静止画像)
for i = 1:frames
    img = snapshot(mycam); % 画像フレームを取得し代入
    imagesc(img); % 取得したフレームを表示
    axis off; % 画像のため軸を非表示
end
 
imwrite(img, '../result_image/get_image.jpg', 'jpg') % 画像をJPEG形式で保存
delete(mycam) % 作成したwebカメラオブジェクトを削除
 
N=128; %画像の切り取りサイズ N × N, N=128
X = imread('../result_image/get_image.jpg', 'jpg'); %カラー画像の読み込み150 × 150画素
S = imresize(X, [N, N]); % 128 × 128画素へ画像サイズの変換
Z = rgb2gray(S); % グレースケール画像変換
Y = imresize(Z, [N, N]); % 画像の切り取り128 × 128
th = 140; % 画像の濃淡を黒と白の2値化するための初期化
BY = zeros(N, N); % 2値化画像を格納する配列の初期化
for i=1:N
    for j=1:N
        if Y(i, j) >= th
            BY(i, j) = 1; % 2値化(白)
        else
            BY(i, j) = 0; % 2値化(黒)
        end
    end
end
 
figure(1)
subplot(2,1,1);
imshow(X); colorbar; xlabel('Color image') % カラー画像
subplot(2,1,2);
histogram(X, 256); xlabel('Color histograme') % カラー画像のヒストグラム
 
figure(2)
subplot(2,1,1);
imshow(Y); colorbar; xlabel('Gray scale image') % グレースケール画像
subplot(2,1,2);
histogram(Y, 256); xlabel('Gray scale histograme') % グレースケールのヒストグラム
 
figure(3)
subplot(2,1,1);
imshow(BY); colorbar; xlabel('Binary image') % 2値化後の画像
subplot(2,1,2);
histogram(BY, 2); xlabel('Binary histograme') % 2値化後のヒストグラム
