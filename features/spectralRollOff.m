%Spectral Rolloff (SRF) is defined as the frequency bin below which 93% of the distribution is concen-
% trated.
% It is a measure of the skewness of the spectral distribution, the value is larger for right-skewed distributions.
% Music signals, which contain a greater number of higher frequency components tend to have high SRF values.
% see lu2009

% in this implementation, we look at frequency energy

% wl = windowLength (seconds)
% c = percentage for rolloff. Typically .93 (lu2009)

function mC = spectralRollOff(signalMat, fs, threshold)
	if nargin < 3 threshold = 0.93; endif

  numberOfFrames = size(signalMat)(2);
	mC = zeros(1,numberOfFrames);

	for (i = 1 : numberOfFrames)
		window = signalMat(:,i);
		[FFT , xVec] = positiveAbsPartFFT(window, fs,true); % determine FFT of window
		FFT = FFT.^2; % energy
		FFTcum = cumsum(FFT);
		thrVal = threshold * sum (FFT);
		thrIndex = sum(FFTcum<=thrVal) + 1;
		mC(i) = xVec(thrIndex);
	endfor

endfunction
