close all; clear; clc;

X = imread('Parrots.jpg', 'jpg'); % �J���[�摜�̓ǂݍ���150�~150��f
S = imresize(X, [128, 128]); % 128�~128��f�։摜�T�C�Y�̕ϊ�
Z = rgb2gray(S); % �O���[�X�P�[���摜�ϊ�

figure(1)
imshow(S);
xlabel('Color image'); % ���摜�̃J���[�\��

figure(2)
subplot(2,1,1); imshow(Z); colorbar; xlabel('Gray scale image') % ���摜�̃O���[�X�P�[���\��
subplot(2,1,2); histogram(Z, 32); xlabel('Gray scale histogram') % �O���[�摜�q�X�g�O����(32�r��)

figure(3)
subplot(2,1,1); imshow(Z); colorbar; xlabel('Gray scale image') % ���摜�̃O���[�X�P�[���\��
subplot(2,1,2); imhist(Z, 32); xlabel('Gray scale image histogram') % �O���[�摜�q�X�g�O����
