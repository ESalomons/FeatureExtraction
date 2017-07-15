addpath(genpath("."));

function [featureMatrix,labels,classNames] = processSubCategory(subcategory,classNames)
  frameTime = 0.050; % s
  overlapTime = 0.025; %s
  basedir = "/Users/etto/Dropbox/Sounds/truncated/";
  % basedir = "/Users/etto/Desktop/tp/soundFeatures/small/";
  featureMatrix = [];

  % retrieve categories
  subdirs = glob([basedir, subcategory, "/*"]);
  nrDirs = size(subdirs)(1);
  for dirNr = 1:nrDirs
    dirName = subdirs{dirNr,1};

    if size(findstr(dirName,".txt")) == 0
      % add className to list
      classNames = [classNames, strsplit(dirName,"/")(end){1,1}];
      classNr = size(classNames)(2);

      % retrieve all files for category and transform
      filenames = glob([dirName,"/*"]);
      for filenum = 1:size(filenames)(1)
        filename = filenames{filenum,1};
        if size(findstr(filename,".wav")) > 0
          [fileFeatures, labels] = extractFeaturesFromFile(filename,frameTime,overlapTime);
          % add class number
          fileFeatures = [ones(1,size(fileFeatures)(2))*classNr;fileFeatures];
          % append to existing frames
          featureMatrix = [featureMatrix,fileFeatures];
        else
          disp(["############## Invalid file: " , filename," ##############"])
        endif
      endfor
    endif

  endfor
endfunction

%%%%%%%%%
classNames = {};
[ftMat1,labels,classNames] = processSubCategory("Human",classNames);
[ftMat2, labels,classNames] = processSubCategory("objects",classNames);

featureMatrix = [ftMat1, ftMat2];

% write results
fid = fopen("result/soundFeatures.csv",'w');
fdisp(fid,labels);
dlmwrite(fid, featureMatrix');
fclose(fid);

fid = fopen("result/classMapping.txt","w");
for i = 1:size(classNames)(2)
  fprintf(fid,"%d %s\n",i,classNames{1,i});
endfor
fclose(fid);
