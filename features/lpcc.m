function cepstra = lpcc(frames)
  nrFrames = size(frames)(2);
  framesize = size(frames)(1);
  cepstra = [];

  for i = 1:nrFrames
    frame = frames(:,i)';
    [ar,e,k] = lpcauto(frame);
    lpccs = lpcar2cc(ar);
    cepstra = [cepstra,lpccs'];
  endfor
endfunction
