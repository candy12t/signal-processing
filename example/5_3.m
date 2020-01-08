close all;clear;clc
X=double(imread('Parrots.jpg','jpg'));%画像読み込み
S=imresize(X,[128 128]);%画像のリサイズ（サイズ変更）
Y=rgb2ycbcr(S);%YCbCr画像変換
Y1=Y(:,:,1);%グレースケール成分画像（倍精度）
YF=fft2(Y1);%2次元FFT
PYFp=YF.*conj(YF)./128./128;%振幅正規化2次元パワースペクトル
PYF=flipud(PYFp);%座標軸調整
SPYF=fftshift(PYF);%パワースペクトルの原点が中心に移動
YU=uint8(Y1);%符号なし8ビット整数に変換

figure(1)
imshow(YU);xlabel('Gray scale image');%グレースケール画像表示
figure(2);imshow(SPYF,[0,1.0*10^3]);
xlabel('Normalized PS in center')%原点中心異動後パワースペクトル
