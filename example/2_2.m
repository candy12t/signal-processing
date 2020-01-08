close all; clear; clc;%�ϐ��̏�����
fs=16000;%�T���v�����O���g���̐ݒ�
Ts=1/fs;%�T���v�����O���Ԋu
N=256;%�T���v�����i����N�j
tmax=Ts*(N-1);%���Ԕ͈͂̍ő�l

t=0:Ts:tmax;%���W0~tmax�܂ŁA�T���v�����O�Ԋu�̎��_(�����M����)N=128
s=cos(2*pi*1200*t);%1200[Hz]�̗]���g
sd=7;rng(sd);%�G�������̏����l
xn=0.5*randn(size(t));%0.4 �G�����x���̒���
x=s+xn;%�ϑ��M��

n=0:1:N-1;%0~(N-1)��N�_�T���v���O���b�h(=DFT�T�C�Y)
X=fft(x);%k�ϑ��M����DFT
Xf=X.*conj(X)./N./N;%�U�����K���p���[�X�y�N�g��
df=2*pi/(N-1);%0~2pi��Nf����
nf=0:df:2*pi;%���K���p���g�����i�T���v�����O���g��=2�΁j

XN=fft(xn);%�G����DFT
absX=abs(X);%�ϑ��M���̐U���X�y�N�g��
absN=abs(XN);%�G���̐U���X�؃N�g��
Y=(ones(1,N)-absN./absX).*X;%�X�y�N�g���E�T�u�X�g���N�V����

y=ifft(Y);%�G��������̐M����IDFT
