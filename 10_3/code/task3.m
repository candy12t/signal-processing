close all; clear; clc;
Fs=16000; %�T���v�����O���g���̐ݒ�
recObj=audiorecorder(Fs,16,1); %16bit�Ń��m����

disp('Start Speaking');%�^���J�n
recordblocking(recObj,2);%recObj�ɂQ�b�Ԃ̘^��
disp('End of Recording');%�^���I��

s=getaudiodata(recObj,'single');%recObj�̃f�[�^��P���x�z��Ƃ��ĕϐ�s�Ɋi�[

[f,Fs]=audioread('../../white_Noise.wav');%�G���̓ǂݍ���
M=length(s);
m=s+f(1:M);

figure(1);
subplot(211)
plot(s);xlabel('Sample');ylabel('Amplitude');%�����M���o��
subplot(212)
plot(m);xlabel('Sample');ylabel('Amplitude');%�ϑ��M���o��

S=snr(s,m);