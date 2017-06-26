
function [FFT,freq]=positiveAbsPartFFT(signal,Fs,useHamming)
%returns right half (absolute) of FFT with corresponding frequencies
%x is the signal that is to be transformed
%Fs is the sampling rate
	
	[FFT, freq] = positivePartFFT(signal, Fs, useHamming);
	FFT = abs(FFT);
	
endfunction
