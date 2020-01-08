close all;clear all;
X=imread('BOAT.jpg','jpg');

imwrite(X,'compBOAT1.jpg','jpg','Quality',50);
%jpg圧縮（品質=50）書き込み
imwrite(X,'compBOAT2.jpg','jpg','Quality',20);
%jpg圧縮（品質=20）書き込み
imwrite(X,'compBOAT3.jpg','jpg','Quality',4);
%jpg圧縮（品質=4）書き込み

X1=imread('compBOAT1.jpg','jpg');%品質=50画像読み込み
X2=imread('compBOAT2.jpg','jpg');%品質=20画像読み込み
X3=imread('compBOAT3.jpg','jpg');%品質=4画像読み込み

[peaksnr, snr] = psnr(X,X1); 
fprintf('\n The PSNR(Q=50) value is %0.4f', peaksnr);
[peaksnr, snr] = psnr(X,X2); 
fprintf('\n The PSNR(Q=20) value is %0.4f', peaksnr);
[peaksnr, snr] = psnr(X,X3); 
fprintf('\n The PSNR(Q=4) value is %0.4f', peaksnr);


subplot(2,2,1),imshow(X);xlabel('Original image')%画像出力
subplot(2,2,2),imshow(X1);xlabel('JPEG image (Q=50)')%画像出力(Q=50)
subplot(2,2,3),imshow(X2);xlabel('JPEG image (Q=20)')%画像出力(Q=20)
subplot(2,2,4),imshow(X3);xlabel('JPEG image (Q=4)')%画像出力(Q=4)