close all; clear;clc
fs=16000;%�T���v�����O���g��
Ts=1/fs;%�T���v�����O�Ԋu
N=128;%���g(����N)
win=rectwin(N);%���֐��̎��
S=N/2;%���̏d�Ȃ��(�ړ��O��ł̑��̏d�Ȃ��)
M=10;%�S�̂̎��Ԓ������߂�ϐ��i������M�{�̖ڈ��j
tmax=Ts*(N-1)*M;%�S�̂̎��Ԓ�

t=0:Ts:tmax;%���W0~tmax�܂ŁA�T���v�����O�Ԋu�̎��_(�����M����)N=128
s=cos(2*pi*1200*t);%1200[Hz]�̗]���g
sd=7;rng(sd);%�G�������̏����l
xn=0.5*randn(size(t));%0.4 �G�����x���̒���
x=s+xn;%�ϑ��M��
n=0:1:M*(N-1);%�ϑ��M���̃T���v����(N-1)*M�_

Xtf=stft(x,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
rx=istft(Xtf,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
[fnum, tnum]=size(Xtf);
Ntf=stft(xn,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
absXtf=abs(Xtf);
absNtf=abs(Ntf);
Y=(ones(fnum,tnum)-absNtf./absXtf).*Xtf;

y=istft(Y,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
ny=0:1:length(y)-1;

Yft=stft(y,fs,'Window',win,'OverlapLength',S,'FFTLength',N);

figure(1)
subplot(211)
stem(n,x,'fil','MarkerSize',2);axis([0,3*N-1,-2,2]);
hold on; plot(n,x,'r-.');xlabel('Number of Sample');ylabel('Amplitude of x(n)');
subplot(212)
stem(ny,y,'fil','MarkerSize',2);axis([0,3*N-1,-2,2]);
hold on; plot(ny,y,'r-.');xlabel('Number of Sample');ylabel('Amplitude of x(n)');

figure(2)
subplot(211)
stft(x,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
subplot(212)
stft(y,fs,'Window',win,'OverlapLength',S,'FFTLength',N);

figure(3)
subplot(211)
stft(x,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
title('Observed single'); view(-45,65); colormap parula
subplot(212)
stft(y,fs,'Window',win,'OverlapLength',S,'FFTLength',N);
title('Observed single'); view(-45,65); colormap parula