close all;clear all;
X=imread('BOAT.jpg','jpg');

imwrite(X,'compBOAT1.jpg','jpg','Quality',50);
%jpg���k�i�i��=50�j��������
imwrite(X,'compBOAT2.jpg','jpg','Quality',20);
%jpg���k�i�i��=20�j��������
imwrite(X,'compBOAT3.jpg','jpg','Quality',4);
%jpg���k�i�i��=4�j��������

X1=imread('compBOAT1.jpg','jpg');%�i��=50�摜�ǂݍ���
X2=imread('compBOAT2.jpg','jpg');%�i��=20�摜�ǂݍ���
X3=imread('compBOAT3.jpg','jpg');%�i��=4�摜�ǂݍ���

[peaksnr, snr] = psnr(X,X1); 
fprintf('\n The PSNR(Q=50) value is %0.4f', peaksnr);
[peaksnr, snr] = psnr(X,X2); 
fprintf('\n The PSNR(Q=20) value is %0.4f', peaksnr);
[peaksnr, snr] = psnr(X,X3); 
fprintf('\n The PSNR(Q=4) value is %0.4f', peaksnr);


subplot(2,2,1),imshow(X);xlabel('Original image')%�摜�o��
subplot(2,2,2),imshow(X1);xlabel('JPEG image (Q=50)')%�摜�o��(Q=50)
subplot(2,2,3),imshow(X2);xlabel('JPEG image (Q=20)')%�摜�o��(Q=20)
subplot(2,2,4),imshow(X3);xlabel('JPEG image (Q=4)')%�摜�o��(Q=4)