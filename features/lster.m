% Content Analysis for Audio Classification and Segmentation (2002)
% Lie Lu, Hong-Jiang Zhang
% see lu2002, lu2009
% LSTER is an effective feature, especially for discriminating
% speech and music signals. In general, there are more silence
% frames in speech than in music; as a result, the LSTER measure
% of speech will be much higher than that of music.
% ### calculates short-time energy for frames of length frameLength
% ### sampling frequency = fs

function lsters = lster(frames, framesPerWindow)
  stes = shortTimeEnergy(frames);
  nrWindows = ceil(length(stes) / framesPerWindow);
  lsters = [];
  for i = 0:(nrWindows-1)
    indLow = i * framesPerWindow + 1;
    indHi = min((i+1)*framesPerWindow, length(stes));
    steWin = stes(indLow:indHi);
    lster = sum(sign(0.5*mean(steWin) - steWin) + 1)/(2*length(steWin));
    lsters = [lsters, lster * ones(1, length(steWin))];
  endfor
endfunction
