import csv

classMappings = {}
with open('../result/classMapping.txt','r') as inp:
    for line in inp:
        line = line[:-1] # remove newline
        linelen = len(line)
        i = 0
        while line[i].isdigit():
            i+=1
        classNr = int(line[0:i])
        className = line[i+1:]

        classMappings[classNr] = className

fileMappings = {}
with open('../result/fileMapping.txt','r') as inp:
    for line in inp:
        line = line[:-1] # remove newline
        linelen = len(line)
        i = 0
        while line[i].isdigit():
            i+=1
        fileNr = int(line[0:i])
        fileName = line[i+1:]

        fileMappings[fileNr] = fileName

with open('../result/soundFeatures_lab.csv','w') as outfile:
    with open('../result/soundFeatures.csv','r') as infile:
        reader = csv.DictReader(infile)
        writer = csv.DictWriter(outfile, fieldnames=reader.fieldnames)
        writer.writeheader()
        for row in reader:
            className = classMappings[int(row.get('class'))]
            row['class'] = className
            fileName = fileMappings[int(row.get('filename'))]
            row['filename'] = fileName
            writer.writerow(row)
