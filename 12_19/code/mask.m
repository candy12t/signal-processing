function [YF] = mask(YO, delta, C, R, H)
    YF = YO; % �t�B���^�����p�̉摜���i�[����z������摜�n�ɏ�����
    for i = 1+delta:C-delta % (i,j)�̓}�X�N���S�ʒu(i�͏c�������[�v)
        for j = 1+delta:R-delta % (i,j)�̓}�X�N���S�ʒu(j�͉��������[�v)
            S = double(YO(i-delta:i+delta,j-delta:j+delta)); % �t�B���^��������摜�͈�
            YF(i, j) = sum(sum(H.*S)); % �t�B���^�W�����悶�����a���o��
        end
    end
end

