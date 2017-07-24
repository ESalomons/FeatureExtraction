% for definition: see Speech emotion recognition using hidden Markov models
% Tin Lay Nwe, Say Wei Foo, Liyanage C. De Silva, 2003

function result = lfpc(frames, fs)
  % define bands
  bandwidths = [54] % base bandwidth
  centerFreqs = [127] % base frequency

  alpha = 1.4 % parameter, determines width of spectrum that is considered
              % alpha = 1.4 takes spectrum from 100 - 8000 Hz

  for i = 2:12
    newB = alpha * bandwidths(end);
    bandwidths = [bandwidths, newB];
  endfor

  for i = 2:12
    newF = centerFreqs(1) + sum(bandwidths(1:i-1)) ...
                    + (bandwidths(i) - bandwidths(1)) / 2;
    centerFreqs = [centerFreqs, newF];
  endfor

endfunction
