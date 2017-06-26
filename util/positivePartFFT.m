
function [FFT,freq]=positivePartFFT(signal,Fs,useHamming)
%returns right half (absolute) of FFT with corresponding frequencies
%x is the signal that is to be transformed
%Fs is the sampling rate
	N=length(signal);
  if(size(signal,2) > size(signal,1))
    signal = signal';
  endif
	signal = signal(:,1);
	if(useHamming)
		H = hamming(N);
	else
		H = ones(N, 1);
	endif

	if(rows(signal)<columns(signal))
		H = H';
	endif

	%takes the fft of the signal, and adjusts the amplitude accordingly
	FFT=fft(H.* signal)/N ; % normalize the data
	FFT=fftshift(FFT); %shifts the fft data so that it is centered
	Nfft = length(FFT);
	FFT = FFT(floor(Nfft/2) + 1: Nfft); % only select positive part
	Nfft = length(FFT);
	k = (0:Nfft-1)'/2;
	T= Nfft/(Fs);
	freq=k/T;  %the frequency axis

endfunction
