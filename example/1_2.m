close all; clear; clc
N = 2^14; % �M����(N=16384)
tmax = 2.0; % ���ԊԊu0~2 [s]
ts = tmax/(N-1); % �T���v�����O�Ԋu(�Ԋu��:N-1)

t = linspace(0, tmax, N); % ���Ԏ��x�N�g���̐���
y1 = 0.5*cos(2*pi*1000*t);
y2 = sin(2*pi*2000*t + pi/4);
y3 = 0.8*cos(2*pi*400*t - pi*3/4);
y = y1+y2+y3; % ���ш�A�i���O�M��

save signal.mat y; % �ϐ�y�̒l��signal�Ƃ������O��mat�t�@�C���ɕۑ�
s = load('signal'); % mat�t�@�C������signal�̃f�[�^��ǂݍ��ݍ\����s�ɑ��(�ϐ���y)
z = s.y; % �\����s�̕ϐ�y��z�ɑ��(y�Ɠ����l)

figure(1);
plot(t, y);
xlabel('Time [sec]');
ylabel('Amplitude');
axis([0 0.01*tmax -3 3]); %�g�`�̕\���͈�

Y = fft(y); % FFT�����t�[���G�ϊ�
Yp = Y.*conj(Y)./N./N; % ���K���p���[�X�y�N�g��

fs = 1/ts; % �T���v�����O���g��
nf = (0:1/(N-1):1) * fs; % ���g�����x�N�g���̐���

figure(2);
plot(nf, Yp);
xlabel('Frequency');
ylabel('Amplitude'); % �X�y�N�g���̕\���͈�
axis([0 fs/2 0 0.3 ]);