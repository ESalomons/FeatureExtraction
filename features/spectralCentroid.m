%Spectral Centroid is the balancing point of the spectral power distribution
% see: lu2009
% centroid = sum(i * p(i)^2) / sum(p(i)^2
% i = freq; p(i) = normalized freq. amplitude
% wl = windowLength (seconds)

function mC = spectralCentroid(signalMat, fs)

	numberOfFrames = size(signalMat)(2);
	mC = zeros(1,numberOfFrames);

	for (i = 1 : numberOfFrames)
		window = signalMat(:,i);
		[FFT , xVec] = positiveAbsPartFFT(window, fs,true); % determine FFT of window
		FFTsq = FFT.^2;
		mC(i) = sum( FFTsq.*xVec ) / sum(FFTsq);
	endfor

endfunction
