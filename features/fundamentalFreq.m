% fundamental frequency is the frequency with the highest
% peak in the FFT spectrum

function result = fundamentalFreq(signalMat, fs)

	numberOfFrames = size(signalMat)(2);
	result = zeros(1,numberOfFrames);

	for (i = 1 : numberOfFrames)
		window = signalMat(:,i);
		[FFT , xVec] = positiveAbsPartFFT(window, fs,true); % determine FFT of window

		idx = find(FFT == max(FFT))(1);
		result(i) = xVec(idx);
	endfor

endfunction
