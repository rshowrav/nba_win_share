import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as sts
from sklearn.linear_model import LinearRegression
import statsmodels.formula.api as smf
import datetime

def build_lm(target, ind_vars, df):
    temp_str = target + ' ~ '
    for i in range(0, len(ind_vars)):
        temp_str = temp_str + ' + ' + ind_vars[i]

    lm = smf.ols(temp_str, df).fit()

    # Assess Homoscedasticity
    plt.scatter(lm.fittedvalues, lm.resid)
    plt.xlabel('Predicted/Fitted Values')
    plt.ylabel('Residual Values')
    plt.title('Assessing Homoscedasticity')
    plt.plot([(min(lm.fittedvalues)-5), (max(lm.fittedvalues)+5)], [0, 0], 'red', lw=2)
    plt.show()

    # Independence
    print('Independence Test')
    print(lm.summary())

    # Normal Distribution
    sts.probplot(lm.resid, dist="norm", plot=plt)
    plt.show()
    print('Shapiro Wilks P-Value ' + str(sts.shapiro(lm.resid).pvalue) + '\n')

    # Assumption Validation loop
    for (colNames, colData) in df.iteritems():
        if colNames in ind_vars:
            # Linearity
            df.plot.scatter(y=target, x=colNames)
            plt.title(colNames + ' vs ' + target)
            plt.show()
            # collinear
            temp = ind_vars.copy()
            temp.remove(colNames)
            lm_temp = LinearRegression(fit_intercept=True, normalize=True).fit(df[temp], df[colNames])
            vif = 1 / (1 - lm_temp.score(df[temp], df[colNames]))
            print('VIF: ' + colNames + " = " + str(vif))

    return lm

if __name__ == '__main__':
    final_data = pd.read_csv(r'C:\Users\laggi\Desktop\DATA\final_data.csv')
    ind = ['games_played', 'player_efficiency_rating', 'offensive_plus_minus',
           'value_over_replace_player', 'three_pointer_made_per_game', 'three_pointer_attempts_per_game'
        , 'two_pointer_made_per_game', 'two_pointer_attempts_per_game', 'free_throw_made_per_game',
           'free_throw_attempts_per_game', 'defensive_rebound_per_game', 'assists_per_game', 'steals_per_game',
           'turnovers_per_game', 'points_per_game', 'position_PF', 'position_PG', 'position_SF', 'position_SG',
           'conference_WEST', 'starter']
    lr = build_lm('win_shares', ind, final_data)