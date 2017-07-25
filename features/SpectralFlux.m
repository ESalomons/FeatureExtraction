function result = SpectralFlux(signalMat, fs)
	numberOfFrames = size(signalMat)(2);
	result = zeros(1,numberOfFrames);

  [FFTprev, xVec]= positiveAbsPartFFT(signalMat(:,1), fs,true);
  FFTprev = FFTprev / max(FFTprev);

	for (i = 2 : numberOfFrames)
		window = signalMat(:,i);
		[FFT , xVec] = positiveAbsPartFFT(window, fs,true); % determine FFT of window
    FFT = FFT/max(FFT);
    result(i) = sum((FFT-FFTprev).^2);
	endfor
  result(1) = result(2); % doesn't make sense to have 0 as first value always

endfunction
