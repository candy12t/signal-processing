function [YF] = mask(YO, delta, C, R, H)
    YF = YO; % フィルタ処理用の画像を格納する配列を元画像地に初期化
    for i = 1+delta:C-delta % (i,j)はマスク中心位置(iは縦方向ループ)
        for j = 1+delta:R-delta % (i,j)はマスク中心位置(jは横方向ループ)
            S = double(YO(i-delta:i+delta,j-delta:j+delta)); % フィルタ処理する画像範囲
            YF(i, j) = sum(sum(H.*S)); % フィルタ係数を乗じた総和を出力
        end
    end
end

