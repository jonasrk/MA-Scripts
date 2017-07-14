import sys, json
import numpy as np
import matplotlib.pyplot as plt

# READ FILE
with open(sys.argv[1:][0]) as f:
    content = f.readlines()
    content = [x.strip() for x in content]

all_measurements = {}

for line in content:
    parsed = json.loads(line)
    for execGroup in parsed['execGroups']:
        if ('selectivityKey' in execGroup['ctx']):
            selectivityKey = execGroup['ctx']['selectivityKey']
            if ('my.udf.' in selectivityKey):
                if selectivityKey not in all_measurements:
                    all_measurements[selectivityKey] = {}
                    all_measurements[selectivityKey]['in'] = []
                    all_measurements[selectivityKey]['out'] = []
                all_measurements[selectivityKey]['in'].append(execGroup['ctx']['inCards'])
                all_measurements[selectivityKey]['out'].append(execGroup['ctx']['outCards'])

print("operator" + ";" + "dataset" + ";" + "in_lower_sum"  + ";" + "in_upper_sum" + ";" + "out_lower_sum" + ";" + "out_upper_sum")

for key in all_measurements:
    create_this_key = False

    xdata = []
    ydata = []

    min = sys.float_info.max
    max = 0.0
    max_card = 0

    for i in range(0, len(all_measurements[key]['in'])):
        in_lower_sum = 0
        in_upper_sum = 0
        use_measurement = True
        for j in range(0, len(all_measurements[key]['in'][i])):
            if all_measurements[key]['in'][i][j]['confidence'] != 1:
                use_measurement = False
            if all_measurements[key]['in'][i][j]['confidence'] == 1:
                if all_measurements[key]['in'][i][j]['lowerBound'] < 0 or in_upper_sum + \
                        all_measurements[key]['in'][i][j]['upperBound'] < 0:
                    use_measurement = False
                in_lower_sum = in_lower_sum + all_measurements[key]['in'][i][j]['lowerBound']
                in_upper_sum = in_upper_sum + all_measurements[key]['in'][i][j]['upperBound']
        out_lower_sum = 0
        out_upper_sum = 0
        for j in range(0, len(all_measurements[key]['out'][i])):
            if all_measurements[key]['out'][i][j]['confidence'] != 1:
                use_measurement = False
            if all_measurements[key]['out'][i][j]['confidence'] == 1:
                if all_measurements[key]['out'][i][j]['lowerBound'] < 0 or in_upper_sum + \
                        all_measurements[key]['out'][i][j]['upperBound'] < 0:
                    use_measurement = False
                out_lower_sum = out_lower_sum + all_measurements[key]['out'][i][j]['lowerBound']
                out_upper_sum = out_upper_sum + all_measurements[key]['out'][i][j]['upperBound']
        if use_measurement:
            print(key.split('-')[0] + ";" + key[len(key.split('-')[0]) + 1:] + ";" + str(in_lower_sum)  + ";" + str(in_upper_sum) + ";" + str(out_lower_sum) + ";" + str(out_upper_sum))
