close all; clear ; clc
 
N = 128;
X = imread('../../sample_image/Parrots.jpg', 'jpg'); %�J���[�摜�̓ǂݍ���150 �~ 150��f
S = imresize(X, [N, N]); % 128 �~ 128��f�։摜�T�C�Y�̕ϊ�
Z = rgb2gray(S); % �O���[�X�P�[���摜�ϊ�
Y = imresize(Z, [N, N]); % �摜�̐؂���128 �~ 128
 
imwrite(Y, '../result_image/compParrots1.jpg', 'jpg', 'Quality', 50); % JPEG���k(�i��=50)��������
imwrite(Y, '../result_image/compParrots2.jpg', 'jpg', 'Quality', 20); % JPEG���k(�i��=20)��������
imwrite(Y, '../result_image/compParrots3.jpg', 'jpg', 'Quality', 4); % JPEG���k(�i��=4)��������
Y1 = imread('../result_image/compParrots1.jpg', 'jpg'); % �i��=50�摜�ǂݍ���
Y2 = imread('../result_image/compParrots2.jpg', 'jpg'); % �i��=40�摜�ǂݍ���
Y3 = imread('../result_image/compParrots3.jpg', 'jpg'); % �i��=2�摜�ǂݍ���
 
peaksnr1 = psnr(Y1, Y); % �O���[�X�P�[���摜�ƕi��=50�̃O���[�X�P�[���摜�Ƃ�PSNR
peaksnr2 = psnr(Y2, Y); % �O���[�X�P�[���摜�ƕi��=40�̃O���[�X�P�[���摜�Ƃ�PSNR
peaksnr3 = psnr(Y3, Y); % �O���[�X�P�[���摜�ƕi��=2�̃O���[�X�P�[���摜�Ƃ�PSNR
 
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
