close all;clear;clc
X=imread('Parrots.jpg','jpg');%�J���[�摜�̓ǂݍ���150�~150��f
S=imresize(X,[128,128]);%128�~128��f�։摜�T�C�Y�̕ϊ�
Z=rgb2gray(S);%�O���[�X�P�[���摜�ϊ�
N=128;%�摜�̐؂���T�C�Y N�~N,N=128
Y=imresize(Z,[N,N]);%�摜�̐؂��� 128�~128
th=140;%�摜�̔Z�W�����Ɣ���2�l�����邽�߂�臒l�Z�W�l
BY=zeros(N,N);
for i=1:N
    for j=1:N
        if Y(i,j)>=th;
            BY(i,j)=1;%2�l���i���j
        else
            BY(i,j)=0;%2�l���i���j
        end
    end
end

figure(1)
subplot(2,1,1);imshow(Y);colorbar;xlabel('Gray scale image')%���̃O���[�X�P�[���\��
subplot(2,1,2);histogram(Y,256);xlabel('Gray scale histogram')%���̃q�X�g�O����

figure(2)
subplot(2,1,1);imshow(BY);colorbar;xlabel('Binary image')%2�l����̉摜
subplot(2,1,2);histogram(BY,2);xlabel('Binary histgram')%2�l����̃q�X�g�O����
