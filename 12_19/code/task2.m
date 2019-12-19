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
imshow(uint8(YO)); xlabel('Original image');
figure(2)
imshow(uint8(YF)); xlabel('Filtered image');
figure(3)
imshow(BY); xlabel('Binary image');


