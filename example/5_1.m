close all; clear; clc;

X = imread('BOAT.jpg', 'jpg'); % ���m�N���摜(�O���[�X�P�[���摜)�̓ǂݍ���
Y = imread('Parrots', 'jpg'); % �J���[�摜�̓ǂݍ���

figure(1)
imshow(X) % �ǂݍ��݂̃��m�N���摜�̕\��

figure(2)
colormap(gray(256));
image(X);
axis image; axis off;

figure(3)
colormap(gray(256));
imagesc(X);
axis image; axis off;

figure(4)
imshow(Y); % �ǂݍ��݃J���[�摜�̕\��

figure(5)
image(Y);
axis image; axis off;

figure(6)
imagesc(Y);
axis image; axis off;