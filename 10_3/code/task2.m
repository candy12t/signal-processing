close all; clear; clc

fs=16000; %�T���v�����O���g��
recObj=audiorecorder(fs,16,1); %16bit�Ń��m����

disp('Start Speaking');%�^���J�n
recordblocking(recObj,2);%recObj�ɂQ�b�Ԃ̘^��
disp('End of Recording');%�^���I��

record=getaudiodata(recObj,'single');%recObj�̃f�[�^��P���x�z��Ƃ��ĕϐ�record�Ɋi�[

audiowrite('output.wav',record,fs);%recObj�̐��l�f�[�^��wav�t�@�C���Ƃ��ĕۑ�
[recspeech,fs]=audioread('output.wav');% wave�t�@�C���ƃT���v�����O���g����ϐ��֓ǂݍ��݊i�[
sound(recspeech,fs);%�Đ�

[onsei,fs]=audioread('output.wav');%�����t�@�C����I���A�ǂݍ���
s=onsei';%���x�N�g���ɕϊ�

M=length(s); %���Ƃ̉����g�`�̐M����
n=4096; %�M���̐؂�o�����̒���(FFT�̃T�C�Y)
a=3600; %�����g�`s�̎�v��a~a+(N-1)�܂ł̐؂�o���J�n�ʒu

win=rectwin(n); %���֐��̑I��
w=zeros(1,M); %���֐��̏�����
w(a:a+n-1)=win; %���֐��̊J�n�ʒu�Ɣ͈͂̎w��

x=s.*w; %���֐��ɂ��؂�o��

S=fft(s); %���֐�������FFT
Xs=S.*conj(S)./M./M; %�U�����K���p���[�X�y�N�g���̌v�Z
X=fft(x); %���֐����������M����FFT
Xp=X.*conj(X)./M./M; %�U�����K���p���[�X�y�N�g��(�������M��)�̌v�Z
fn=linspace(0,fs,M); %���g�����x�N�g���̐���


figure(1);
plot(record);%�����g�`�̕\��
xlabel('Sample Number');ylabel('Amplitude')

figure(2);
subplot(211)
plot(s);xlabel('Sample');ylabel('Amplitude');%���֐��Ȃ������g�`�\���i���͔z��ԍ��j   
subplot(212)
plot(x);xlabel('Sample');ylabel('Amplitude');%���֐����|���������g�`�\���i���͔z��ԍ��j

figure(3)
subplot(211)
plot(fn,Xs);axis([0 fs/2 0 1.0*10^(-4)]);
xlabel('Frequency [Hz]');ylabel('Power Spectrum'); %�p���[�X�y�N�g���̕\��
subplot(212)
plot(fn,Xp);axis([0 fs/2 0 1.0*10^(-6)]);
xlabel('Frequency [Hz]');ylabel('Power Spectrum'); %�p���[�X�y�N�g���̕\��

sound(s,fs) %�����T�E���h���T���v�����O���g��fs��s�̉������X�s�[�J����Đ�