clear all;
% @filename: name of file including full path, without .wav
% @thr threshold value for file (everything below threshold is
%   considered possible silence
% @nrSilenceVals nr of consecutive values below threshold that are
%   considered to be silence
function stripSilence(filename, nwFilename, thr, minSilenceTime)
  [samples, fs,] = audioread(filename);
  nrSilenceVals = round(minSilenceTime * fs);
  printf('Writing %s...\n', nwFilename);
  samples2 = [];

  i = 1;
  while i <= length(samples) - nrSilenceVals + 1
    if sum(abs(samples(i:i+nrSilenceVals-1))>thr) == 0
      i = i + nrSilenceVals;
    else
      samples2 = [samples2, samples(i)];
      i = i + 1;
    endif
  endwhile
  if length(samples2) > 1
    audiowrite(nwFilename, samples2, fs);
  else
    disp("nothing left in file...");
  endif
  printf('done\n');
endfunction

function stripSilenceFromCategory(subcategory, basedir, targetDir, threshold, minSilenceTime)
  mkdir(targetDir,subcategory);
  targetSubCatDir = [targetDir, subcategory, "/"];
  % retrieve categories
  subdirs = glob([basedir, subcategory, "/*"]);
  nrDirs = size(subdirs)(1);
  for dirNr = 1:nrDirs
    dirName = subdirs{dirNr,1};

    if size(findstr(dirName,".txt")) == 0
      % add className to list
      className = strsplit(dirName,"/")(end){1,1};
      classDir = [targetSubCatDir, className, "/"];
      mkdir(targetSubCatDir, className);

      % retrieve all files for category and transform
      filenames = glob([dirName,"/*"]);
      for filenum = 1:size(filenames)(1)
        filename = filenames{filenum,1};
        if size(findstr(filename,".wav")) > 0
          fileShort = strsplit(filename,"/")(end){1,1};
          targetFile = [classDir, fileShort];
          stripSilence(filename, targetFile, threshold, minSilenceTime);
        else
          disp(["############## Invalid file: " , filename," ##############"])
        endif
      endfor
    endif

  endfor
endfunction


threshold = 0.1;
minSilenceTime = 0.010;

basedir = "/Users/etto/Dropbox/Sounds/truncated/";
targetDir = "/Users/etto/Dropbox/Sounds/truncatedNoSilence/";

% basedir = "/Users/etto/Desktop/tp/soundFeatures/small/";

basedir = "/Volumes/SAA_DATA/datasets/coopProject/selection/";
% basedir = "/Volumes/SAA_DATA/datasets/coopProject/smallSelection/";
targetDir = sprintf("/Volumes/SAA_DATA/datasets/coopProject/selectionNoSilence_th%.2f_mst%.2f/", threshold, minSilenceTime);

confirm_recursive_rmdir(false);
rmdir(targetDir,"s");
mkdir(targetDir);

subcategory = "objects";
stripSilenceFromCategory(subcategory, basedir, targetDir, threshold, minSilenceTime);
subcategory = "Human";
stripSilenceFromCategory(subcategory, basedir, targetDir, threshold, minSilenceTime);
