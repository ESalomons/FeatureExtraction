addpath(genpath("."));

function processSubCategory(subcategory)
  frameTime = 0.050; % s
  overlapTime = 0.025; %s
  basedir = "/Users/etto/Dropbox/Sounds/";
  % basedir = "/Users/etto/Desktop/tp/soundFeatures/";
  targetdir = "result";
  % retrieve human categories
  humanDirs = glob([basedir, subcategory, "/*"]);
  nrDirs = size(humanDirs)(1);
  for dirNr = 1:nrDirs
    dirName = humanDirs{dirNr,1};

    if size(findstr(dirName,".txt")) == 0
      features = [];
      categoryName = strsplit(dirName,"/")(end){1,1};
      targetfile = [targetdir,"/",categoryName,".csv"];
      % retrieve all files for category and transform
      filenames = glob([basedir,subcategory,"/",categoryName,"/*"]);
      for filenum = 1:size(filenames)(1)
        filename = filenames{filenum,1};
        if size(findstr(filename,".wav")) > 0
          fileFeatures = extractFeaturesFromFile(filename,frameTime,overlapTime);
          features = [features,fileFeatures];
        else
          disp(["############## Invalid file: " , filename," ##############"])
        endif
      endfor

      fid = fopen(targetfile,'w');
      disp(["writing: ", targetfile]);
      dlmwrite(fid, features');
      fclose(fid);
    endif
  endfor
endfunction

%%%%%%%%%

processSubCategory("Human");
processSubCategory("objects");
