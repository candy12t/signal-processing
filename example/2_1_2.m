close all; clear; clc

fs = 16000; % �T���v�����O���g��
Ts = 1/fs; % �T���v�����O�Ԋu
N = 256; % �T���v����(����N)
tmax = Ts*(N-1); % ���Ԕ͈͂̍ő�l

t=0:Ts:tmax; %���W0~tmax�܂ŁA�T���v�����O�Ԋu�̎��_(�����M��)N=128
s=cos(2*pi*1200*t); % 1200[Hz]�̗]���g
sd = 7; rng(sd); % �G�������̏����l
xn = 0.5*randn(size(t)); % 0.4 �G�����x���̒���
x = s + xn; % �ϑ��M��

h = fir1(40, 0.25, 'low'); % ����40(�t�B���^��41)��LPF�̐݌v(0.25�� ���֐��@)
y = filter(h, 1, x); % FIR�t�B���^�ɂ�邽���ݍ��݉��Z

n = 0:1:N-1; % 0~(N-1)��N�W�T���v���O���b�h(=DF�T�C�Y)
X = fft(x); % DFT(�ϊ�)
Xf = X.*conj(X)./N./N; % �U�����K���p���[�X�y�N�g��
df = 2*pi/(N-1); % 0~2pai��Nf����
nf = 0:df:2*pi; % ���K���p���g����(�T���v�����O���g��=2��)

Y = fft(y);
Yf = Y.*conj(Y)./N./N; % ������̐U�����K���p���[�X�y�N�g��

figure(1);
subplot(211)
stem(n, x, 'fil', 'MarkerSize', 2);
axis([0, N-1, -2, 2]); % ���ԗ̈�f�B�W�^���\��(�ϑ��M��)
hold on
plot(n, x, 'r-.');
xlabel('Number of Sample');
ylabel('Amplitude of x(n)');

subplot(212)
stem(n, x, 'fil', 'MarkerSize', 2);
axis([0, N-1, -2, 2]); % ���ԗ̈�f�B�W�^���\��(�����M��)
hold on
plot(n, y, 'r-.');
xlabel('Number of Sample');
ylabel('Amplitude of y(n)');

figure(2);
subplot(211)
stem(nf, Xf, 'MarkerSize', 4);
axis([0, 2*pi, 0, 0.25]); % 2�΂܂ŕ\��
xlabel('Normalized Frequency 2*pi [rad/s]');
ylabel('Power Spectrum of X(��)');

subplot(212)
stem(nf, Yf, 'MarkerSize', 4);
axis([0, 2*pi, 0, 0.25]); % 2�΂܂ŕ\��
xlabel('Normalized Frequency 2*pi [rad/s]');
ylabel('Power Spectrum of Y(��)');

figure(3)
freqz(h, 1); % FIR�t�B���^�̎��g������