function result = SpectralEntropy(signalMat, fs)
  numOfBins = 10;

	numberOfFrames = size(signalMat)(2);
	result = zeros(1,numberOfFrames);

	for (i = 1 : numberOfFrames)
		window = signalMat(:,i);
		[fftTemp , xVec] = positiveAbsPartFFT(window, fs,true); % determine FFT of window
    S = sum(fftTemp);
    h_step = floor(length(fftTemp) / numOfBins);
    for (j=1:numOfBins)
        x(j) = sum(fftTemp((j-1)*h_step + 1: j*h_step)) / S;
    endfor
    result(i) = -sum(x.*log2(x));
	endfor

endfunction
