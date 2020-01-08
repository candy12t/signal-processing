close all; clear; clc
[onsei,fs]=audioread('A_a.wav');%�����t�@�C����I�����A�ǂݍ���
s=onsei';%���x�N�g���ɕϊ�

M=length(s);%���̉����g�`�̐M����
N=4096;%�M���̐؂�o�����̒����i�M����=FFT�̃T�C�Y�j
a=4500;%�����g�`s�̎�v��+a~a+(N-1)�܂ł�؂�o���J�n�ʒu

win=hamming(N)';%win=rectwin(N)';%���֐��̎w��
w=zeros(1,M);%���֐��̏�����
w(a:a+N-1)=win;%���֐��̊J�n�ʒu�Ɣ͈͂̎w��

x=s.*w;%���֐��ɂ��؂�o��

figure(1);
subplot(211)
plot(s);xlabel('Sample');ylabel('Amplitude');%���֐��Ȃ������g�`�\���i���͔z��ԍ��j
subplot(212)
plot(x);xlabel('Sample');ylabel('Amplitude');%���֐����|���������g�`�\���i���͔z��ԍ��j

S=fft(s);%���֐��Ȃ��M����FFT
Xs=S.*conj(S)./M./M;%�U�����K���p���[�X�y�N�g���̌v�Z(0~20kHz)
X=fft(x);%���֐����|�����M����FFT
Xp=X.*conj(X)./M./M;%�U�����K���p���[�X�y�N�g���i���|���M���j�̌v�Z(0~20kHz)
fn=linspace(0,fs,M);%���g�����x�N�g���̐���(0~fs/2)

figure(2)
subplot(211)
plot(fn,Xs);axis([0 fs/20 0 1.0*10^(-4)]);
xlabel('Frequency [Hz]');ylabel('Power Spectrum');%�p���[�X�y�N�g���̕\��
subplot(212)
plot(fn,Xp);axis([0 fs/10 0 1.0*10^(-4)]);
xlabel('Frequency [Hz]');ylabel('Power Spectrum');%�p���[�X�y�N�g���̕\��

sound(s,fs)%�����T�E���h���T���v�����O���g��fs��s�̉������X�s�[�J����Đ�