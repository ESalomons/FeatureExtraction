import pandas

# rm_main is a mandatory function,
# the number of arguments has to be the number of input ports (can be none)

# 24 features!!

# def rm_main(data):
# 	data2 = pandas.DataFrame()
# 	data2["class"] = data["class"]
# 	data2.rm_metadata=data.rm_metadata # data2 is needed features
#
# 	features = sorted(list(data.rm_metadata.keys()))
# 	ftGrp = []
# 	gIdx = %{itr} - 1
#
# 	# find all unique keys
# 	keys = []
# 	for feature in features:
# 		# strip all numbers from string
# 		featureKey = ''.join([i for i in feature if not i.isdigit()])
# 		if not featureKey in keys and not 'class' in featureKey:
# 			keys.append(featureKey)
#
# 	with open('%{filePath}classMappings.txt','w') as outp:
# 		for i in range(len(keys)):
# 			outp.write('feature {:d}: {:s}\n'.format(i+1, keys[i]))
#
# 	if gIdx >= len(keys):
# 		raise ValueError('Loop exceeded features number!!')
#
# 	key = keys[gIdx]
# 	print('feature {:d}/{:d}: {:s}'.format(%{itr},len(keys),key))
#
# 	for feature in features:
# 		if key in feature:
# 			data2[feature] = data[feature]
# 	# connect 2 output ports to see the results
# 	return data2

def groups(gIdx):
    # labels = ['zcr', 'ste', 'min', 'max', 'iqr', 'median', 'mean', 'std', 'kurtosis', 'skewness',
    # 	'hzcrr', 'lster', 'shimmer', 'jitter', 'FBase', 'spectralFlux', 'spectralEntropy',
    # 	'spectralCentroid', 'spectralRollOff', 'bandwidth', 'nwpd', 'mfcc', 'lpcc', 'lsp']
    features = ['class', 'zcr', 'ste', 'min', 'max', 'iqr', 'median', 'mean', 'std', 'kurtosis', 'skewness', 'hzcrr', 'lster', 'shimmer', 'jitter', 'FBase', 'spectralFlux', 'spectralEntropy', 'spectralCentroid', 'spectralRollOff', 'bandwidth', 'nwpd', 'mfcc1', 'mfcc2', 'mfcc3', 'mfcc4', 'mfcc5', 'mfcc6', 'mfcc7', 'mfcc8', 'mfcc9', 'mfcc10', 'mfcc11', 'mfcc12', 'mfcc13', 'lpcc1', 'lpcc2', 'lpcc3', 'lpcc4', 'lpcc5', 'lpcc6', 'lpcc7', 'lpcc8', 'lpcc9', 'lpcc10', 'lpcc11', 'lpcc12', 'lsp1', 'lsp2', 'lsp3', 'lsp4', 'lsp5', 'lsp6', 'lsp7', 'lsp8', 'lsp9', 'lsp10', 'lsp11', 'lsp12']

    ftGroups = [
        [ 'zcr','min', 'max', 'iqr', 'median', 'mean', 'std','kurtosis', 'skewness',
            'hzcrr', 'lster', 'shimmer'], # TD
        ['jitter', 'FBase', 'spectralFlux', 'spectralEntropy',
            'spectralCentroid', 'spectralRollOff', 'bandwidth', 'nwpd'], # FD
        ['mfcc'],
        ['lpcc'],
        ['lsp']
    ]

    ftGroup = ftGroups[gIdx]
    for feature in features:
        for ftg in ftGroup:
            if ftg in feature:
                data2[feature] = data[feature]

if __name__ == '__main__':
    for i in range(5):
        groups(i)
