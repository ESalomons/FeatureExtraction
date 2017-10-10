

def doMain():
    combineForType('svm')
    # combineForType('knn')
    # combineForType('nb')
    # combineForType('dt')

def combineForType(algType):
    perfIndex = 0
    execTimeIndex = 1
    itrIndex = 2
    if algType == 'knn':
        execTimeIndex += 2
        itrIndex += 2
    resultDir = '/Users/etto/Desktop/tp/rapidminer/v2/'
    targetPath = '/Users/etto/Dropbox/AMI/Promotie/octave/1.src/environmentRec/python/results'
    resultDir += algType
    numResults = 31

    items = []
    with open(targetPath + '/' + algType + '_results.txt','w') as outp:

        for i in range(1,numResults + 1):
            with open(resultDir + '/performance-{:d}.log'.format(i),'r') as inp:
                inp.readline()
                inp.readline()
                splt = inp.readline()[:-1].split('\t')
                items.append((float(splt[perfIndex]),float(splt[execTimeIndex]),int(splt[itrIndex])))

        outp.write('Sorted by index\n')
        writeItems(outp,items)
        outp.write('\n\n')
        outp.write('Sorted by performance\n')
        writeItems(outp,sorted(items,reverse=True))

def writeItems(outp, items):
    outp.write('#idx\tperf\t(exec_time)\n')
    for item in items:
        outp.write('{:d}\t\t{:.4f}\t({:.0f})\n'.format(item[2],item[0],item[1]))


if __name__ == '__main__':
    doMain()
