close all; clear; clc
tmax = 2.0; %���Ԓ����
ts = 0.001; %���ԍ��ݕ�(�T���v�����O�Ԋu)
fs = 1/ts; %�T���v�����O���g��
t = 0:ts:tmax-ts; %���Ԏ��x�N�g��

% �����g����
fr = 50; %�����g���g��
cw = sin(2*pi*fr*t); %�����g����

% ���M�p���X��̐���
fp = 10; %���M�p����̎��g��[Hz]
BT = 1/fp; %���M�p���X�̎���
SL = BT/ts; %1�p���X�̃T���v����
Nb = tmax/BT; %���M�r�b�g��
sd = 5; rng(sd); %���������̏����l
Sb = randi([0, 1], 1, Nb); %���M�r�b�g�񐶐�
spls = repelem(Sb, SL); % �r�b�g�p���X��M��

% �ꎟ�ϒ��g�̐���
A0 = -1.0; %�r�b�g0���U��-1.0(�r�b�g0)
A1 = 1.0; %�r�b�g1���U��1.0(�r�b�g1)
Damp = zeros(1, Nb); %�ꎟ�ϒ�(�p���X�U���ϒ�)�z��̏�����
for c = 1:Nb
    if Sb(1, c) == 0
        Damp(1, c) = A0; %�r�b�g0�̂Ƃ�PSK��0[rad]
    else
        Damp(1, c) = A1;%�r�b�g1�̂Ƃ�PSK��0[rad]
    end
end
mpls = repelem(Damp, SL); %�U���ϒ��l�̑��M�p���X��M��

% PSK�ϒ�
PSK = cw.*mpls;

% SS�ϒ�
alpha = 20; %�g�U�� �r�b�g��p���X���g����alpha�{
Nbs = Nb * alpha; %�g�U�M���̃r�b�g��(alpha�{)
SLs = SL/alpha; %�g�U�M��1�p���X�̃T���v����

rng(8); %�����̏����l�V�[�h
MX = 2*randi([0, 1], 1, Nbs)-1; %�g�U�ϒ��p-1, +1�̗�������
sspls = repelem(MX, SLs); %�g�U�ϒ��p�����p���X��

% SS�ϒ�
SS = sspls.*PSK; %�ϒ��g(�g�U�M���Ƒ��M�p���X��̏�Z)

% ��M��(���֌��o)
spls0 = A0*cw; % �r�b�g0�̂Ƃ��̕ϒ��g(�)
spls1 = A1*cw; % �r�b�g1�̂Ƃ��̕ϒ��g(�)
COR0 = PSK.*spls0; % ��M�ϒ��g�ƃr�b�g0�ϒ��g�̏�Z(����)
COR1 = PSK.*spls1; % ��M�ϒ��g�ƃr�b�g1�ϒ��g�̏�Z(����)
SPSK0 = reshape(COR0, [SL, Nb]); % �r�b�g�P�ʂɑ��ւ̐���
SPSK1 = reshape(COR1, [SL, Nb]); % �r�b�g�P�ʂɑ��ւ̐���

DC0 = zeros(1, Nb); % �r�b�g0�Ƃ̑��֒l�̔z��̏�����
DC1 = zeros(1, Nb); % �r�b�g1�Ƃ̑��֒l�̔z��̏�����
Rb = zeros(1, Nb); % ���ւ̋���̔���̔z�񏉊���
for e=1:Nb
    DC0(1, e) = sum(SPSK0(:,e))/SL; % �r�b�g0�Ƃ̐��K�����֒l
    DC1(1, e) = sum(SPSK1(:,e))/SL; % �r�b�g1�Ƃ̐��K�����֒l
    Rb(1, e) = DC1(1, e) >= DC0(1, e); % ���֒l�̔���
end
dpls = repelem(Rb, SL); % ��M���蕜���p���X��M��

BER = (sum(xor(Sb, Rb))/Nb); %BER�Z�o
disp([num2str(Nb), 'bit���M']) % ���M�r�b�g���\��
disp(['���Mbit��', num2str(Sb)]) % ���M�r�b�g��\��
disp(['��Mbit��', num2str(Rb)]) % ��M�r�b�g��\��
disp(['BER=', num2str(BER), '% [���bit��/���Mbit��]'])

figure(1)
subplot(311)
plot(t, spls); %���M�r�b�g�p���X��M��
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(312)
plot(t, PSK); %1���ϒ��p���X��M��
axis([0, tmax, -1.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(313)
plot(t, SS); %2���ϒ��g�����p���X�M��
axis([0, tmax, -1.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
saveas(gcf,'../result_image/figure1.png')

figure(2)
subplot(211)
plot(t, dpls) % ��M�r�b�g�p���X��M��
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
subplot(212)
plot(t, spls) % ���M�r�b�g��M��
axis([0, tmax, -0.5 1.5]); xlabel('Time [s]'); ylabel('Amplitude');
saveas(gcf,'../result_image/figure2.png')