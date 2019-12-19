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

figure(1)
imshow(uint8(YO)); xlabel('Original image');
figure(2)
imshow(uint8(YF)); xlabel('Filtered image');
