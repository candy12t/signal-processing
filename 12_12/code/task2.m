close all; clear; clc
 
mycam = webcam; % web�J�����̋N���E�I�u�W�F�N�g���쐬
preview(mycam); % web�J���������B��A�E�C���h�E�����܂ŕ\��
frames = 100; % �擾����t���[�������w��
% 100�t���[���ڂɎ擾�����摜��\��(1�b30�t���[������3.3�b��ɐÎ~�摜)
for i = 1:frames
    img = snapshot(mycam); % �摜�t���[�����擾�����
    imagesc(img); % �擾�����t���[����\��
    axis off; % �摜�̂��ߎ����\��
end
 
imwrite(img, '../result_image/get_image.jpg', 'jpg') % �摜��JPEG�`���ŕۑ�
delete(mycam) % �쐬����web�J�����I�u�W�F�N�g���폜
 
N=128; %�摜�̐؂���T�C�Y N �~ N, N=128
X = imread('../result_image/get_image.jpg', 'jpg'); %�J���[�摜�̓ǂݍ���150 �~ 150��f
S = imresize(X, [N, N]); % 128 �~ 128��f�։摜�T�C�Y�̕ϊ�
Z = rgb2gray(S); % �O���[�X�P�[���摜�ϊ�
Y = imresize(Z, [N, N]); % �摜�̐؂���128 �~ 128
th = 140; % �摜�̔Z�W�����Ɣ���2�l�����邽�߂̏�����
BY = zeros(N, N); % 2�l���摜���i�[����z��̏�����
for i=1:N
    for j=1:N
        if Y(i, j) >= th
            BY(i, j) = 1; % 2�l��(��)
        else
            BY(i, j) = 0; % 2�l��(��)
        end
    end
end
 
figure(1)
subplot(2,1,1);
imshow(X); colorbar; xlabel('Color image') % �J���[�摜
subplot(2,1,2);
histogram(X, 256); xlabel('Color histograme') % �J���[�摜�̃q�X�g�O����
 
figure(2)
subplot(2,1,1);
imshow(Y); colorbar; xlabel('Gray scale image') % �O���[�X�P�[���摜
subplot(2,1,2);
histogram(Y, 256); xlabel('Gray scale histograme') % �O���[�X�P�[���̃q�X�g�O����
 
figure(3)
subplot(2,1,1);
imshow(BY); colorbar; xlabel('Binary image') % 2�l����̉摜
subplot(2,1,2);
histogram(BY, 2); xlabel('Binary histograme') % 2�l����̃q�X�g�O����
