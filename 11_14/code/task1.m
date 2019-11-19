close all; clear; clc
Mx = 8; % �p���X�g�`�̕�
M = 8;
Nb = 32; % �p���X�̌�(=�r�b�g��)
sd = 5; rng(sd); % ���������̏����l
Nr = randi([0, M-1], 1, Nb); % M�i�K��Nb�̃p���X�񐶐�(��������)
Nx = Mx * Nb; % �p���X��M���̒���(���T���v����)
n = 0:1:Nx-1; % �p���X��M���̃T���v�����x�N�g��

PuluS = zeros(1, Nx); % �p���X��M���̏�����
for k=1:Nb
    PuluS((k-1)*Mx+1:k*Mx) = Nr(k); % ����̐U���l�̃p���X��M���̐���
end

figure(1)
plot(n, PuluS);
axis([1, Nx, -1, 8]);
xlabel('Number of Sample');
ylabel('Amplitude');
saveas(gcf,'task1.png')