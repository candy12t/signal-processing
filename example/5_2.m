close all;clear;clc
X=imread('Parrots.jpg','jpg');%カラー画像の読み込み150×150画素
S=imresize(X,[128,128]);%128×128画素へ画像サイズの変換
Z=rgb2gray(S);%グレースケール画像変換
N=128;%画像の切り取りサイズ N×N,N=128
Y=imresize(Z,[N,N]);%画像の切り取り 128×128
th=140;%画像の濃淡を黒と白の2値化するための閾値濃淡値
BY=zeros(N,N);
for i=1:N
    for j=1:N
        if Y(i,j)>=th;
            BY(i,j)=1;%2値化（白）
        else
            BY(i,j)=0;%2値化（黒）
        end
    end
end

figure(1)
subplot(2,1,1);imshow(Y);colorbar;xlabel('Gray scale image')%元のグレースケール表示
subplot(2,1,2);histogram(Y,256);xlabel('Gray scale histogram')%元のヒストグラム

figure(2)
subplot(2,1,1);imshow(BY);colorbar;xlabel('Binary image')%2値化後の画像
subplot(2,1,2);histogram(BY,2);xlabel('Binary histgram')%2値化後のヒストグラム
