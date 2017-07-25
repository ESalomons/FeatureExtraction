function [features, labels] = extractFeaturesFromFile(sourcefile, frameTime, overlapTime)
  disp(["extracting: ",sourcefile]);
  [wav, fs] = audioread(sourcefile);

  wav = wav(:,1); 				% only one channel;
  wav = wav - mean(wav); 		% center around y axis
  wav = wav / max(abs(wav)); 	% normalized

  frameSize = round(frameTime * fs);
  overlapSize = round(overlapTime * fs);

  frames=buffer(wav, frameSize, overlapSize,'nodelay'); % one frame per column
  longTermTime = 1.0; % seconds
  longTermSize = floor(longTermTime * fs);
  nrLongTermFrames = floor((longTermSize - overlapSize) / (frameSize - overlapSize));

  % create label string; must correspond with features matrix below
  labels = "class,zcr,ste,min,max,iqr,median,mean,std,kurtosis,skewness";
  labels = [labels, ",hzcrr,lster,shimmer,jitter,F0,spectralFlux,spectralEntropy"];
  labels = [labels, ",spectralCentroid,spectralRollOff,bandwidth,nwpd"];
  for i = 1:13
    labels = [labels,sprintf(",mfcc%d",i)];
  endfor
  for i = 1:12
    labels = [labels,sprintf(",lpcc%d",i)];
  endfor
  for i = 1:12
    labels = [labels,sprintf(",lsp%d",i)];
  endfor

  % disp(labels);

  % features matrix must correspond with labels string
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
      hzcrr(frames, nrLongTermFrames);
      lster(frames, nrLongTermFrames);
      shimmer(frames,nrLongTermFrames);
      jitter(frames, fs, nrLongTermFrames);
      fundamentalFreq(frames,fs);
      % SpectralFlux(wav,frameSize, overlapSize, fs);
      SpectralFlux(frames,fs);
      SpectralEntropy(frames,fs);
      spectralCentroid(frames,fs);
      spectralRollOff(frames,fs);
      bandwidth(frames,fs);
      normalizedWeightedPhaseDeviation(frames,fs);
      mfcc(frames,fs);
      lpcc(frames);
      lsp(frames);
      ];

  featureDims = size(features);
  disp(sprintf("features: %d; frames: %d",featureDims(1),featureDims(2)));

endfunction
