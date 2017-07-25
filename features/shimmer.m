% See: Jitter and Shimmer Measurements for Speaker Recognition
% Farrus, Hernando, Ejarque, 2009

% Jitter (relative) is defined as the average absolute
% difference between the fundamental frequency of consecutive periods,
% divided by the average fundamental frequency, expressed as a
% percentage

function result = shimmer(frames, framesPerWindow)
  frameValues = max(abs(frames)); % maximum amplitude

  nrWindows = ceil(length(frameValues) / framesPerWindow);
  result = [];
  for i = 0:(nrWindows-1)
    indLow = i * framesPerWindow + 1;
    indHi = min((i+1)*framesPerWindow, length(frameValues));
    window = frameValues(indLow:indHi);

    N = length(window);
    sumWin = sum(window);
    if sumWin == 0 || N <= 1
      windowValue = 0;
    else
      windowValue = (sum(abs(window(1:end-1) .- window(2:end)))/(N-1) ) ...
                                /  (sumWin / N);
    endif
    result = [result, windowValue * ones(1, N)];
  endfor
endfunction
