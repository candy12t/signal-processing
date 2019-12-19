close all; clear; clc
X = imread('../../sample_image/Parrots.jpg', 'jpg');
S = imresize(X, [128, 128]);
Z = rgb2gray(X);
N=128;
Y = imresize(Z, [N, N]);
 
figure(1)
imshow(Y);
colorbar;
xlabel('Gray scale image')
