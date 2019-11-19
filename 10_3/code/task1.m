% 音声の取得/再生 プログラム
clear; % 変数の初期化
Fs = 16000; %サンプリング周波数の設定
% 音声を16000 Hzのサンプルレートで信号値表現16bitで1(モノラル)チャンネルで取り込む
recObj = audiorecorder(Fs, 16, 1);

disp('Start Speaking') % 録音開始
recordblocking(recObj, 2); % recObjのオブジェクトに2秒間で音声を録音
disp('End of Recording') % 録音終了

record = getaudiodata(recObj, 'single'); % recObjのデータを単精度配列として変数recordに格納

figure(1)
plot(record); % 音声波形の表示
xlabel('Sample Number'); ylabel('Amplitude');

play(recObj); % 音声を先頭から最後まで再生する