% �����̎擾/�Đ� �v���O����
clear; % �ϐ��̏�����
Fs = 16000; %�T���v�����O���g���̐ݒ�
% ������16000 Hz�̃T���v�����[�g�ŐM���l�\��16bit��1(���m����)�`�����l���Ŏ�荞��
recObj = audiorecorder(Fs, 16, 1);

disp('Start Speaking') % �^���J�n
recordblocking(recObj, 2); % recObj�̃I�u�W�F�N�g��2�b�Ԃŉ�����^��
disp('End of Recording') % �^���I��

record = getaudiodata(recObj, 'single'); % recObj�̃f�[�^��P���x�z��Ƃ��ĕϐ�record�Ɋi�[

figure(1)
plot(record); % �����g�`�̕\��
xlabel('Sample Number'); ylabel('Amplitude');

play(recObj); % ������擪����Ō�܂ōĐ�����