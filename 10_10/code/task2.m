close all; clear; clc

fs=16000;
recObj=audiorecorder(fs,16,1); %16bit�Ń��m����

disp('Start Speaking'); %�^���J�n
recordblocking(recObj,2); %recObj�ɂQ�b�Ԃ̘^��
disp('End of Recording'); %�^���I��

record=getaudiodata(recObj,'single');%recObj�̃f�[�^��P���x�z��Ƃ��ĕϐ�record�Ɋi�[

audiowrite('output.wav',record,fs);%recObj�̐��l�f�[�^��wav�t�@�C���Ƃ��ĕۑ�
[recspeech,fs]=audioread('output.wav');% wave�t�@�C���ƃT���v�����O���g����ϐ��֓ǂݍ��݊i�[
sound(recspeech,fs);%�Đ�

[onsei, fs]=audioread('output.wav'); %�����t�@�C����I���A�ǂݍ���
s=onsei; %���x�N�g���ɕϊ�

M=length(s); %���Ƃ̉����g�`�̐M����
N=4096; %�M���̐؂�o�����̒���(FFT�̃T�C�Y)
a=3600; %�����g�`s�̎�v��a~a+(N-1)�܂ł̐؂�o���J�n�ʒu

S=fft(s); %FFT
Xf=S.*conj(S)./N./N; %�U�����K���p���[�X�y�N�g���̌v�Z
fn=linspace(0,fs,M); %���g�����x�N�g���̐���


figure(1); %�����g�`�̕\��
plot(s);
xlabel('Sample');ylabel('Amplitude')

figure(2) %�p���[�X�y�N�g���̕\��
plot(fn,Xf);
xlabel('Frequency [Hz]');ylabel('Power Spectrum')