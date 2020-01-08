close all;clear;clc
X=double(imread('Parrots.jpg','jpg'));%�摜�ǂݍ���
S=imresize(X,[128 128]);%�摜�̃��T�C�Y�i�T�C�Y�ύX�j
Y=rgb2ycbcr(S);%YCbCr�摜�ϊ�
Y1=Y(:,:,1);%�O���[�X�P�[�������摜�i�{���x�j
YF=fft2(Y1);%2����FFT
PYFp=YF.*conj(YF)./128./128;%�U�����K��2�����p���[�X�y�N�g��
PYF=flipud(PYFp);%���W������
SPYF=fftshift(PYF);%�p���[�X�y�N�g���̌��_�����S�Ɉړ�
YU=uint8(Y1);%�����Ȃ�8�r�b�g�����ɕϊ�

figure(1)
imshow(YU);xlabel('Gray scale image');%�O���[�X�P�[���摜�\��
figure(2);imshow(SPYF,[0,1.0*10^3]);
xlabel('Normalized PS in center')%���_���S�ٓ���p���[�X�y�N�g��
