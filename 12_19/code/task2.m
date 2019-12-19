close all; clear; clc

X0 = imread('../../sample_image/Parrots.jpg');
X = imresize(X0, [128, 128]);
YX = rgb2ycbcr(X);
YO = YX(:,:,1);
[C, R] = size(YO);

K = 3;
delta = fix(K/2);

H = [-1,-1,-1; -1,8,-1; -1,-1,-1;];

YF = mask(YO, delta, C, R, H);

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
imshow(uint8(YO)); xlabel('Original image');
figure(2)
imshow(uint8(YF)); xlabel('Filtered image');
figure(3)
imshow(BY); xlabel('Binary image');


