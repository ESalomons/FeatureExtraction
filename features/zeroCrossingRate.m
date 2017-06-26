% lu2002, lu2009:
% ZCR correlates with the frequency content of a signal. Human voice consists of voiced
% and unvoiced sounds. The voiced and unvoiced frames have
% low and high ZCR values, respectively. Therefore, human
% voice shows a higher variation of ZCR. Typically, music does
% not have this variation in ZCR,
%
% the variation of ZCR is more discriminative than
% the exact value of ZCR. Therefore, we use high zero-crossing
 % rate ratio (HZCRR) as one feature in our approach.
% HZCRR is defined as the ratio of the number of frames whose
% ZCR are above 1.5-fold average zero-crossing rate in an 1-s
% window
%
% function retVal = zeroCrossingRate(frames)

function retVal = zeroCrossingRate(frames) % frameLength in seconds
	frameSize = size(frames)(1);
	retVal=sum(frames(1:end-1, :).*frames(2:end, :)<0);
	retVal = retVal / frameSize; %normalization
endfunction
