close all; clear; clc
X = double(imread('Parrots.jpg'));
N = 128; % �摜�T�C�Y
S = imresize(X, [N N]);
XY = rgb2ycbcr(S);
XY1 = XY(:,:,1);
YF = fft2(XY1); % �O���[�X�P�[���摜��2D-DFT
NYF = fftshift(YF); %���_���S�ϊ�
% �t�B���^�̍쐬(���_���SLPF�t�B���^)

G = 20; % �W����1�ɂ���̈�̍L��
Gminus = N/2-G;
Gplus = N/2+G;
H = zeros(N, N);
for i=1:N % �c���[�v���[�v
    for j=1:N % ���������[�v
        if i >= Gminus && i <= Gplus && j >= Gminus && j <= Gplus % ���ʗ̈�
            H(i,j) = 1; % �ʉ߈�=1
        end
    end
end
NZY = H.*NYF; % �t�B���^�����O
ZY = ifftshift(NZY); % �l���Ɍ��_���ړ�(IFFT2�K�p�̂���)
Z = ifft2(ZY); % 2D-IDFT�ŋ�ԗ̈�ϊ�
ZR = real(Z); % ��ԗ̈�摜�̎���

ZRF = fft2(ZR); % LPF��摜��2����FFT
SZRF = fftshift(ZRF); % �X�y�N�g���̒��S�ړ�
PZR = SZRF.*conj(SZRF); % �p���[�X�y�N�g���Z�o(LPF�摜)
PNYF = NYF.*conj(NYF); % �p���[�X�y�N�g���Z�o(���摜)

% HPF
G = 5; % �W����0�ɂ���̈�̍L��(G=0~N/2�̒l��ݒ�)
Gminus = N/2-G;
Gplus = N/2+G;
H = ones(N, N);
for i=1:N % �c���[�v���[�v
    for j=1:N % ���������[�v
        if i >= Gminus && i <= Gplus && j >= Gminus && j <= Gplus % ���ʗ̈�
            H(i,j) = 0; % �ʉ߈�=0
        end
    end
end

% 2D-SS
absYF=abs(YF);
absNIF=abs(NIF);
SY=zeros(N,N);
for k=1:N
    for l=1:N
        SY(k,l)=(1-(absNIF(k,l)/absYF(k,l)))*YF(k,l);
    end
end