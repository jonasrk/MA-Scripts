import sys
import numpy as np
from sklearn.linear_model import LinearRegression

# READ FILE

with open(sys.argv[1:][0]) as f:
    content = f.readlines()
    content = [x.strip() for x in content]

nr_items = int(len(content) / 3)
all_measurements = {}

for i in range(0, nr_items):
    key = content[i]
    if key in all_measurements:
        all_measurements[key]['in'].append(int(content[i + nr_items]))
        all_measurements[key]['out'].append(int(content[i + 2 * nr_items]))
    else:
        all_measurements[key] = {}
        all_measurements[key]['in'] = [int(content[i + nr_items])]
        all_measurements[key]['out'] = [int(content[i + 2 * nr_items])]

# for key in all_measurements:
#     print(key)
#     for i in range(0, len(all_measurements[key]['in'])):
#         s = str(all_measurements[key]['in'][i])
#         s = s + ', ' + str(1.0 * all_measurements[key]['out'][i] / all_measurements[key]['in'][i])
#         print(s)

# ADD COEFFICIENT

for key in all_measurements:

    xdata = all_measurements[key]['in']
    ydata = []
    for i in range(0, len(all_measurements[key]['in'])):
        ydata.append(1.0 * all_measurements[key]['out'][i] / all_measurements[key]['in'][i])

    xdata = np.array(xdata)
    ydata = np.array(ydata)

    predictor = LinearRegression(n_jobs=-1)
    predictor.fit(X=[[x] for x in xdata], y=ydata)

    X_TEST = [[200000000]]
    outcome = predictor.predict(X=X_TEST)
    coefficient = predictor.coef_

    all_measurements[key]['coefficient'] = coefficient


for key in all_measurements:
           min = sys.float_info.max
           max = 0.0
           for i in range(0, len(all_measurements[key]['in'])):
               if 1.0 * all_measurements[key]['out'][i] / all_measurements[key]['in'][i] < min:
                   min = 1.0 * all_measurements[key]['out'][i] / all_measurements[key]['in'][i]
               if 1.0 * all_measurements[key]['out'][i] / all_measurements[key]['in'][i] > max:
                   max = 1.0 * all_measurements[key]['out'][i] / all_measurements[key]['in'][i]
           print(key + " = {" + '  "p":1, ' + '  "lower":' + str(min) + ',' + '  "upper":' + str(max) + ', "coeff":' + str(all_measurements[key]['coefficient'][0]) + '}')

