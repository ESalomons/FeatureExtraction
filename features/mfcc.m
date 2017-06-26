function cepstra = mfcc(frames, fs)
  nrFrames = size(frames)(2);
  framesize = size(frames)(1);
  cepstra = [];
  p=floor(3*log(fs));
  for i = 1:nrFrames
    frame = frames(:,i);
    cepstra = [cepstra,melcepst(frame,fs,'e0',12,p,framesize)'];
  endfor
endfunction
