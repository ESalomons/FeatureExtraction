% Bandwidth [21] is the width of the range of the frequencies that the signal occupies. It makes use of the
% SC value and shows the spectrum is concentrated around the centroid or spread out over the whole
% spectrum.
% It is a measure of the “flatness” of the FFT spectrum. Most ambient sound consists of a limited range of
% frequencies, having a small value. Music often consists of a broader mixture
% of frequencies than voice and ambient sound
% see lu2009

% BW = sqrt( sum[ (i - SC)^2 * p(i)^2] / sum (p(i)^2))
% i = freq; SC = spectral centroid; p(i) = fft value of freq. i
% lu2009 does not take sqrt; seems logical to do for me; comp. with standard deviation

% wl = windowLength (seconds)

function mC = bandwidth(signalMat,fs)
	numberOfFrames = size(signalMat)(2);
	mC = zeros(1,numberOfFrames);

	for (i = 1 : numberOfFrames)
		window = signalMat(:,i);

		[FFT , xVec] = positiveAbsPartFFT(window, fs,true); % determine FFT of window
		FFTsq = FFT.^2;
		centroid = spectralCentroid(window, fs);
		xMinSCSquare = (xVec-centroid).^2;

		mC(i) = sqrt(sum(xMinSCSquare.*FFTsq) / sum(FFTsq));

	endfor

endfunction
