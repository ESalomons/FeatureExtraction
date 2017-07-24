% See: Jitter and Shimmer Measurements for Speaker Recognition
% Farrus, Hernando, Ejarque, 2009

% Shimmer (relative) is defined as the average absolute
% difference between the amplitudes of consecutive periods,
% divided by the average amplitude, expressed as a
% percentage

function result = jitter(frames, fs, framesPerWindow)
  frameValues = fundamentalFreq(frames,fs);

  nrWindows = ceil(length(frameValues) / framesPerWindow);
  result = [];
  for i = 0:(nrWindows-1)
    indLow = i * framesPerWindow + 1;
    indHi = min((i+1)*framesPerWindow, length(frameValues));
    window = frameValues(indLow:indHi);

    N = length(window);

    sumWin = sum(window);
    if sumWin == 0
      windowValue = 0;
    else
      windowValue = (sum(abs(window(1:end-1) .- window(2:end)))/(N-1) ) ...
                                /  (sumWin / N);
    endif
    result = [result, windowValue * ones(1, N)];
  endfor
endfunction
