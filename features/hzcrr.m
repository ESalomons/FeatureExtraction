% Content Analysis for Audio Classification and Segmentation (2002)
% Lie Lu, Hong-Jiang Zhang
% ZCR correlates with the frequency content of a signal. Human voice consists of voiced
% and unvoiced sounds. The voiced and unvoiced frames have
% low and high ZCR values, respectively. Therefore, human
% voice shows a higher variation of ZCR. Typically, music does
% not have this variation in ZCR,

% the variation of ZCR is more discriminative than
% the exact value of ZCR. Therefore, we use high zero-crossing
 % rate ratio (HZCRR) as one feature in our approach.
% HZCRR is defined as the ratio of the number of frames whose
% ZCR are above 1.5-fold average zero-crossing rate in an 1-s
% window

% framelength in seconds
function hzcrrs = hzcrr(frames, framesPerWindow)
  zcrs = zeroCrossingRate(frames);
  nrWindows = ceil(length(zcrs) / framesPerWindow);
  hzcrrs = [];
  for i = 0:(nrWindows-1)
    indLow = i * framesPerWindow + 1
    indHi = min((i+1)*framesPerWindow, length(zcrs))
    zcrWin = zcrs(indLow:indHi);
    hzcrr = sum(sign(zcrWin - 1.5 * mean(zcrWin)) + 1)/(2 * length(zcrWin));
    hzcrrs = [hzcrrs, hzcrr * ones(1, length(zcrWin))];
  endfor
endfunction
