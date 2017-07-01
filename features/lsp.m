function lsps = lsp(frames)
  nrFrames = size(frames)(2);
  framesize = size(frames)(1);
  lsps = [];

  for i = 1:nrFrames
    frame = frames(:,i)';
    [ar,e,k] = lpcauto(frame);
    values = lpcar2ls(ar);
    lsps = [lsps,values'];
  endfor
endfunction
