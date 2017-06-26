%Normalized Weighted Phase Deviation. This feature shows the phase deviations of the
%frequency bins in the spectrum weighted by their magnitude,
% Usually the ambient sound and music will have a smaller phase devation than voice.

% see lu2009 and dixon2006;

% NWPD = sum(|p(i)*ph''(i)|) / sum(p(i))  ; the normalization is not done by lu!!!
% absolute value also not done by lu; this is Dixon's variation
% i = freq; p(i) = abs value of freq. i; ph(i) = phase of freq. i; ph'' is second derivative
%
% wl = windowLength (seconds)

function mC = normalizedWeightedPhaseDeviation(signalMat, fs)
	numberOfFrames = size(signalMat)(2);
	mC = zeros(1,numberOfFrames);

	for (i = 1 : numberOfFrames)
		window = signalMat(:,i);
		[FFT , xVec] = positivePartFFT(window, fs,true); % determine FFT of window

		phase = angle(FFT);
		diffx = diff(xVec);
		phaseDer = diff(phase)./diffx;
		phaseDer2 = diff(phaseDer)./diffx(2:length(diffx));
		%result is 2 numbers shorter than original; discard first and last sample

		mC(i) = sum((abs(FFT)(2:length(FFT)-1)).*abs(phaseDer2))/sum(abs(FFT));
	endfor

endfunction
