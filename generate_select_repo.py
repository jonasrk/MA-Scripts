import sys

with open("/home/jonas.kemper/MA-Scripts/extracted_udf_cards.txt") as f:
    content = f.readlines()
    # you may also want to remove whitespace characters like `\n` at the end of each line
    content = [x.strip() for x in content]
nr_items = len(content)/3
all_measurements = {}
for i in range(0, nr_items):
	key = content[i]
	if key in all_measurements:
		all_measurements[key]['in'].append(int(content[i+nr_items]))
		all_measurements[key]['out'].append(int(content[i+2*nr_items]))
	else:
		all_measurements[key] = {}
		all_measurements[key]['in'] = [int(content[i+nr_items])]
		all_measurements[key]['out'] = [int(content[i+2*nr_items])]

for key in all_measurements:
	#print(key + " = {\\")
	#print('  "p":1,\\ ')
	min = sys.float_info.max
	max = 0.0
	for i in range(0, len(all_measurements[key]['in'])):
		if 1.0 * all_measurements[key]['out'][i] / all_measurements[key]['in'][i] < min:
			min = 1.0 * all_measurements[key]['out'][i] / all_measurements[key]['in'][i]
		if 1.0 * all_measurements[key]['out'][i] / all_measurements[key]['in'][i] > max:
			max = 1.0 * all_measurements[key]['out'][i] / all_measurements[key]['in'][i]
	#print('  "lower":' + str(min) + ',\\')
	#print('  "upper":' + str(max) + ',\\')
	#print('}')
	print(key + " = {" + '  "p":1, ' + '  "lower":' + str(min) + ',' + '  "upper":' + str(max) + ',' + '}')

