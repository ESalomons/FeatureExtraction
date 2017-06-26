# see lu2002, lu2009
# LSTER is an effective feature, especially for discriminating
# speech and music signals. In general, there are more silence
# frames in speech than in music; as a result, the LSTER measure
# of speech will be much higher than that of music.
### calculates short-time energy for frames of length frameLength
### sampling frequency = fs

function retVal = shortTimeEnergy(frameMat)
		retVal=mean(frameMat(1:end, :).^2);
endfunction
