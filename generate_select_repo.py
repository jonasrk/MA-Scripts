import sys, json
import numpy as np
from sklearn.linear_model import LinearRegression


def read_and_process_json(file, print_repository):
    # Read file
    with open(file) as f:
        content = f.readlines()
        content = [x.strip() for x in content]

    all_measurements = {}

    # Parse one json per line
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

    # process every operator key
    for key in all_measurements:
        create_this_key = False

        xdata = []
        ydata = []

        min = sys.float_info.max
        max = 0.0
        max_card = 0

        # for every measurement of this operator
        for i in range(0, len(all_measurements[key]['in'])):
            in_lower_sum = 0
            in_upper_sum = 0
            use_measurement = True

            # sum over the inputs
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

            #sum over the outputs
            for j in range(0, len(all_measurements[key]['out'][i])):
                if all_measurements[key]['out'][i][j]['confidence'] != 1:
                    use_measurement = False
                if all_measurements[key]['out'][i][j]['confidence'] == 1:
                    if all_measurements[key]['out'][i][j]['lowerBound'] < 0 or in_upper_sum + \
                            all_measurements[key]['out'][i][j]['upperBound'] < 0:
                        use_measurement = False
                    out_lower_sum = out_lower_sum + all_measurements[key]['out'][i][j]['lowerBound']
                    out_upper_sum = out_upper_sum + all_measurements[key]['out'][i][j]['upperBound']

            # calculate selectivity
            if use_measurement:
                selectivity = 1.0 * ((out_lower_sum * out_upper_sum)**(1/2)) / ((in_lower_sum * in_upper_sum)**(1/2)  )

                # store min an max selectivity for minmax algorithm
                if selectivity < min:
                    create_this_key = True
                    min = selectivity
                if selectivity > max:
                    max = selectivity

                # calculate geometric mean selectivity for linear regression learning
                xdata.append((in_lower_sum * in_upper_sum)**(1/2)) # TODO JRK: geometric mean right choice? better distinct lower and upper?
                if (in_lower_sum * in_upper_sum)**(1/2) > max_card:
                    max_card = (in_lower_sum * in_upper_sum)**(1/2)
                    all_measurements[key]['max_card'] = max_card
                ydata.append(selectivity)

        all_measurements[key]['xdata'] = xdata
        all_measurements[key]['ydata'] = ydata
        all_measurements[key]['min'] = min
        all_measurements[key]['max'] = max

        # linear regression

        xdata = np.array(xdata)
        ydata = np.array(ydata)

        try:
            predictor = LinearRegression(n_jobs=-1)
            predictor.fit(X=[[x] for x in xdata], y=ydata)

            coefficient = predictor.coef_
            intercept = predictor.intercept_
        except ValueError:
            coefficient = [0.0]
            intercept = [0.0]

        all_measurements[key]['coefficient'] = coefficient
        all_measurements[key]['intercept'] = intercept

        if create_this_key and print_repository:
            print(key + " = {" + '  "p":1, ' + '  "lower":' + str(min) + ',' + '  "upper":' + str(max) + ', "coeff":' + str(all_measurements[key]['coefficient'][0]) + ', "intercept":' + str(all_measurements[key]['intercept']) + '}')

    f.close()


    return all_measurements


def execute_generate_plots(date_id, file_identifier, plot_type):
    import matplotlib.pyplot as plt
    import csv

    for key in all_measurements2: # TODO JRK: This or the other?

        if all_measurements2[key]['coefficient'] != 0.0: # TODO JRK: Why would it?
            my_dpi = 96
            plt.figure(figsize=(2000 / my_dpi, 1500 / my_dpi), dpi=my_dpi)
            plt.title(key)
            ax = plt.gca()

            # the training data
            ax.scatter(all_measurements2[key]['xdata'], all_measurements2[key]['ydata'], c="red", marker=(5, 2))

            # the validation data
            ax.scatter(all_measurements1[key]['xdata'], all_measurements1[key]['ydata'], c="blue", marker='+')
            default_estimator_x = []
            default_estimator_y = []

            # baseline estimates
            with open('/Users/jonas/Google Drive/suite-logs/' + date_id + '/est_cards_baseline-' + date_id + '.csv',
                      'rt') as csvfile:
                spamreader = csv.reader(csvfile, delimiter=';', quotechar='|')
                for row in spamreader:
                    if (row[1].split('-')[0] == key):
                        default_estimator_x.append(
                            (int(row[2].replace(',', '')) * int(row[3].replace(',', ''))) ** (1 / 2))
                        default_estimator_y.append(int(row[5].replace(',', '')) / int(row[2].replace(',', '')) * 1.0)
                        default_estimator_x.append(
                            (int(row[2].replace(',', '')) * int(row[3].replace(',', ''))) ** (1 / 2))
                        default_estimator_y.append(int(row[6].replace(',', '')) / int(row[3].replace(',', '')) * 1.0)
            csvfile.close()
            ax.scatter(default_estimator_x, default_estimator_y, c="green", marker=(3, 2))

            # max value of x axis for function plotting
            max_baseline = 0
            if len(default_estimator_x) > 0:
                max_baseline = max(default_estimator_x)
            max_card = max([all_measurements2[key]['max_card'], all_measurements1[key]['max_card'], max_baseline])

            if plot_type == "linear":
                # the linear function estimator
                x = np.linspace(0, max_card, 100)
                y = x * all_measurements2[key]['coefficient'] + all_measurements2[key]['intercept']
                ax.set_xscale('log')
                plt.plot(x, y, "r--")
            elif plot_type == "minmax":
                x = np.linspace(0, max_card, 100)
                y = 100 * [all_measurements2[key]['min']]
                ax.set_xscale('log')
                plt.plot(x, y, "r--")
                x = np.linspace(0, max_card, 100)
                y = 100 * [all_measurements2[key]['max']]
                ax.set_xscale('log')
                plt.plot(x, y, "r--")

            # save image file
            from os.path import expanduser
            home = expanduser("~")
            plt.savefig(
                home + '/Google Drive/suite-logs/' + date_id + '/' + file_identifier + '-' + date_id + '-' + key + '.png',
                dpi=my_dpi)
            plt.close()


# baseline / validation data
all_measurements1 = read_and_process_json(file=sys.argv[1], print_repository=False)
# training data
all_measurements2 = read_and_process_json(file=sys.argv[2], print_repository=True)

generate_plots=sys.argv[4]

if generate_plots == "generate_plots":
    execute_generate_plots(date_id=sys.argv[3], file_identifier=sys.argv[5], plot_type="logistic")