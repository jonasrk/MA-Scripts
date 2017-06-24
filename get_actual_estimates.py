import sys

with open("/Users/jonas/MA-Scripts/tmp.txt") as f:
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
    print(key)
    print(all_measurements[key])
    print('\n\n\n')

