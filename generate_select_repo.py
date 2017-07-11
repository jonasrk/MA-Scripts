import sys, json
import numpy as np
from sklearn.linear_model import LinearRegression

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
                key = selectivityKey.split('-')[0]
                if key not in all_measurements:
                    all_measurements[key] = {}
                    all_measurements[key]['in'] = []
                    all_measurements[key]['out'] = []
                all_measurements[key]['in'].append(execGroup['ctx']['inCards'])
                all_measurements[key]['out'].append(execGroup['ctx']['outCards'])

for key in all_measurements:

    create_this_key = False

    xdata = []
    ydata = []

    min = sys.float_info.max
    max = 0.0

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
            selectivity = 1.0 * out_lower_sum / in_lower_sum
            if selectivity < min:
                create_this_key = True
                min = selectivity
            if selectivity > max:
                max = selectivity
            selectivity = 1.0 * (out_lower_sum * out_upper_sum)**1/2 / (in_lower_sum * in_upper_sum)**1/2
            xdata.append((in_lower_sum * in_upper_sum)**1/2) # TODO JRK: geometric mean right choice? better distinct lower and upper?
            ydata.append(selectivity)

    xdata = np.array(xdata)
    ydata = np.array(ydata)

    try:
        predictor = LinearRegression(n_jobs=-1)
        predictor.fit(X=[[x] for x in xdata], y=ydata)

        coefficient = predictor.coef_
    except ValueError:
        coefficient = 0.0

    all_measurements[key]['coefficient'] = coefficient

    if create_this_key:
        print(key + " = {" + '  "p":1, ' + '  "lower":' + str(min) + ',' + '  "upper":' + str(max) + ', "coeff":' + str(all_measurements[key]['coefficient']) + '}')

