close all; clear; clc

tmax = 2.0; % ���Ԓ����
ts = 0.001; % ���ԍ��ݕ�(�T���v�����O�Ԋu)
fs = 1/ts; % �T���v�����O���g��
t = 0:ts:tmax-ts; % ���Ԏ��x�N�g��

% ���M�� %
fr = 50; % �����͎��g��[Hz]
cw = sin(2*pi*fr*t); %�����g
A0 = 0.3; % �ϒ��̐U��A0(�r�b�g0)
A1 = 1.0; % �ϒ��̐U��(�r�b�g1)

fp = 10; % ���M�p���X�̎��g��[Hz]
BT = 1/fp; % ���M�p���X�̎���(1�p���X�̎��Ԏ�[s])
SL = BT/ts; % 1�p���X�̃T���v����
Nb = tmax/BT; % ���M�r�b�g��
sd = 5; rng(sd); % ���������̏����l
SXbit = randi([0, 1], 1, Nb); % ���M�r�b�g�񐶐�

Damp = zeros(1, Nb); % ASK�̐U���l�̔z��̏�����
for c=1:Nb
    if SXbit(1, c) == 0
        Damp(1, c) = A0; % �r�b�g0�̎���ASK�̐U���l
    else
        Damp(1, c) = A1; % �r�b�g1�̎���ASK�̐U���l
    end
end
spls = repelem(SXbit, SL);
mpls = repelem(Damp, SL); % �U���ϒ��l�̑��M�p���X��M������

% ASK�ϒ� %
ASK = cw.*mpls; % ASK�ϒ��g
F_ASK = fft(ASK);
N = length(ASK); % �ϒ��g�̐M����(�T���v����)
nf = 0:fs/(N-1):fs; % ���g�����x�N�g������

frn = 60;
[nis, Fs] = audioread('../../audio/white_Noise.wav');
wn = nis';
wnoise = wn(1:length(cw));
nnoise = cos(2*pi*frn*t);
ASKn = ASK + 1.5*wnoise + 0.2*nnoise;

% ��M�� %
AbASK = abs(ASKn); % ASK�ϒ��g�̐�Βl

% ���g���̈�LPF %
FT_AbASK = fft(AbASK); % FFT
H = zeros(1, N); % LPF������
H(1:round(N/16)) = 1; % �ʉߑш悪fs/16��LFP
H(N+2-round(N/16):N) = 1; % �ʉߑш悪fs/16��LFP
Env_AbASK = FT_AbASK.*H; % ������(LPF)��������
rpls = ifft(Env_AbASK); % IFFT(�p���X�������g)

% ����̔��菈��%
th = abs((A0-A1)/2); % �r�b�g����̂������l(����)
RXbit = zeros(1, Nb); % �Ҍ��p���X�̒����l�̂������l����
for d=1:Nb
    RXbit(1, d) = rpls(1, (d-1)*SL+SL/2) >= th; % �����l�u�^�v�Ȃ�1
end
dpls = repelem(RXbit, SL); % ��M����Ҍ��p���X�M��

BER = (sum(xor(SXbit, RXbit))/Nb); %BER�Z�o
disp([num2str(Nb), 'bit���M'])
disp(['���Mbit��', num2str(SXbit)]) % ���M�r�b�g��\��
disp(['��Mbit��', num2str(RXbit)]) % ��M�r�b�g��\��
disp(['BER=', num2str(BER), '% [���bit��/���Mbit��]'])


figure(1)
subplot(311)
plot(t, cw); % �����g
axis([0, tmax, -1.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(312)
plot(t, spls);
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(313)
plot(t, ASK); % ASK�ϒ��g
axis([0, tmax, -1.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
% saveas(gcf,'../result_image/figure1.png')

figure(2)
subplot(311)
plot(t, rpls);
axis([0, tmax, -0.0 1.0]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(312)
plot(t, dpls);
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(313)
plot(t, spls);
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');

% saveas(gcf,'../result_image/figure2.png')