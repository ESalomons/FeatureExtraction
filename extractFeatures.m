addpath(genpath("."));

function [featureMatrix,labels,classNames,fileCount, filelist] = processSubCategory(...
                                      subcategory,classNames,fileCount)
  frameTime = 0.050; % s
  overlapTime = 0.025; %s
  basedir = "/Users/etto/Dropbox/Sounds/truncated/";
  % basedir = "/Users/etto/Desktop/tp/soundFeatures/small/";
  % basedir = "/Volumes/SAA_DATA/datasets/coopProject/selection/";
  % basedir = "/Volumes/SAA_DATA/datasets/coopProject/selectionNoSilence_th0.10_mst0.01/";
  % basedir = "/Users/etto/Dropbox/Sounds/truncatedNoSilence/";
  % basedir = "/Users/etto/Desktop/tpSounds/";
  featureMatrix = [];
  filelist = [];

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
          filelist = [filelist;strsplit(filename,"/")(end){1,1}];
          fileCount += 1;
          [fileFeatures, labels] = extractFeaturesFromFile(filename,frameTime,overlapTime);
          if size(fileFeatures)(1) > 2
            % uncomment next two lines to use fewer samples per file
            % minAmount = min(size(fileFeatures)(2), 20);
            % fileFeatures = fileFeatures(:,1:minAmount);
            % add class number
            fileFeatures = [ones(1,size(fileFeatures)(2))*fileCount; ...
                            ones(1,size(fileFeatures)(2))*classNr;fileFeatures];
            % append to existing frames
            featureMatrix = [featureMatrix,fileFeatures];
          endif
        else
          disp(["############## Invalid file: " , filename," ##############"])
        endif
      endfor
    endif

  endfor
endfunction

%%%%%%%%%
classNames = {};
fileCount = 0;
[ftMat1,labels,classNames,fileCount,filenames1] = processSubCategory("Human",classNames,fileCount);
[ftMat2, labels,classNames,fileCount,filenames2] = processSubCategory("objects",classNames,fileCount);

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

fid = fopen("result/fileMapping.txt","w");
filenames = cellstr([filenames1;filenames2]);
for i = 1:fileCount
  fprintf(fid, "%d %s\n",i, filenames{i});
endfor

fclose(fid);

system("cd python && python replaceClassnames.py");
