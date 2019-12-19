function [YF] = mask(YO, delta, C, R, H)
YF = YO;
for i = 1+delta:C-delta
    for j = 1+delta:R-delta
        S = double(YO(i-delta:i+delta,j-delta:j+delta));
        YF(i, j) = sum(sum(H.*S));
    end
end
end

