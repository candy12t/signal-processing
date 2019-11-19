close all; clear; clc %������

[audio, fs]=audioread('../audio/speech/A_a.wav'); %�����t�@�C����I�����A�ǂݍ���
s=audio'; %���x�N�g���ɕϊ�
[noise, fs]=audioread('../audio/white_Noise.wav'); %�����t�@�C����I�����A�ǂݍ���
n=noise'; %���x�N�g���ɕϊ�

M=length(s); %���̉����g�`�̐M������M�ɑ��(1*13824)
n=n(1:M); %�G���̍s��̎����������ɍ��킹��
x=s+n; %�ϑ��M��=����+�G��

S=fft(s); %������DFT
Xs=S.*conj(S)./M./M; %�U�����K���p���[�X�y�N�g��
fn=linspace(0,fs,M); %���g�����x�N�g���̐���

X=fft(x); %�ϑ��M����DFT
Xn=fft(n); %�G����DFT
absX=abs(X); %�ϑ��M���̐U���X�y�N�g��
absN=abs(Xn); %�G���̐U���X�y�N�g��
Y=(ones(1,M)-absN./absX).*X; %�X�y�N�g���E�T�u�g���N�V����

y=ifft(Y); %�G��������̐M����IDFT

before_snr=snr(s,x); %�G�������O��SNR
after_snr=snr(s,y); %�G���������SNR

% �R�}���h�ɕ\��
disp(['�G�������O��SNR��', num2str(before_snr), '[dB]�ł��B']);
disp(['�G���������SNR��', num2str(after_snr), '[dB]�ł��B']);


%�����̔g�`�̕\��
figure(1);
plot(s); axis([0 14000 -1.0 1.0]);
xlabel('Smaple'); ylabel('Amplitude');

%���K���U���p���[�X�y�N�g���̕\��
figure(2);
plot(fn,Xs); axis([0 fs/2 0 1.0*10^(-4)]);
xlabel('Frequency [Hz]'); ylabel('Power Spectrum');

%�����M���y�юG���M���A�G��������̉����M���̕\��
figure(3);
subplot(311)
plot(s); axis([0 14000 -1.0 1.0]);
xlabel('�����M��s'); ylabel('s(n)');
subplot(312)
plot(x); axis([0 14000 -1.0 1.0]);
xlabel('�ϑ��M��x'); ylabel('x(n)');
subplot(313)
plot(y); axis([0 14000 -1.0 1.0]);
xlabel('�G��������̉����M��y'); ylabel('y(n)');