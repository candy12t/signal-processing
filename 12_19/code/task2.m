close all; clear; clc

X0 = imread('../../sample_image/Parrots.jpg'); % �摜�ǂݍ���
X = imresize(X0, [128, 128]); % �摜�T�C�Y�̐ݒ�
YX = rgb2ycbcr(X); % RGB�F��Ԃ���YCbCr�F��Ԃɕϊ�
YO = YX(:,:,1); % �O���[�X�P�[���摜(Y�����摜)
[C, R] = size(YO); % �摜�̏c���T�C�Y�擾(C�͏c�AR�͉�)

K = 3; % �}�X�N�T�C�Y(�t�B���^�T�C�Y)
delta = fix(K/2); % �}�X�N���S�ʒu�����p�̕ϐ�(���̗v�f�ȉ��̍ł��߂�����)

H = [-1,-1,-1; -1,8,-1; -1,-1,-1;]; % �G�b�W���o�t�B���^�W��(3�~3�s��)

YF = mask(YO, delta, C, R, H); % �Ǐ��}�X�N�֐�

N = 128;
th = 120; % �摜�̔Z�W�����Ɣ���2�l�����邽�߂̏�����
BY = zeros(N, N); % 2�l���摜���i�[����z��̏�����
for i=1:N
    for j=1:N
        if YF(i, j) >= th
            BY(i, j) = 1; % 2�l��(��)
        else
            BY(i, j) = 0; % 2�l��(��)
        end
    end
end

figure(1)
imshow(uint8(YO)); xlabel('Original image'); % ���摜�\��
figure(2)
imshow(uint8(YF)); xlabel('Filtered image'); % �t�B���^�����摜�\��
figure(3)
imshow(BY); xlabel('Binary image');


