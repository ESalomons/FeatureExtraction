function [features, labels] = extractFeaturesFromFile(sourcefile, frameTime, overlapTime)
  disp(["extracting: ",sourcefile]);
  [wav, fs] = audioread(sourcefile);

  wav = wav(:,1); 				% only one channel;
  wav = wav - mean(wav); 		% center around y axis
  wav = wav / max(abs(wav)); 	% normalized

  frameSize = round(frameTime * fs);
  overlapSize = round(overlapTime * fs);

  frames=buffer(wav, frameSize, overlapSize,'nodelay'); % one frame per column

  % create label string
  labels = "class,zcr,ste,min,max,iqr,median,mean,std,kurtosis,skewness";
  for i = 1:13
    labels = [labels,sprintf(",mfcc%d",i)];
  endfor
  labels = [labels, ",spectralCentroid,spectralRollOff,bandwidth,nwpd"];

  features = [
      zeroCrossingRate(frames);
      shortTimeEnergy(frames);
      min(frames);
      max(frames);
      iqr(frames);
      median(frames);
      mean(frames);
      std(frames);
      kurtosis(frames);
      skewness(frames);
      mfcc(frames,fs);
      spectralCentroid(frames,fs);
      spectralRollOff(frames,fs);
      bandwidth(frames,fs);
      normalizedWeightedPhaseDeviation(frames,fs)
      ];

  featureDims = size(features);
  disp(sprintf("features: %d; frames: %d",featureDims(1),featureDims(2)));

endfunction
